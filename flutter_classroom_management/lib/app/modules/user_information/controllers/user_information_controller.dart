import 'package:flutter_classroom_management/app/data/models/user.dart';
import 'package:flutter_classroom_management/app/data/services/database.dart';
import 'package:get/get.dart';

import '../../../data/helper/storge_helperfunctions.dart';

class UserInformationController extends GetxController with StateMixin {
  Rx<UserModel> userInfo = UserModel().obs;

  Future<void> loadData() async {
    final uid = await HelperFunctions.getUserUidSharedPreference() ?? "";
    print(uid);
    userInfo.value = await DatabaseMethods().getUserByUID(uid);
    print(userInfo.value.name);
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    await loadData();
    change(null, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
