import 'package:flutter/material.dart';
import 'stopwatch.dart';
import 'login.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) => Login(),
        Login.route: (context) => Login(),
        StopWatch.route: (context) => StopWatch( email: "", name: '',),
      },
      initialRoute: '/',
    );
  }
}