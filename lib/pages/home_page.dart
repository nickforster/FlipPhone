import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/stats.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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

  void phoneThrown() {}
}
