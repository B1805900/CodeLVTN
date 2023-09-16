import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_classroom_management/app/data/models/classroom.dart';
import 'package:get/get.dart';

import '../../../data/services/auth.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Stream<List<ClassroomModel>> getClassRoom() async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> classRoomsStream;

    final String mssv = await HelperFunctions.getMssvSharedPreference() ?? "";

    classRoomsStream = FirebaseFirestore.instance
        .collection('classRoom')
        .where('dssv', arrayContains: mssv)
        .snapshots();
    List<ClassroomModel> classRooms = [];
    await for (var classRoomSnapshot in classRoomsStream) {
      classRooms.clear();
      for (var classRoomDoc in classRoomSnapshot.docs) {
        var classRoom = classRoomDoc.data();
        var classRoomModel = ClassroomModel.fromJson(classRoom);

        classRooms.add(classRoomModel);
      }
      yield classRooms;
    }
  }

  void signOut() {
    AuthMethods().signOut();
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    Get.offAllNamed(Routes.SIGN_IN);
  }

  @override
  void onInit() {
    super.onInit();
    getClassRoom();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
