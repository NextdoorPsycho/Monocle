import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/sugar.dart';
import 'package:monocle/util/generated/assets.gen.dart';
import 'package:padded/padded.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () =>
                      authService().signInWithGoogle().then((value) {
                        userService()
                            .bind(userService().uid())
                            .then((value) => Get.offAndToNamed("/"));
                      }),
                  backgroundColor: Colors.white,
                  label: const Text(
                    "Sign in with Google",
                    style: TextStyle(color: Colors.black54),
                  ),
                  icon: Assets.logo.google.svg(width: 32, height: 32)),
              PaddingTop(padding: 14, child: Container()),
              Visibility(
                visible: GetPlatform.isIOS,
                child: FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () =>
                        authService().signInWithApple().then((value) {
                          userService()
                              .bind(userService().uid())
                              .then((value) => Get.offAndToNamed("/"));
                        }),
                    backgroundColor: Colors.white,
                    label: const Text(
                      "Sign in with Apple",
                      style: TextStyle(color: Colors.black54),
                    ),
                    icon: Assets.logo.apple.svg(width: 32, height: 32)),
              ),
            ],
          ),
        ),
      );
}
