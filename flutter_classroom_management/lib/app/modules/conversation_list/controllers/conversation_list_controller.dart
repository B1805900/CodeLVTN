import 'package:flutter_classroom_management/app/data/helper/storge_helperfunctions.dart';
import 'package:flutter_classroom_management/app/data/models/chatroom.dart';
import 'package:flutter_classroom_management/app/data/services/database.dart';
import 'package:get/get.dart';

import '../../../data/helper/constants.dart';

class ConversationListController extends GetxController {
  RxList<Map<String, dynamic>> chatRooms = [
    {"name": "Nguyễn Văn A", "email": "a@gmail.com"},
    {"name": "Nguyễn Văn C", "email": "c@gmail.com"},
    {"name": "Ctu Teacher", "email": "phanbaonhanctu@gmail.com"},
  ].obs;
  String userEmail = "";
  Future<void> getChatRooms() async {
    userEmail = await HelperFunctions.getUserEmailSharedPreference() ?? "";
    Constants.myName = userEmail;
    // chatRooms.value =
    //     await DatabaseMethods().getChatRooms(userEmail.toString());
    print(userEmail);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getChatRooms();
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
