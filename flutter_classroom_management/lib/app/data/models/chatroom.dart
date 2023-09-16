import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  String? chatRoomId;
  List<dynamic>? users;
  List<dynamic>? chats;

  ChatRoomModel({
    this.chatRoomId,
    this.chats,
    this.users,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    chatRoomId = json['chatRoomId'];
    chats = json['chats'];
    users = json['users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRoomId'] = chatRoomId;
    data['chats'] = chats;
    data['users'] = users;
    return data;
  }
}
