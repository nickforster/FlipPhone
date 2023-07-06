import 'package:flipphone/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/stats.dart';

void main() {
  Stats stats = Stats(0, 0, 0);
  runApp(FlipPhoneApp(stats));
}

class FlipPhoneApp extends StatelessWidget {
  final Stats stats;

  const FlipPhoneApp(this.stats, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => stats,
      child: MaterialApp(
        title: 'FlipPhone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}