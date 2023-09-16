// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  String? diadiem, name, time, userCreate;
  List<dynamic>? listsv;
  DocumentReference? reference;

  AttendanceModel({
    this.diadiem,
    this.userCreate,
    this.name,
    this.listsv,
    this.time,
  });

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    diadiem = json['diadiem'];
    userCreate = json['user_create'];
    name = json['name'];
    listsv = json['listsv'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diadiem'] = diadiem;
    data['name'] = name;
    data['listsv'] = listsv;
    data['time'] = time;
    return data;
  }
}