import 'dart:async';

import 'package:animals/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessTransaction extends StatefulWidget {
  const SuccessTransaction({super.key});

  @override
  State<SuccessTransaction> createState() => _SuccessTransactionState();
}

class _SuccessTransactionState extends State<SuccessTransaction> {
@override
  void initState() {
    Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Menu()));});
    super.initState();
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