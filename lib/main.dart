
import 'package:flutter/material.dart';
import 'package:stopwatch/starting_screen.dart';

void main() {
  runApp(const Stopwatch());
}

class Stopwatch extends StatelessWidget {
  const Stopwatch({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      title: "Stopwatch",
    debugShowCheckedModeBanner: false,
      home: StartingScreen(),
    );
  }
}
