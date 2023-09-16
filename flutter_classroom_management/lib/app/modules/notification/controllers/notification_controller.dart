import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/helper/storge_helperfunctions.dart';
import '../../../data/models/notification.dart';

class NotificationController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
    Stream<List<NotificationModel>> getNotification() async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> classRoomsStream;

    const String mssv = "CB12345";

    classRoomsStream = FirebaseFirestore.instance
        .collection('notification')
        .where('sent_from', isEqualTo: mssv)
        .snapshots();
    List<NotificationModel> notification = [];
    await for (var classRoomSnapshot in classRoomsStream) {
      notification.clear();
      for (var classRoomDoc in classRoomSnapshot.docs) {
        var classRoom = classRoomDoc.data();
        var notificationModel = NotificationModel.fromJson(classRoom);

        notification.add(notificationModel);
      }
      yield notification;
    }
  }
  //TODO: Implement NotificationController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
