import 'package:adora_baby/app/config/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../widgets/buttons.dart';
import '../../../config/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/auth_controllers.dart';

class PhoneView extends GetView<AuthController> {
  const PhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: SvgPicture.asset("assets/images/midwife.svg"),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Text(
                  'Get Started!',
                  style: kThemeData.textTheme.displayMedium),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Just enter your phone number to get started with Adora Baby',
                  // textAlign: TextAlign.justify,
                  style:  kThemeData.textTheme.bodyLarge),

                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border:  Border.all(color: Colors.grey.shade300,width: 0.1) ,

                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: controller.phoneController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.mainColor,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          hintText: 'Phone Number',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(178, 187, 198, 1),
                              letterSpacing: 0.04))),
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonsWidget(
                  name: 'Register',
                  onPressed: () async {

                    if (await controller.validatePhoneNumber()) {

                    final status = await controller.requestOtpController();
                    if (!status) {

                    var snackBar = const SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    duration: Duration(milliseconds: 2000),
                    content: Text("Failed! Try again"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      if (kDebugMode) {
                        print("success");
                      }

                    Get.toNamed(Routes.OTP,arguments: controller.phoneController);
                    }
                    }
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text("Already have an account? ",style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.08),),
                    Text("Login",style: kThemeData.textTheme.bodyMedium,)

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
