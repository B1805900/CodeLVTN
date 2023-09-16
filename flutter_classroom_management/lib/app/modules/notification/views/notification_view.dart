import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/common/constant.dart';
import 'package:flutter_classroom_management/app/common/widgets/background.dart';
import 'package:flutter_classroom_management/app/common/widgets/custom_loader.dart';
import 'package:flutter_classroom_management/app/data/models/notification.dart';
import 'package:flutter_classroom_management/app/routes/app_pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/notification_controller.dart';
import '../../../common/widgets/custom_appbar.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Thông báo"),
        body: buildNotificationList(context));
  }

  Widget buildNotificationList(BuildContext context) {
    var streamBuilder = StreamBuilder<List<NotificationModel>>(
        stream: controller.getNotification(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> classRoomsSnapshot) {
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
                        .map((NotificationModel notification) {
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
                                Text(
                                  "Tiêu đề: ${notification.name}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.card_membership_rounded,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  "Người gửi: ${notification.sentFrom}",
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
                                SizedBox(
                                  width: Get.width * 0.7,
                                  child: Text(
                                    "Nội dung: ${notification.content}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.people_outline_sharp,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => launchUrl(Uri.parse(
                                      "http://ctu-it.com/dashboard/uploads/files/${notification.file}")),
                                  child: Text(
                                    "File đính kèm: ${notification.file}",
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
                                  "Thời gian gửi: ${notification.time}",
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
