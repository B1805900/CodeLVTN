import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/common/constant.dart';
import 'package:flutter_classroom_management/app/common/widgets/background.dart';
import 'package:flutter_classroom_management/app/common/widgets/custom_loader.dart';
import 'package:flutter_classroom_management/app/data/models/classroom.dart';
import 'package:flutter_classroom_management/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../../common/widgets/custom_appbar.dart';
import '../controllers/home_controller.dart';
import 'constants.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: buildDrawer(context),
        appBar: const CustomAppBar(
          title: 'Danh sách lớp học',
        ),
        body: Stack(
          children: [
            Background(height: Get.size.height),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: buildClassRoomList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClassRoomList(BuildContext context) {
    var streamBuilder = StreamBuilder<List<ClassroomModel>>(
        stream: controller.getClassRoom(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ClassroomModel>> classRoomsSnapshot) {
          if (classRoomsSnapshot.hasError) {
            return Text('Error: ${classRoomsSnapshot.error}');
          }
          switch (classRoomsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: Get.size.height);
            default:
              if (classRoomsSnapshot.data!.isEmpty) {
                return buildNullList(context);
              }
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ListView(
                    children: classRoomsSnapshot.data!
                        .map((ClassroomModel classRoom) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
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
                                  "Tên lớp: ${classRoom.className}",
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
                                  "Mã số cán bộ: ${classRoom.idTeacher}",
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
                                Text(
                                  "Mô tả: ${classRoom.content}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.people_outline_sharp,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  "Số lượng Sinh viên: ${classRoom.listStudent!.length}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    color: primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  "Thời gian: ${classRoom.time}",
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

  Widget buildDrawer(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Drawer(
          child: Material(
            child: ListView(
              children: <Widget>[
                buildMenuItem(
                    text: 'Thông tin cá nhân',
                    icon: Icons.person,
                    iconColor: Colors.black,
                    onPressed: () {
                      Get.toNamed(Routes.USER_INFORMATION);
                    }),
                buildMenuItem(
                    text: 'Chating',
                    icon: Icons.chat,
                    iconColor: Colors.black,
                    onPressed: () {
                      Get.toNamed(Routes.CONVERSATION_LIST);
                    }),
                buildMenuItem(
                    text: 'Xem thông báo',
                    icon: Icons.notification_add,
                    iconColor: Colors.black,
                    onPressed: () {
                      Get.toNamed(Routes.NOTIFICATION);
                    }),
                buildMenuItem(
                    text: 'Xem điểm danh',
                    icon: Icons.work_history,
                    iconColor: Colors.black,
                    onPressed: () {
                      Get.toNamed(Routes.ATTENDENCE);
                    }),
                buildMenuItem(
                    text: 'Đăng xuất',
                    icon: Icons.logout,
                    iconColor: Colors.black,
                    onPressed: () {
                      controller.signOut();
                    }),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required iconColor,
    required GestureTapCallback onPressed,
  }) {
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: largeTextStyle,
      ),
      hoverColor: hoverColor,
      onTap: onPressed,
    );
  }

  Widget buildNullList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            child: Image(
              image: AssetImage('assets/images/avt_doctor.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: const Text('Bạn chưa tham gia lớp học nào',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
