import 'package:get/get.dart';

import '../controllers/update_user_information_controller.dart';

class UpdateUserInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUserInformationController>(
      () => UpdateUserInformationController(),
    );
  }
}
