import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/common/constant.dart';
import 'package:flutter_classroom_management/app/data/helper/create_chatroom_helpers.dart';
import 'package:flutter_classroom_management/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../../common/widgets/background.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../controllers/conversation_list_controller.dart';

class ConversationListView extends GetView<ConversationListController> {
  const ConversationListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationListController>(
      init: ConversationListController(),
      builder: (context) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Danh sách trò chuyện',
          ),
          body: Stack(
            children: [
              Background(height: Get.size.height),
              ListView.builder(
                itemCount: controller.chatRooms.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: InkWell(
                      onTap: () {
                        CreateChatRoom().createChatroomAndStartConversation(
                            controller.userEmail,
                            controller.chatRooms[index]["email"]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.chatRooms[index]["name"],
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              controller.chatRooms[index]["email"],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
