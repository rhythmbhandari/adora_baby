import 'package:adora_baby/app/modules/auth/views/otp_view.dart';
import 'package:adora_baby/app/modules/auth/views/phone_view.dart';
import 'package:get/get.dart';

import '../modules/auth/bindings/auth_bindings.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PHONE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PHONE,
      page: () => const PhoneView(),
      binding: AuthBinding(),
    ),
  ];
}
