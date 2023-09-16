import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User user) {
    return UserModel(uid: user.uid);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print("signInWithEmailAndPassword: $e");
    }
  }

  // Future signUpWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? firebaseUser = result.user;
  //     return _userFromFirebaseUser(firebaseUser!);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {}
  }
}
