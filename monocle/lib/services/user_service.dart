import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_log/fast_log.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/model/card_data.dart';
import 'package:monocle/model/user.dart';
import 'package:monocle/sugar.dart';
import 'package:quantum/quantum.dart';

class UserService implements MonocleService {
  @override
  void onServiceBind() {}

  bool bound = false;
  late User lastUser;
  late QuantumUnit<CardData> cardData;

  auth.User getCurrentUser() => auth.FirebaseAuth.instance.currentUser!;

  String uid() => getCurrentUser().uid;

  Future<void> bind(String uid) async {
    try {
      lastUser = await getUserData(uid);
      bound = true;
    } catch (e, es) {
      error("Failed to bind User service! Restarting App!");
      error(e);
      error(es);
      Future.delayed(const Duration(seconds: 1), () {
        Get.forceAppUpdate();
        Navigator.pushNamedAndRemoveUntil(ctx(), "/splash", (route) => false);
      });
    }
  }

  Stream<CardData> getCardData() => FirebaseFirestore.instance
      .collection("user")
      .doc(uid())
      .collection("data")
      .doc("data")
      .snapshots()
      .map((e) => CardData.fromJson(e.data()!));

  /// Retrieve the current user data from the user id: [uid].
  Future<User> getUserData(String uid,
          {String? firstName,
          String? lastName,
          ValueChanged<User>? onSignedUp}) =>
      FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .get()
          .then((value) async {
        User us = User.fromJson(value.data() ?? <String, dynamic>{});
        if (!value.exists) {
          us.firstName = firstName ?? us.firstName;
          us.lastName = lastName ?? us.lastName;

          if (!(us.registered ?? false)) {
            us.registered = true;
            onSignedUp?.call(us);
          }

          warn("User data does not exist. Creating it...");
          await FirebaseFirestore.instance
              .collection("user")
              .doc(uid)
              .set(us.toJson());
        }

        us.uid = uid;

        DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore.instance
            .collection("user")
            .doc(uid)
            .collection("data")
            .doc("data");

        if (!(await ref.get()).exists) {
          warn("Card data does not exist, creating...");
          await FirebaseFirestore.instance
              .collection("user")
              .doc(uid)
              .collection("data")
              .doc("data")
              .set(CardData().toJson());
          success("Card data created!");
        }

        cardData = QuantumUnit<CardData>(
          deserializer: (e) => CardData.fromJson(e ?? {}),
          serializer: (e) => e?.toJson() ?? {},
          document: FirebaseFirestore.instance
              .collection("user")
              .doc(uid)
              .collection("data")
              .doc("data"),
        );
        cardData.open();

        while (!cardData.hasLatest()) {
          info("Waiting for card data stream to be ready...");
          await Future.delayed(const Duration(milliseconds: 250));
        }

        success("Card data is ready!");

        return us;
      });
}
