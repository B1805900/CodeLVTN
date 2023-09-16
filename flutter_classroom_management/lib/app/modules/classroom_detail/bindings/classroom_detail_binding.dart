import 'package:get/get.dart';

import '../controllers/classroom_detail_controller.dart';

class ClassroomDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassroomDetailController>(
      () => ClassroomDetailController(),
    );
  }
}
