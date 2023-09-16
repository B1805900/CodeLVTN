import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/helper/constants.dart';
import '../../../data/services/database.dart';

class ConversationController extends GetxController {
  TextEditingController messageEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final bool sendByMe = false;

  Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection("chatRoom")
      .doc(Constants.chatRoomId)
      .collection("chats")
      .orderBy("time")
      .snapshots();

  StreamSubscription? messageSub;

  final messages = [].obs;

  sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addMessage(Constants.chatRoomId, chatMessageMap);
      messageEditingController.text = "";
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    messageSub = messageStream.listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          messages.add(element.doc.data());
        }
      });
    });
  }

  @override
  void onClose() {
    messageEditingController.dispose();
    messageSub?.cancel();
  }
}
