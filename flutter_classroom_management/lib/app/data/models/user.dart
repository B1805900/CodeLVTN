import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid, age, email, name, phone, gender, mssv, rule;
  DocumentReference? reference;

  UserModel({
    this.uid,
    this.age,
    this.email,
    this.name,
    this.phone,
    this.gender,
    this.mssv,
    this.rule,
    this.reference,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    gender = json['gender'];
    mssv = json['mssv'];
    rule = json['rule'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['gender'] = gender;
    data['mssv'] = mssv;
    data['rule'] = rule;
    return data;
  }
}
