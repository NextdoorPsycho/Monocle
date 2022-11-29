import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:fast_log/fast_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monocle/model/user.dart' as mg;
import 'package:monocle/sugar.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:snackbar/snackbar.dart';

class AuthService implements MonocleService {
  @override
  void onServiceBind() {}

  bool isSignedIn() => FirebaseAuth.instance.currentUser != null;

  Future<void> signOut() => Future.wait(
      [FirebaseAuth.instance.signOut(), GoogleSignIn.standard().signOut()]);

  Future<UserCredential> signInWithApple() async {
    late UserCredential c;
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    c = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    Map<String, dynamic> profile = c.additionalUserInfo?.profile ?? {};
    info("Apple Data ${c.additionalUserInfo?.profile}");
    String? firstName = profile["given_name"];
    String? lastName = profile["family_name"];
    String? profilePictureUrl = profile["picture"];
    mg.User user = await userService().getUserData(c.user!.uid,
        firstName: firstName, lastName: lastName, onSignedUp: (user) {
      info("User Signed Up!");
    });

    return c;
  }

  Future<UserCredential> signInWithGoogle() async {
    late UserCredential c;

    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        c = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        GoogleSignInAccount? googleUser =
            await GoogleSignIn.standard().signIn();
        GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth == null) {
          error("Google Auth is null!");
          snack("Authentication Failure");
        }

        OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        c = await FirebaseAuth.instance.signInWithCredential(credential);
      }
      Map<String, dynamic> profile = c.additionalUserInfo?.profile ?? {};
      String? firstName = profile["given_name"];
      String? lastName = profile["family_name"];
      String? profilePictureUrl = profile["picture"];
      mg.User user = await userService().getUserData(c.user!.uid,
          firstName: firstName, lastName: lastName, onSignedUp: (user) {
        info("User Signed Up!");
      });
    } catch (e, es) {
      error(e);
      error(es);
    }
    return c;
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
