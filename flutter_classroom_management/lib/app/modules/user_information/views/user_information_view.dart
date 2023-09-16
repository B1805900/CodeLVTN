import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/common/widgets/custom_appbar.dart';
import 'package:flutter_classroom_management/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../../common/constant.dart';
import '../../../common/widgets/background.dart';
import '../controllers/user_information_controller.dart';
import 'constants.dart';

class UserInformationView extends GetView<UserInformationController> {
  const UserInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserInformationController>(
        init: UserInformationController(),
        builder: (controller) {
          return controller.obx((state) => Scaffold(
              appBar: const CustomAppBar(title: "Thông tin cá nhân"),
              body: Center(
                  child: Stack(children: [
                Background(height: MediaQuery.of(context).size.height),
                buildView(context),
              ])),
              floatingActionButton: SizedBox(
                height: 60,
                width: 60,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Get.toNamed(Routes.UPDATE_USER_INFORMATION,
                        arguments: controller.userInfo);
                  },
                  label: const Icon(Icons.mode),
                  backgroundColor: primaryColor,
                ),
              )));
        });
  }

  Widget buildView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 20),
                      width: 112,
                      height: 112,
                      child: const CircleAvatar(
                        child: Image(
                          image: AssetImage('assets/images/avt_doctor.png'),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width - 180,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.userInfo.value.name ?? "",
                            style: informationText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  controller.userInfo.value.mssv.toString(),
                  style: nameText,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông Tin',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 26,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: const Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Email',
                        style: keyText,
                      ),
                    ),
                    Text(
                      controller.userInfo.value.email.toString(),
                      style: informationText,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Ngày sinh',
                        style: keyText,
                      ),
                    ),
                    Text(
                      controller.userInfo.value.age.toString(),
                      style: informationText,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Số điện thoại',
                        style: keyText,
                      ),
                    ),
                    Text(
                      controller.userInfo.value.phone ?? "",
                      style: informationText,
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Giới tính',
                        style: keyText,
                      ),
                    ),
                    Text(
                      controller.userInfo.value.gender.toString(),
                      style: informationText,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
