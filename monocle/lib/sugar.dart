import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/services/auth_service.dart';
import 'package:monocle/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:scryfall_api/scryfall_api.dart';

final ScryfallApiClient mtg = ScryfallApiClient();
BuildContext? tempContext;

BuildContext ctx() => (Get.context ?? tempContext)!;

AuthService authService() => ctx().read<AuthService>();

UserService userService() => ctx().read<UserService>();

void toast(String message) =>
    ScaffoldMessenger.of(ctx()).showSnackBar(SnackBar(content: Text(message)));

abstract class MonocleService {
  void onServiceBind();
}

class DelayedProgressIndicator extends StatefulWidget {
  final int delay;

  const DelayedProgressIndicator({Key? key, this.delay = 2000})
      : super(key: key);

  static _DelayedProgressIndicatorState? of(BuildContext context) =>
      context.findAncestorStateOfType<State<DelayedProgressIndicator>>()
          as _DelayedProgressIndicatorState?;

  @override
  _DelayedProgressIndicatorState createState() =>
      _DelayedProgressIndicatorState();
}

class _DelayedProgressIndicatorState extends State<DelayedProgressIndicator> {
  late bool active;
  late bool visible;

  @override
  void initState() {
    active = false;
    visible = true;
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (visible) {
        setState(() => active = true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    visible = false;
    active = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      active && visible ? const CircularProgressIndicator() : Container();
}
