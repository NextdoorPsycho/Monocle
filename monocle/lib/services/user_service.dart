import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_log/fast_log.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monocle/model/user.dart';
import 'package:monocle/sugar.dart';

class UserService implements MonocleService {
  @override
  void onServiceBind() {}

  bool bound = false;
  late User lastUser;

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
        return us;
      });
}
