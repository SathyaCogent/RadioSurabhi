import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'dart:async';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: Image.asset(
                      'assets/images/radio_logo.png',
                      width: 200,
                      height: 200,
                    )),
                Container(
                    alignment: Alignment.bottomCenter,
                    child: const BarLoadingScreen()),
              ],
            )));
  }
}

class BarLoadingScreen extends StatefulWidget {
  const BarLoadingScreen({Key? key}) : super(key: key);

  @override
  _BarLoadingScreenState createState() => _BarLoadingScreenState();
}

class _BarLoadingScreenState extends State<BarLoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.repeat().orCancel;
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Tween<double> tween = Tween<double>(begin: 0.0, end: 1.00);
  Animation<double> get stepOne => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.0,
            0.125,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepTwo => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.125,
            0.26,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepThree => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.25,
            0.375,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepFour => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.375,
            0.5,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepFive => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.5,
            0.625,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepSix => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.625,
            0.75,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepSeven => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.75,
            0.875,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepEight => tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.875,
            1.0,
            curve: Curves.linear,
          ),
        ),
      );

  Widget get forwardStaggeredAnimation {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PivotBar(
            alignment: FractionalOffset.centerLeft,
            controller: _controller,
            animations: [
              stepOne,
              stepTwo,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: true,
          ),
          PivotBar(
            controller: _controller,
            animations: [
              stepThree,
              stepEight,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: false,
          ),
          PivotBar(
            controller: _controller,
            animations: [
              stepFour,
              stepSeven,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: true,
          ),
          PivotBar(
            controller: _controller,
            animations: [
              stepFive,
              stepSix,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: false,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: forwardStaggeredAnimation);
  }
}

class Bar extends StatelessWidget {
  final double marginLeft;
  final double marginRight;
  const Bar({Key? key, required this.marginLeft, required this.marginRight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.0,
      height: 15.0,
      margin: EdgeInsets.only(left: marginLeft, right: marginRight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(1.0, 0.0),
          ),
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            spreadRadius: 1.5,
            offset: Offset(1.0, 0.0),
          ),
        ],
      ),
    );
  }
}

class PivotBar extends AnimatedWidget {
  final Animation<double> controller;
  final FractionalOffset alignment;
  final List<Animation<double>> animations;
  final bool isClockwise;
  final double marginLeft;
  final double marginRight;

  const PivotBar({
    Key? key,
    this.alignment = FractionalOffset.centerRight,
    required this.controller,
    required this.animations,
    required this.isClockwise,
    this.marginLeft = 15.0,
    this.marginRight = 0.0,
  }) : super(key: key, listenable: controller);

  Matrix4 clockwiseHalf(animation) =>
      Matrix4.rotationZ((animation.value * math.pi * 2.0) * .5);
  Matrix4 counterClockwiseHalf(animation) =>
      Matrix4.rotationZ(-(animation.value * math.pi * 2.0) * .5);

  @override
  Widget build(BuildContext context) {
    var transformOne;
    var transformTwo;
    if (isClockwise) {
      transformOne = clockwiseHalf(animations[0]);
      transformTwo = clockwiseHalf(animations[1]);
    } else {
      transformOne = counterClockwiseHalf(animations[0]);
      transformTwo = counterClockwiseHalf(animations[1]);
    }

    return Transform(
      transform: transformOne,
      alignment: alignment,
      child: Transform(
        transform: transformTwo,
        alignment: alignment,
        child: Bar(marginLeft: marginLeft, marginRight: marginRight),
      ),
    );
  }
}
