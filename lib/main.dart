import 'dart:async';

import 'package:analog_clock/components/clock_view.dart';
import 'package:analog_clock/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  Timer? _everySec;

  Future<DateTime> fetchClock() async {
    now = DateTime.now();
    return now;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _everySec = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /* getting time */

    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TimerBuilder.periodic(
              Duration(seconds: 1),
              builder: (context) {
                //getting the time
                String second = DateTime.now().second < 10
                    ? "0${DateTime.now().second}"
                    : DateTime.now().second.toString();
                String minute = DateTime.now().minute < 10
                    ? "0${DateTime.now().minute}"
                    : DateTime.now().minute.toString();
                String hour = DateTime.now().hour < 10
                    ? "0${DateTime.now().hour}"
                    : DateTime.now().hour.toString();
                return Column(
                  children: [
                    Text(
                      "${hour}:${minute}:${second}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ClockView(DataTime(DateTime.now().hour,
                        DateTime.now().minute, DateTime.now().second)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
