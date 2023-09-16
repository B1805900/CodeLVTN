import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? content, file, name, sentTo, sentFrom, time;
  List<dynamic>? listNotification;
  DocumentReference? reference;

  NotificationModel({
    this.content,
    this.file,
    this.name,
    this.sentTo,
    this.sentFrom,
    this.time,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    file = json['file'];
    name = json['name'];
    sentTo = json['sent_to'];
    sentFrom = json['sent_from'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['name'] = name;
    data['file'] = file;
    data['sent_from'] = sentFrom;
    data['sent_to'] = sentTo;
    data['time'] = time;
    return data;
  }
}