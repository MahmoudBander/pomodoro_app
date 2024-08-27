// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: CounterDownApp(),
    );
  }
}

class CounterDownApp extends StatefulWidget {
  const CounterDownApp({super.key});

  @override
  State<CounterDownApp> createState() => _CounterDownAppState();
}

class _CounterDownAppState extends State<CounterDownApp> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);
  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          duration = Duration(minutes: 25);
          isRuning = false;
        }
      });
    });
  }

  bool isRuning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 40, 43),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 65, 71),
        title: Text(
          "Pomodoro App ",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 140.0,
                  progressColor: Color.fromARGB(255, 255, 85, 113),
                  backgroundColor: Colors.grey,
                  lineWidth: 8.0,
                  percent: duration.inMinutes/25,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                  center: Text(
                    "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")} :${duration.inSeconds.remainder(60).toString().padLeft(2, "0")} ",
                    style: TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            isRuning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (repeatedFunction!.isActive) {
                            setState(() {
                              repeatedFunction!.cancel();
                            });
                          } else {
                            startTimer();
                          }
                        },
                        child: Text(
                          (repeatedFunction!.isActive)
                              ? "STOP TIMER"
                              : "REsume",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 241, 89, 78)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(14.0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)))),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          repeatedFunction!.cancel();
                          setState(() {
                            duration = Duration(minutes: 25);
                            isRuning = false;
                          });
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 241, 89, 78)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(14.0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)))),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRuning = true;
                      });
                    },
                    child: Text(
                      "Start Studying",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 25, 120, 197)),
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(14.0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)))),
                  )
          ],
        ),
      ),
    );
  }
}
