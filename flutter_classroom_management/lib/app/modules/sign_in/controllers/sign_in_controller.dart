import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../common/constant.dart';
import '../../../data/helper/storge_helperfunctions.dart';
import '../../../data/services/auth.dart';
import '../../../data/services/database.dart';
import '../../../routes/app_pages.dart';
import '../views/processing_dialog.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  bool userIsLoggedIn = false;

  RxBool isAuth = false.obs;
  RxBool initializedFirebase = false.obs;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  QuerySnapshot? snapshotUserInfo;

  @override
  void onInit() {
    super.onInit();
    _initFirebase();
  }

  @override
  void onReady() {
    super.onReady();

    once(
      initializedFirebase,
      (_) => _initUserSession(),
      condition: () => initializedFirebase.isTrue,
    );
    once(
      initializedFirebase,
      (_) => _listenAuthState(),
      condition: () => initializedFirebase.isTrue,
    );
  }

  void _initFirebase() async {
    try {
      await Firebase.initializeApp();
      initializedFirebase.value = true;
    } catch (e) {
      print("initFirebase $e");
    }
  }

  void _initUserSession() {
    try {
      isAuth.value = FirebaseAuth.instance.currentUser != null;
    } catch (e) {
      print("initUserSession $e");
    }
  }

  void _listenAuthState() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        isAuth.value = user != null;
      });
    } catch (e) {
      print("listenAuthState $e");
    }
  }

  Future<void> handleSignIn(BuildContext context) async {
    bool? isValid = formKey.currentState?.validate();
    if (isValid != null && isValid) {
      formKey.currentState?.save();

      HelperFunctions.saveUserEmailSharedPreference(email.toString());

      snapshotUserInfo = await databaseMethods.getUserByUserEmail(email);

      print("snapshotUserInfo: $snapshotUserInfo");

      if (snapshotUserInfo != null) {
        if (snapshotUserInfo!.docs.isNotEmpty) {
          HelperFunctions.saveUserNameSharedPreference(
              snapshotUserInfo?.docs[0]["name"]);
          HelperFunctions.saveMssvSharedPreference(
              snapshotUserInfo?.docs[0]["mssv"]);
          HelperFunctions.saveUserEmailSharedPreference(
              snapshotUserInfo?.docs[0]["email"]);
          HelperFunctions.saveUserUidSharedPreference(
              snapshotUserInfo?.docs[0].reference.id ?? "");
        }
      }

      isLoading = true;

      authMethods
          .signInWithEmailAndPassword(email.toString(), password.toString())
          .then((value) {
        try {
          if (value != null) {
            databaseMethods.getUserByUserEmail(email.toString());
            HelperFunctions.saveUserLoggedInSharedPreference(true);

            Get.offAllNamed(Routes.HOME);
          } else {
            const snackBar = SnackBar(
              backgroundColor: primaryColor,
              content: Text(
                'Email hoặc Mật khẩu không chính xác',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } catch (e) {
          print('Sign In Exception: $e');
        }
      });
    }
  }
}
