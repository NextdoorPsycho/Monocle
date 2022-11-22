/*
 * Copyright (c) 2022.. MyGuide
 *
 * MyGuide is a closed source project developed by Arcane Arts.
 * Do not copy, share, distribute or otherwise allow this source file
 * to leave hardware approved by Arcane Arts unless otherwise
 * approved by Arcane Arts.
 */

import 'package:delayed_progress_indicator/delayed_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/sugar.dart';

String? splashRouteTo;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 25), () {
      if (authService().isSignedIn()) {
        userService().bind(userService().uid()).then((value) {
          Navigator.pushNamedAndRemoveUntil(ctx(), "/", (route) => false);

          if ((splashRouteTo ?? "/") != "/") {
            Get.toNamed(splashRouteTo ?? "/");
          }
        });
      } else {
        Navigator.pushNamedAndRemoveUntil(ctx(), "/login", (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: SizedBox(
      width: 100,
      height: 100,
      child: DelayedProgressIndicator(),
    )));
  }
}
