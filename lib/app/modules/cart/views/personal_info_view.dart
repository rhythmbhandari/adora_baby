import 'package:adora_baby/app/data/models/get_address_model.dart';
import 'package:adora_baby/app/data/repositories/checkout_repositories.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/cart_controller.dart';

class PersonalInfoView extends GetView<CartController> {
  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    String cityId = Get.find<CartController>().cityId.value;
    String cityName = Get.find<CartController>().cityName.value;

    return Scaffold(
        backgroundColor: LightTheme.whiteActive,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60, bottom: 40),
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 95),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_ios_new)),
                          Text(
                            "Personal Information",
                            style: kThemeData.textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 60, bottom: 40),
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Identification",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                            controller: controller.fNameController,
                            cursorColor: AppColors.mainColor,
                            style: kThemeData.textTheme.bodyLarge,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                hintText: 'Full Name',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 18,
                                ),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Contact Information",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            controller: controller.phoneController,
                            cursorColor: AppColors.mainColor,
                            style: kThemeData.textTheme.bodyLarge,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                hintText: 'Primary Phone Number',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 18,
                                ),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            controller: controller.altPhoneController,
                            cursorColor: AppColors.mainColor,
                            style: kThemeData.textTheme.bodyLarge,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                hintText: 'Alternate Phone Number',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 18,
                                ),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Address",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color:
                                            DarkTheme.normal.withOpacity(0.5),
                                      )),
                                  child: SizedBox(
                                    height: 100,
                                    width: 250,
                                    child: FutureBuilder<List<Datum>>(
                                        future: CheckOutRepository.getAddress(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data != null &&
                                                snapshot.data!.isNotEmpty) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: 3,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0,right: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Obx(
                                                                () => Padding(
                                                                  padding: const EdgeInsets.only(bottom: 14.0),
                                                                  child: Checkbox(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5)),
                                                                    value: controller
                                                                            .value[
                                                                        index],
                                                                    onChanged:
                                                                        (bool?
                                                                            val) {
                                                                      controller.value[
                                                                              index] =
                                                                          val!;
                                                                      controller
                                                                          .requestToDeleteAddress();
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  data != null
                                                                      ? Text(
                                                                          data
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(0.8),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ))
                                                                      : Text(
                                                                          "Set Address Name",
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(0.8),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          )),
                                                                  Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .city
                                                                          .city,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.8),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                      ))
                                                                ],
                                                              ),
                                                             Padding(padding: const EdgeInsets.only(bottom: 20,

                                                             ),
                                                               child:  Image.asset('assets/images/edit.png'),
                                                             )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            }
                                          } else if (snapshot.hasError) {
                                            print(snapshot.error);
                                            return const Center(
                                              child: Text("Sorry,not found!"),
                                            );
                                          }

                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.ADD_ADDRESS);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color:
                                              DarkTheme.normal.withOpacity(0.7),
                                        )),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            "assets/images/location-add.png"),
                                        Text("Add New\nAddress",
                                            style: TextStyle(
                                              //styleName: Small Copy;
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: DarkTheme.normal
                                                  .withOpacity(0.7),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            TextField(



                                controller: controller.notesController,
                                cursorColor: AppColors.mainColor,
                                style: kThemeData.textTheme.bodyLarge,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(33),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: DarkTheme.normal.withOpacity(0.7),
                                        ),
                                        borderRadius: BorderRadius.circular(33)),
                                    hintText: 'Notes',
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 60,
                                    ),
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color.fromRGBO(178, 187, 198, 1),
                                        letterSpacing: 0.04))),
                            const SizedBox(
                              height: 40,
                            ),
                            ButtonsWidget(
                              name: "Next",
                              onPressed: () async {
                                for (int i = 0; i < 15; i++) {
                                  final status =
                                      await controller.requestToCheckOut(
                                          controller.fNameController.text
                                              .trim(),
                                          controller.phoneController.text
                                              .trim(),
                                          controller.altPhoneController.text
                                              .trim(),
                                          cityId.toString(),
                                          controller.notesController.text
                                              .trim());
                                  if (!status) {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      content: Text(
                                          controller.authError.toUpperCase()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    controller.progressBarStatusOtp.value =
                                        false;
                                    break;
                                  } else {
                                    var snackBar = SnackBar(
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green,
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      content: Text("Success!".toUpperCase()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Get.offNamed(Routes.CHECKOUT);
                                    controller.progressBarStatusOtp.value =
                                        false;
                                  }
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
