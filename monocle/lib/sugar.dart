import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/services/auth_service.dart';
import 'package:monocle/services/magic_service.dart';
import 'package:monocle/services/user_service.dart';
import 'package:provider/provider.dart';

BuildContext? tempContext;

BuildContext ctx() => (Get.context ?? tempContext)!;

AuthService authService() => ctx().read<AuthService>();

MagicService magicService() => ctx().read<MagicService>();

UserService userService() => ctx().read<UserService>();

void toast(String message) =>
    ScaffoldMessenger.of(ctx()).showSnackBar(SnackBar(content: Text(message)));

abstract class MonocleService {
  void onServiceBind();
}

extension XWidget on Widget {
  Widget center() => Center(child: this);
}
