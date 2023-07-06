import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

import '../model/stats.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  GyroscopeEvent? latestGyroscopeEvent;
  UserAccelerometerEvent? latestAccelerometerEvent;
  bool isDelayActive = false;
  bool landed = false;
  int count = 0;
  double radX = 0;
  double radY = 0;
  double radZ = 0;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      latestGyroscopeEvent = event;
    });

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      latestAccelerometerEvent = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    var stats = Provider.of<Stats>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Touch the screen and flip the phone!"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: GestureDetector(
        onTap: phoneThrown,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Phone flips X: ${stats.getFlipX()}",
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
                Text(
                  "Phone flips Y: ${stats.getFlipY()}",
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
                Text(
                  "Phone flips Z: ${stats.getFlipZ()}",
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> phoneThrown() async {
    var stats = Provider.of<Stats>(context, listen: false);
    if (isDelayActive) return;
    isDelayActive = true;
    Stopwatch().start();

    while (!landed) {
      await Future.delayed(const Duration(milliseconds: 10));

      if (latestGyroscopeEvent != null) {
        radX += roundDouble(latestGyroscopeEvent!.x, 3).abs();
        radY += roundDouble(latestGyroscopeEvent!.y, 3).abs();
        radZ += roundDouble(latestGyroscopeEvent!.z, 3).abs();
      }

      landed = checkLanded(count);
      count++;
    }
    isDelayActive = true;

    Stopwatch().stop();
    double elapsedSeconds = Stopwatch().elapsedMilliseconds / 1000;
    stats.flipX = (radX * elapsedSeconds / (count * pi * 2)).round();
    stats.flipY = (radY * elapsedSeconds / (count * pi * 2)).round();
    stats.flipZ = (radZ * elapsedSeconds / (count * pi * 2)).round();

    Vibration.vibrate(duration: 500 * stats.getTotalFlips());
    setState(() {});

    Timer(const Duration(seconds: 3), () { isDelayActive = false; });
  }

  bool checkLanded(int count) {
    if (count > 100) {
      if (latestGyroscopeEvent != null &&
          latestGyroscopeEvent!.x.abs() +
                  latestGyroscopeEvent!.y.abs() +
                  latestGyroscopeEvent!.z.abs() <=
              1) {
        if (latestAccelerometerEvent != null &&
            roundDouble(latestAccelerometerEvent!.x, 1) +
                    roundDouble(latestAccelerometerEvent!.y, 1) +
                    roundDouble(latestAccelerometerEvent!.z, 1) ==
                0) {
          return true;
        }
      }
    }
    return false;
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
