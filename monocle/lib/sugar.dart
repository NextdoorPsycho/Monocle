import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/model/card_data.dart';
import 'package:monocle/services/auth_service.dart';
import 'package:monocle/services/magic_service.dart';
import 'package:monocle/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:quantum/quantum.dart';

BuildContext? tempContext;

BuildContext ctx() => (Get.context ?? tempContext)!;

AuthService authService() => ctx().read<AuthService>();

MagicService magicService() => ctx().read<MagicService>();

UserService userService() => ctx().read<UserService>();

typedef CardDataBuilder = Widget Function(
    CardData data, QuantumUnit<CardData> writer);

class CardDataStream extends StatelessWidget {
  final CardDataBuilder builder;

  const CardDataStream({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<CardData>(
        stream: userService().cardData.stream(),
        builder: (context, snap) => snap.hasData
            ? builder(snap.data!, userService().cardData)
            : const CircularProgressIndicator(),
      );
}

abstract class MonocleService {
  void onServiceBind();
}

extension XWidget on Widget {
  Widget center() => Center(child: this);
}
