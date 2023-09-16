import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_classroom_management/app/data/models/chatroom.dart';
import 'package:flutter_classroom_management/app/data/models/classroom.dart';

import '../models/user.dart';

class DatabaseMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getUserByUsername(String username) async {
    return await _firestore
        .collection('info')
        .where('name',
            isGreaterThanOrEqualTo: username,
            isLessThanOrEqualTo: '$username\uf8ff')
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await _firestore
        .collection('info')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  createChatroom(chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<List<ChatRoomModel>> getChatRooms(String userName) async {
    QuerySnapshot snapshot = await _firestore
        .collection('chatRoom')
        .where('users', arrayContains: userName)
        .get();

    List<ChatRoomModel> chatRoomList = [];
    for (var element in snapshot.docs) {
      var classRoom = element.data() as Map<String, dynamic>;
      classRoom['reference'] = element.reference;

      chatRoomList.add(ChatRoomModel.fromJson(classRoom));
    }

    return chatRoomList;
  }

  getConversationMessage(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  addMessage(String chatRoomId, chatMessageData) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<UserModel> getUserByUID(String uid) async {
    var snapshot = await _firestore.collection('info').doc(uid).get();

    if (snapshot.exists) {
      Map<String, dynamic> user = snapshot.data() as Map<String, dynamic>;

      return UserModel.fromJson(user);
    }

    return UserModel();
  }

  Future<List<ClassroomModel>> getClassRoomByMssv(String mssv) async {
    QuerySnapshot snapshot = await _firestore
        .collection('classRoom')
        .where('dssv', arrayContains: mssv)
        .get();

    List<ClassroomModel> classRoomList = [];
    for (var element in snapshot.docs) {
      var classRoom = element.data() as Map<String, dynamic>;
      classRoom['reference'] = element.reference;

      classRoomList.add(ClassroomModel.fromJson(classRoom));
    }

    return classRoomList;
  }

  Future<void> updateUser(String docId, UserModel newUserInfo) async {
    FirebaseFirestore.instance
        .collection('info')
        .doc(docId)
        .set(newUserInfo.toJson());
  }

  // Future<DoctorModel> getDoctorById(String did) async {
  //   var snapshot = await _firestore.collection('doctors').doc(did).get();

  //   if (snapshot.exists) {
  //     Map<String, dynamic> doctor = snapshot.data() as Map<String, dynamic>;
  //     doctor['reference'] = snapshot.reference;

  //     AddressModel addressModel = AddressModel(name: 'NULL');
  //     if (doctor.containsKey('address')) {
  //       DocumentSnapshot addressRef = await doctor['address'].get();
  //       if (addressRef.exists) {
  //         final addressJon = addressRef.data() as Map<String, dynamic>;
  //         addressJon['reference'] = addressRef.reference;
  //         addressModel = AddressModel.fromJson(addressJon);
  //       }
  //     }
  //     doctor['address'] = addressModel;
  //     return DoctorModel.fromJson(doctor);
  //   }

  //   return DoctorModel();
  // }

  // uploadUserInfo(userMap) {
  //   _firestore.collection('users').add(userMap);
  // }

  // static Future<DoctorModel> getDoctorProfiles(String doctorId) async {
  //   var snapshot = await _firestore.collection('doctors').doc(doctorId).get();

  //   if (snapshot.exists) {
  //     Map<String, dynamic> user = snapshot.data() as Map<String, dynamic>;
  //     user['reference'] = snapshot.reference;

  //     AddressModel addressModel = AddressModel(name: 'NULL');
  //     if (user.containsKey('address')) {
  //       DocumentSnapshot addressRef = await user['address'].get();
  //       if (addressRef.exists) {
  //         final addressJson = addressRef.data() as Map<String, dynamic>;
  //         addressJson['reference'] = addressRef.reference;
  //         addressModel = AddressModel.fromJson(addressJson);
  //       }
  //     }
  //     user['address'] = addressModel;
  //     user['docId'] = doctorId;
  //     return DoctorModel.fromJson(user);
  //   }

  //   return DoctorModel();
  // }

  // static Future<bool> isDoctor(String uid) async {
  //   var doctor = await _firestore.collection('doctors').doc(uid).get();
  //   if (doctor.exists) {
  //     return true;
  //   }
  //   return false;
  // }

  // static Future<List<AppointmentModel>> getAppointments(
  //     String patientEmail) async {
  //   QuerySnapshot snapshot = await _firestore
  //       .collection('appointments')
  //       .orderBy('appointment_date')
  //       .where('patient', isEqualTo: patientEmail)
  //       .where('appointment_date', isGreaterThanOrEqualTo: DateTime.now())
  //       .get();

  //   List<AppointmentModel> appointmentList = [];
  //   snapshot.docs.forEach((element) async {
  //     var appointment = element.data() as Map<String, dynamic>;
  //     appointment['reference'] = element.reference;

  //     var doctorModel = DoctorModel();

  //     /* Query doctor */
  //     if (appointment.containsKey('doctor')) {
  //       DocumentSnapshot doctorRef = await appointment['doctor'].get();
  //       if (doctorRef.exists) {
  //         final doctorJson = doctorRef.data() as Map<String, dynamic>;
  //         doctorJson['reference'] = doctorRef.reference;
  //         doctorJson['docId'] = doctorRef.id;
  //         doctorModel = DoctorModel.fromJson(doctorJson);
  //       }
  //     }

  //     appointment['doctor'] = doctorModel;

  //     appointmentList.add(AppointmentModel.fromJson(appointment));
  //   });

  //   return appointmentList;
  // }

  // static Future<List<AppointmentModel>> getAppointmentsOfDoctor(
  //     DocumentReference doctorRef) async {
  //   QuerySnapshot snapshot = await _firestore
  //       .collection('appointments')
  //       .orderBy('appointment_date')
  //       .where('doctor', isEqualTo: doctorRef)
  //       .where('appointment_date', isGreaterThanOrEqualTo: DateTime.now())
  //       .get();

  //   List<AppointmentModel> appointmentList = [];
  //   snapshot.docs.forEach((element) async {
  //     var appointment = element.data() as Map<String, dynamic>;
  //     appointment['reference'] = element.reference;

  //     var doctorModel = DoctorModel();

  //     /* Query doctor */
  //     if (appointment.containsKey('doctor')) {
  //       DocumentSnapshot doctorRef = await appointment['doctor'].get();
  //       if (doctorRef.exists) {
  //         final doctorJson = doctorRef.data() as Map<String, dynamic>;
  //         doctorJson['reference'] = doctorRef.reference;
  //         doctorJson['docId'] = doctorRef.id;
  //         doctorModel = DoctorModel.fromJson(doctorJson);
  //       }
  //     }

  //     var patientModel = await getUserModelByEmail(appointment['patient']);
  //     appointment['patientModel'] = patientModel;

  //     appointment['doctor'] = doctorModel;

  //     appointmentList.add(AppointmentModel.fromJson(appointment));
  //   });

  //   return appointmentList;
  // }

  // static Future<List<DoctorModel>> getDoctors(
  //     [DocumentReference? userAddressRef]) async {
  //   QuerySnapshot snapshot;
  //   if (userAddressRef != null) {
  //     snapshot = await _firestore
  //         .collection('doctors')
  //         .where('address', isEqualTo: userAddressRef)
  //         .get();
  //   } else {
  //     snapshot = await _firestore.collection('doctors').get();
  //   }
  //   List<DoctorModel> doctorList = [];
  //   snapshot.docs.forEach((element) async {
  //     final doctor = element.data() as Map<String, dynamic>;
  //     doctor['reference'] = element.reference;
  //     doctor['docId'] = element.id;

  //     dynamic addressModel = AddressModel(name: "NULL");
  //     /* Query address*/
  //     if (doctor.containsKey('address')) {
  //       DocumentSnapshot addressRef = await doctor['address'].get();
  //       if (addressRef.exists) {
  //         final addressJson = addressRef.data() as Map<String, dynamic>;
  //         addressJson['reference'] = addressRef.reference;
  //         addressModel = AddressModel.fromJson(addressJson);
  //       }
  //     }
  //     doctor['address'] = addressModel;

  //     doctorList.add(DoctorModel.fromJson(doctor));
  //   });

  //   return doctorList;
  // }

  // static Future<DocumentReference> getDistrictRefFromDistrictName(
  //     String addressName) async {
  //   QuerySnapshot snapshot = await _firestore
  //       .collection('districts')
  //       .where('name', isEqualTo: addressName)
  //       .get();
  //   DocumentSnapshot address = snapshot.docs.first;
  //   DocumentReference addressRef = address.reference;
  //   return addressRef;
  // }

  // Future<List<DoctorModel>> getDoctorsByDistrict(String district) async {
  //   var doctors = List<DoctorModel>.empty(growable: true);
  //   DocumentReference addressRef =
  //       await getDistrictRefFromDistrictName(district);
  //   // dynamic addressName = await addressRef.get();
  //   // print(addressName.data()['name']);
  //   DocumentSnapshot address = await addressRef.get();
  //   dynamic addressModel = AddressModel(name: "NULL");
  //   final addressJson = address.data() as Map<String, dynamic>;
  //   addressJson['reference'] = address.reference;
  //   addressModel = AddressModel.fromJson(addressJson);
  //   CollectionReference doctorRef =
  //       FirebaseFirestore.instance.collection('doctors');

  //   final snapshot =
  //       await doctorRef.where('address', isEqualTo: addressRef).get();
  //   snapshot.docs.forEach((element) {
  //     var doctor = DoctorModel.fromJson(element.data() as Map<String, dynamic>);
  //     doctor.docId = element.id;
  //     doctor.reference = element.reference;
  //     doctor.address = addressModel;
  //     doctors.add(doctor);
  //   });
  //   return doctors;
  // }

  // Future<List<AddressModel>> getDistricts() async {
  //   var districts = List<AddressModel>.empty(growable: true);
  //   CollectionReference districtRef =
  //       FirebaseFirestore.instance.collection('districts');

  //   final snapshot = await districtRef.get();
  //   snapshot.docs.forEach((element) {
  //     var district =
  //         AddressModel.fromJson(element.data() as Map<String, dynamic>);
  //     district.reference = element.reference;
  //     districts.add(district);
  //   });
  //   return districts;
  // }

  // static Future<bool> addTimeLineForDoctor(
  //     String docId, DateTime date, List<DateTime> timeSlot) async {
  //   String dateString = DateTimeHelpers.dateTimeToDate(date);
  //   Map<String, dynamic> data = {
  //     'time_slot': FieldValue.arrayUnion(timeSlot),
  //   };
  //   bool insertSuccess = false;
  //   await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .set(data)
  //       .then((value) => insertSuccess = true)
  //       .catchError((error) {
  //     debugPrint("Insert timeline error");
  //   });
  //   return insertSuccess;
  // }

  // static Future<List<DateTime>> getTimeSlotList(
  //     String docId, DateTime date) async {
  //   String dateString = DateTimeHelpers.dateTimeToDate(date);
  //   var snapshot = await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .get();
  //   if (!snapshot.exists) {
  //     return List<DateTime>.empty(growable: true);
  //   }
  //   List<DateTime> timeSlotList = List<DateTime>.empty(growable: true);
  //   var timeline = snapshot.data() as Map<String, dynamic>;

  //   timeline['time_slot'].forEach((timeSlot) {
  //     timeSlotList.add(DateTimeHelpers.timestampsToDateTime(timeSlot));
  //   });
  //   return timeSlotList;
  // }

  // static Future<bool> deleteTimeLineOfDoctor(
  //     String docId, DateTime date) async {
  //   String dateString = DateTimeHelpers.dateTimeToDate(date);
  //   bool deleteSuccess = false;
  //   var timelines = _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString);
  //   DocumentSnapshot timeLineData = await timelines.get();
  //   if (timeLineData.exists) {
  //     Map<String, dynamic> timeline =
  //         timeLineData.data() as Map<String, dynamic>;
  //     if (!timeline.containsKey("booked_slot")) {
  //       await timelines
  //           .delete()
  //           .then((value) => deleteSuccess = true)
  //           .catchError((error) {
  //         deleteSuccess = false;
  //         debugPrint('Delete time line of doctor error');
  //       });
  //     } else {
  //       deleteSuccess = false;
  //     }
  //   }

  //   return deleteSuccess;
  // }

  // static Future<bool> deleteTimeSlot(
  //     String docId, DateTime date, int index) async {
  //   String dateString = DateTimeHelpers.dateTimeToDate(date);
  //   var snapshot = await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .get();
  //   if (!snapshot.exists) {
  //     return false;
  //   }

  //   var timeline = snapshot.data() as Map<String, dynamic>;
  //   List<dynamic> deleteSlot = List<dynamic>.empty(growable: true);
  //   List<dynamic> bookedSlot = List<dynamic>.empty(growable: true);
  //   if (timeline.containsKey('delete_slot')) {
  //     deleteSlot = timeline['delete_slot'];
  //     bookedSlot = timeline['booked_slot'];
  //   }
  //   if (bookedSlot.contains(index)) {
  //     return false;
  //   }
  //   deleteSlot.add(index);

  //   Map<String, dynamic> data = {
  //     'delete_slot': FieldValue.arrayUnion(deleteSlot),
  //   };
  //   bool deleteSuccess = false;
  //   await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .update(data)
  //       .then((value) => deleteSuccess = true)
  //       .catchError((error) {
  //     debugPrint("Delete timeline error");
  //   });
  //   return deleteSuccess;
  // }

  // static Future<List<dynamic>> getTimeSlotDeleted(
  //     String docId, dynamic date) async {
  //   String dateString = DateTimeHelpers.dateTimeToDate(date);
  //   var snapshot = await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .get();
  //   if (!snapshot.exists) {
  //     return List<dynamic>.empty(growable: true);
  //   }
  //   List<dynamic> timeSlotDelete = List<dynamic>.empty(growable: true);
  //   var slot = snapshot.data() as Map<String, dynamic>;
  //   if (slot.containsKey('delete_slot')) {
  //     slot['delete_slot'].forEach((timeSlot) {
  //       timeSlotDelete.add(timeSlot);
  //     });
  //   }
  //   return timeSlotDelete;
  // }

  // static Future<List<ReviewModel>> getReviews(String docId) async {
  //   QuerySnapshot snapshot = await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('reviews')
  //       .get();
  //   List<ReviewModel> reviewList = [];
  //   snapshot.docs.forEach((element) async {
  //     var review = element.data() as Map<String, dynamic>;
  //     ReviewModel reviewModel = ReviewModel.fromJson(review);
  //     if (review.containsKey('user')) {
  //       DocumentSnapshot userRef = await review['user'].get();
  //       reviewModel.userName = userRef['name'];
  //     }
  //     reviewList.add(reviewModel);
  //   });
  //   return reviewList;
  // }

  // static Future<DocumentReference<Object?>> getUserRef(String userEmail) async {
  //   QuerySnapshot snapshot = await _firestore
  //       .collection('users')
  //       .where('email', isEqualTo: userEmail)
  //       .get();
  //   return snapshot.docs.first.reference;
  // }

  // static Future<UserModel> getUserModelByEmail(String userEmail) async {
  //   var snapshot = await _firestore
  //       .collection('users')
  //       .where('email', isEqualTo: userEmail)
  //       .get();
  //   var userSnapshot = snapshot.docs.first;
  //   if (userSnapshot.exists) {
  //     Map<String, dynamic> user = userSnapshot.data();
  //     user['reference'] = userSnapshot.reference;

  //     AddressModel addressModel = AddressModel(name: 'NULL');
  //     if (user.containsKey('address')) {
  //       DocumentSnapshot addressRef = await user['address'].get();
  //       if (addressRef.exists) {
  //         final addressJson = addressRef.data() as Map<String, dynamic>;
  //         addressJson['reference'] = addressRef.reference;
  //         addressModel = AddressModel.fromJson(addressJson);
  //       }
  //     }
  //     user['address'] = addressModel;
  //     return UserModel.fromJson(user);
  //   }

  //   return UserModel();
  // }

  // static Future<DocumentReference<Object?>> getDoctorRef(String docRef) async {
  //   DocumentSnapshot snapshot =
  //       await _firestore.collection('doctors').doc(docRef).get();
  //   return snapshot.reference;
  // }

  // static upLoadReview(reviewData, String docId) {
  //   _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('reviews')
  //       .add(reviewData);
  // }

  // static Future<bool> createAppointment(Map<String, dynamic> data) async {
  //   bool isSuccess = true;
  //   await _firestore
  //       .collection('appointments')
  //       .add(data)
  //       .then((value) => isSuccess = true)
  //       .catchError((error) => isSuccess = false);
  //   return isSuccess;
  // }

  // static Future<bool> markTimeIndex(
  //     String docId, DateTime date, int index) async {
  //   String dateString = DateTimeHelpers.dateTimeToDate(date);
  //   var snapshot = await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .get();
  //   if (!snapshot.exists) {
  //     return false;
  //   }

  //   var timeline = snapshot.data() as Map<String, dynamic>;
  //   List<dynamic> bookedSlot = List<dynamic>.empty(growable: true);
  //   if (timeline.containsKey('booked_slot')) {
  //     bookedSlot = timeline['booked_slot'];
  //   }
  //   if (bookedSlot.contains(index)) {
  //     return false;
  //   }
  //   bookedSlot.add(index);

  //   Map<String, dynamic> data = {
  //     'booked_slot': FieldValue.arrayUnion(bookedSlot),
  //   };
  //   bool checkMark = false;
  //   await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .update(data)
  //       .then((value) => checkMark = true)
  //       .catchError((error) {
  //     debugPrint("Booking error");
  //   });
  //   return checkMark;
  // }

  // static Future<List<dynamic>> getBookedSlot(String docId, dynamic date) async {
  //   String dateString = DateTimeHelpers.dateTimeToDate(date);
  //   var snapshot = await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(dateString)
  //       .get();
  //   if (!snapshot.exists) {
  //     return List<dynamic>.empty(growable: true);
  //   }
  //   List<dynamic> bookedSlot = List<dynamic>.empty(growable: true);
  //   var slot = snapshot.data() as Map<String, dynamic>;
  //   if (slot.containsKey('booked_slot')) {
  //     slot['booked_slot'].forEach((timeSlot) {
  //       bookedSlot.add(timeSlot);
  //     });
  //   }
  //   return bookedSlot;
  // }

  // static Future<bool> deleteAppointment(AppointmentModel appointment) async {
  //   dynamic appointmentRef = appointment.reference;
  //   dynamic slot = appointment.time_slot;
  //   dynamic docId = appointment.doctor!.docId;
  //   DateTime dateTime =
  //       DateTimeHelpers.timestampsToDateTime(appointment.appointment_date!);

  //   //Delete from appointments
  //   bool checkDeleteFromAppointments = true;
  //   appointmentRef
  //       .delete()
  //       .then((value) => checkDeleteFromAppointments = true)
  //       .catchError((error) => checkDeleteFromAppointments = false);
  //   if (!checkDeleteFromAppointments) {
  //     debugPrint('Delete from appointments error');
  //     return false;
  //   }

  //   //Delete from schedule of doctor
  //   String date = DateTimeHelpers.dateTimeToDate(dateTime);
  //   var snapshot = await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(date)
  //       .get();
  //   if (!snapshot.exists) {
  //     debugPrint('snapshot does not exists');
  //     return false;
  //   }

  //   var timeline = snapshot.data() as Map<String, dynamic>;
  //   if (timeline.containsKey('booked_slot')) {}

  //   List<dynamic> slotList = List<dynamic>.empty(growable: true);
  //   slotList.add(slot);
  //   Map<String, dynamic> data = {
  //     'booked_slot': FieldValue.arrayRemove(slotList),
  //   };
  //   bool checkDeleteFromDoctor = false;
  //   await _firestore
  //       .collection('doctors')
  //       .doc(docId)
  //       .collection('timeline')
  //       .doc(date)
  //       .update(data)
  //       .then((value) => checkDeleteFromDoctor = true)
  //       .catchError((error) {
  //     debugPrint("Cancel Appointment error");
  //   });
  //   return checkDeleteFromDoctor;
  // }
}
