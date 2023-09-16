import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/helper/storge_helperfunctions.dart';
import '../../../data/models/attendance.dart';
class AttendanceController extends GetxController {
  //TODO: Implement AttendanceController
    final scaffoldKey = GlobalKey<ScaffoldState>();
    Stream<List<AttendanceModel>> getAttendance() async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> classRoomsStream;

    const String mssv = "B1805904";

    classRoomsStream = FirebaseFirestore.instance
        .collection('attendance')
        .where('listsv', arrayContains: mssv)
        .snapshots();
    List<AttendanceModel> notification = [];
    await for (var classRoomSnapshot in classRoomsStream) {
      notification.clear();
      for (var classRoomDoc in classRoomSnapshot.docs) {
        var classRoom = classRoomDoc.data();
        var attendanceModel = AttendanceModel.fromJson(classRoom);

        notification.add(attendanceModel);
      }
      yield notification;
    }
  }

  void showData(BuildContext context, List<dynamic> data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Dữ liệu'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(data[index]),
              );
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Đóng'),
          ),
        ],
      );
    },
  );
}



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
