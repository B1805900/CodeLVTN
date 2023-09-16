import 'package:get/get.dart';

import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/classroom_detail/bindings/classroom_detail_binding.dart';
import '../modules/classroom_detail/views/classroom_detail_view.dart';
import '../modules/conversation/bindings/conversation_binding.dart';
import '../modules/conversation/views/conversation_view.dart';
import '../modules/conversation_list/bindings/conversation_list_binding.dart';
import '../modules/conversation_list/views/conversation_list_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/update_user_information/bindings/update_user_information_binding.dart';
import '../modules/update_user_information/views/update_user_information_view.dart';
import '../modules/user_information/bindings/user_information_binding.dart';
import '../modules/user_information/views/user_information_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.CONVERSATION,
      page: () => const ConversationView(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CLASSROOM_DETAIL,
      page: () => const ClassroomDetailView(),
      binding: ClassroomDetailBinding(),
    ),
    GetPage(
      name: _Paths.CONVERSATION_LIST,
      page: () => const ConversationListView(),
      binding: ConversationListBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.USER_INFORMATION,
      page: () => const UserInformationView(),
      binding: UserInformationBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_USER_INFORMATION,
      page: () => const UpdateUserInformationView(),
      binding: UpdateUserInformationBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDENCE,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
    ),
  ];
}
