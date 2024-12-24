import 'dart:async';

import 'package:budget_tracking_app/Home/Controller/Home_Controller.dart';
import 'package:budget_tracking_app/Home/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Splacescreen extends StatelessWidget {
  const Splacescreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(Duration(seconds: 5), (timer) {
    //   Get.to(BudgetHomePage());
    // },);
    return Scaffold(
      body: Container(
        height: 1000,
        width: 500,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("Assest/image/Screenshot 2024-12-24 094838.png"),fit: BoxFit.cover,)
        ),
      ),
    );
  }
}
