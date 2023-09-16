import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/classroom_detail_controller.dart';

class ClassroomDetailView extends GetView<ClassroomDetailController> {
  const ClassroomDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClassroomDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClassroomDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
