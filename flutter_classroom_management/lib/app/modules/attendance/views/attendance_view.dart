import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/common/constant.dart';
import 'package:flutter_classroom_management/app/common/widgets/custom_appbar.dart';
import 'package:flutter_classroom_management/app/common/widgets/custom_loader.dart';
import 'package:flutter_classroom_management/app/data/models/attendance.dart';
import 'package:get/get.dart';

import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Xem điểm danh"),
        body: buildNotificationList(context));
  }

  Widget buildNotificationList(BuildContext context) {
    var streamBuilder = StreamBuilder<List<AttendanceModel>>(
        stream: controller.getAttendance(),
        builder: (BuildContext context,
            AsyncSnapshot<List<AttendanceModel>> classRoomsSnapshot) {
          if (classRoomsSnapshot.hasError) {
            return Text('Error: ${classRoomsSnapshot.error}');
          }
          switch (classRoomsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: Get.size.height);
            default:
              if (classRoomsSnapshot.data!.isEmpty) {
                // return buildNullList(context);
                print("null");
              }
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ListView(
                    children: classRoomsSnapshot.data!
                        .map((AttendanceModel attendance) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryColor, width: 3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.class_rounded,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    "Tên hoạt động: ${attendance.name}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.card_membership_rounded,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  "Người tạo: ${attendance.userCreate}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.description,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    controller.showData(
                                        context, attendance.listsv!);
                                  },
                                  child: SizedBox(
                                    width: Get.width * 0.7,
                                    child: Text(
                                      "Số lượng tham gia: ${attendance.listsv!.length} sinh viên",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.description,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    "Địa điểm: ${attendance.diadiem}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  "Thời gian: ${attendance.time}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList()),
              );
          }
        });
    return streamBuilder;
  }
}
