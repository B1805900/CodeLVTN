import 'package:cloud_firestore/cloud_firestore.dart';

class ClassroomModel {
  String? content, idTeacher, className, time;
  List<dynamic>? listStudent;
  DocumentReference? reference;

  ClassroomModel({
    this.content,
    this.idTeacher,
    this.listStudent,
    this.className,
    this.time,
    this.reference,
  });

  ClassroomModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    idTeacher = json['idteacher'];
    listStudent = json['dssv'];
    className = json['tenlop'];
    time = json['time'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['idteacher'] = idTeacher;
    data['dssv'] = listStudent;
    data['tenlop'] = className;
    data['time'] = time;
    return data;
  }
}
