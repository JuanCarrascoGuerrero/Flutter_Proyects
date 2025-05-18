import 'dart:async';

import 'package:animals/view/dashboard.dart';
import 'package:animals/view/demo1.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool accepted = false;

  Future<bool> _hasAcceptedPolicy() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("ppd") ?? false;
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      _checkPolicy();
    });
    super.initState();
  }

  void _checkPolicy() async {
    bool accepted = await _hasAcceptedPolicy();
    Timer(Duration(seconds: 3), () {
      if (accepted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Demo()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/logo.png",
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 2,
            ),
            Lottie.asset(
              "assets/json/paws.json",
              width: MediaQuery.sizeOf(context).width / 4,
              height: MediaQuery.sizeOf(context).height / 4,
            ),
          ],
        ),
      ),
    );
  }
}
