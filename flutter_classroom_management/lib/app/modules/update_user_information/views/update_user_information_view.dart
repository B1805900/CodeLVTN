import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/common/widgets/custom_appbar.dart';
import 'package:flutter_classroom_management/app/modules/user_information/controllers/user_information_controller.dart';

import 'package:get/get.dart';

import '../../../common/constant.dart';
import '../../../common/widgets/background.dart';
import '../../user_information/views/constants.dart';
import '../controllers/update_user_information_controller.dart';

class UpdateUserInformationView
    extends GetView<UpdateUserInformationController> {
  const UpdateUserInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateUserInformationController>(
      init: UpdateUserInformationController(),
      builder: (controller) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: "Cập nhật thông tin",
          ),
          body: Form(
            key: controller.formKey,
            child: Center(
                child: Stack(
              children: [
                Background(height: MediaQuery.of(context).size.height),
                buildView(context)
              ],
            )),
          ),
          floatingActionButton: SizedBox(
            height: 60,
            width: 60,
            child: FloatingActionButton.extended(
              onPressed: () {
                if (!controller.formKey.currentState!.validate()) return;
                controller.formKey.currentState!.save();
                FocusScope.of(context).unfocus();
                controller.updateUserInfo();
                Get.find<UserInformationController>().loadData();
                // homeController.loadData();
                Get.back();
              },
              label: const Icon(Icons.done),
              backgroundColor: primaryColor,
            ),
          ),
        );
      },
    );
  }

  Widget buildView(BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: 212,
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 112,
                  height: 112,
                  child: CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/images/avt_doctor.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: informationText,
                    initialValue: controller.userInfo.value.name,
                    onSaved: (value) {
                      if (value != '') controller.userInfo.value.name = value;
                    },
                    validator: (value) {
                      if (value == '' &&
                          controller.userInfo.value.name ==
                              'VD: Phan Bảo Nhân') {
                        return 'Hãy nhập vào tên của bạn!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: controller.userInfo.value.name,
                      hintStyle: keyText,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      border: textFieldBorder(),
                      enabledBorder: textFieldBorder(),
                      focusedBorder: textFieldBorder(),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: secondaryColor)),
                      disabledBorder: textFieldBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: 380,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 125,
                            child: Text(
                              'Mã số SV',
                              style: keyText,
                            ),
                          ),
                          Obx(() => TextButton(
                              onPressed: () {},
                              child: Text(
                                controller.userInfo.value.mssv.toString(),
                                style: informationText,
                              )))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 125,
                            child: Text(
                              'Email',
                              style: keyText,
                            ),
                          ),
                          Obx(() => TextButton(
                              onPressed: () {},
                              child: Text(
                                controller.userInfo.value.email.toString(),
                                style: informationText,
                              )))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 125,
                            child: Text(
                              'SĐT',
                              style: keyText,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              initialValue: controller.userInfo.value.phone,
                              style: informationText,
                              onSaved: (value) {
                                if (value != '') {
                                  controller.userInfo.value.phone = value;
                                }
                              },
                              validator: (value) {
                                if (value == '' &&
                                    controller.userInfo.value.phone ==
                                        'VD: 0971002636') {
                                  return 'Hãy nhập vào số điện thoại của bạn!';
                                }
                                if (value != '' &&
                                    !GetUtils.isPhoneNumber(value!)) {
                                  return 'Số điện thoại không hợp lệ!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: controller.userInfo.value.phone,
                                hintStyle: keyText,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                border: textFieldBorder(),
                                enabledBorder: textFieldBorder(),
                                focusedBorder: textFieldBorder(),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: secondaryColor)),
                                disabledBorder: textFieldBorder(),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 125,
                            child: Text(
                              'Giới tính',
                              style: keyText,
                            ),
                          ),
                          Obx(() => TextButton(
                              onPressed: () {},
                              child: Text(
                                controller.userInfo.value.gender.toString(),
                                style: informationText,
                              )))
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 125,
                            child: Text(
                              'Ngày sinh',
                              style: keyText,
                            ),
                          ),
                          Obx(() => TextButton(
                              onPressed: () {
                                controller.pickDate(context);
                              },
                              child: Text(
                                controller.getText(),
                                style: informationText,
                              )))
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ));

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: primaryColor));
  }
}
