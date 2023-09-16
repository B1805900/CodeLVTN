import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_classroom_management/app/data/models/user.dart';
import 'package:flutter_classroom_management/app/data/services/database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateUserInformationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<UserModel> userInfo = UserModel().obs;

  final Rx<Color> _bgCheckBox = Colors.white.obs;
  Color get bgCheckBox => _bgCheckBox.value;
  set bgCheckBox(value) => _bgCheckBox.value = value;

  final RxBool _sex = true.obs;
  bool get sex => _sex.value;
  set sex(value) => _sex.value = value;

  final _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(value) => _date.value = value;

  String getText() {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 70),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDate == null) return;
    date = newDate;
    userInfo.value.age = DateFormat("dd/MM/yyyy").format(date).toString();
    update();
  }

  Future<void> updateUserInfo() async {
    final docId = await HelperFunctions.getUserUidSharedPreference() ?? "";
    await DatabaseMethods().updateUser(docId, userInfo.value);
  }

  @override
  void onInit() {
    super.onInit();
    userInfo = Get.arguments as Rx<UserModel>;
    _date.value = DateFormat("dd/MM/yyyy").parse(userInfo.value.age.toString());
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
