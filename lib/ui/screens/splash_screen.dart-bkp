import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.notificationbyApp = false})
      : super(key: key);
  final bool notificationbyApp;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? notificationbyApp;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacementNamed(context, '/homepage'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                HexColor("#3b29a1"),
                HexColor("#ab3c90"),
              ],
            )),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Image.asset(
                        'assets/images/radio_logo.png',
                        width: 200,
                        height: 200,
                      )),
                ],
              ),
            )));
  }
}
