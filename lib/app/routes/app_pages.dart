import 'package:adora_baby/app/modules/auth/views/login_view.dart';
import 'package:adora_baby/app/modules/cart/views/add_address_view.dart';
import 'package:adora_baby/app/modules/cart/views/personal_info_view.dart';
import 'package:adora_baby/app/modules/shop/views/all_products_page.dart';
import 'package:get/get.dart';

import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/cart/views/checkout_view.dart';
import '../modules/shop/bindings/shop_binding.dart';
import '../modules/shop/views/product_details.dart';
import '../modules/shop/views/shop_view.dart';
import '../modules/auth/bindings/auth_bindings.dart';
import '../modules/auth/views/otp_view.dart';
import '../modules/auth/views/phone_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/walkthrough/bindings/walkthrough_binding.dart';
import '../modules/walkthrough/views/walkthrough_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.rightToLeftWithFade //
        ),
    GetPage(
        name: _Paths.OTP,
        page: () => const OtpView(),
        transition: Transition.rightToLeftWithFade //
        ),
    GetPage(
        name: _Paths.PHONE,
        page: () => const PhoneView(),
        binding: AuthBinding(),
        transition: Transition.noTransition //
        ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: AuthBinding(),
        transition: Transition.noTransition //
        ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WALKTHROUGH,
      page: () => WalkthroughView(),
      binding: WalkthroughBinding(),
    ),
    GetPage(
        name: _Paths.SHOP,
        page: () => ShopView(),
        binding: ShopBinding(),
        transition: Transition.rightToLeftWithFade //
        ),
    GetPage(
        name: _Paths.CART,
        page: () => CartView(),
        binding: CartBinding(),
        transition: Transition.rightToLeftWithFade //
        ),
    GetPage(
        name: _Paths.PRODUCT_DETAILS,
        page: () => const ProductDetails(),
        transition: Transition.rightToLeftWithFade //
        ),
    GetPage(
        name: _Paths.PERSONAL_INFORMATION,
        page: () => PersonalInfoView(),
        transition: Transition.rightToLeftWithFade //transition effect

        ),
    GetPage(
        name: _Paths.ADD_ADDRESS,
        page: () => const AddAddressView(),
        transition: Transition.rightToLeftWithFade //
        ),
    GetPage(
        name: _Paths.CHECKOUT,
        page: () => const CheckOutView(),
        transition: Transition.rightToLeftWithFade //
        ),
    GetPage(
        name: _Paths.ALLPRODUCTS,
        page: () => AllProductsView(),
        transition: Transition.rightToLeftWithFade,),
  ];
}
