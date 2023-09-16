import 'package:flutter_classroom_management/app/data/helper/constants.dart';
import 'package:flutter_classroom_management/app/data/services/database.dart';
import 'package:flutter_classroom_management/app/routes/app_pages.dart';
import 'package:get/get.dart';

class CreateChatRoom {
  DatabaseMethods databaseMethods = Get.put(DatabaseMethods());
  createChatroomAndStartConversation(String userName, String name) {
    try {
      Constants.chatRoomId = getChatRoomId(userName, name);

      List<String> users = [userName, name];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": Constants.chatRoomId,
      };

      databaseMethods.createChatroom(Constants.chatRoomId, chatRoomMap);
      Constants.doctorName = name;
      Get.toNamed(Routes.CONVERSATION);
    } catch (e) {
      print(e);
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
