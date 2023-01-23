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
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: DarkTheme.normal.withOpacity(0.7),
                              )),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder<List<Datum>>(
                                        future: CheckOutRepository.getAddress(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data != null &&
                                                snapshot.data!.isNotEmpty) {
                                              return SizedBox(
                                                height: 250,
                                                width: 200,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(
                                                        children: [
                                                          Obx(
                                                            () => Checkbox(
                                                              shape:
                                                                  const CircleBorder(),
                                                              value: controller
                                                                  .value[index],
                                                              onChanged:
                                                                  (bool? val) {
                                                                controller.value[
                                                                        index] =
                                                                    val!;
                                                              },
                                                            ),
                                                          ),
                                                          Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .city
                                                                  .city,
                                                              style: TextStyle(
                                                                //styleName: Small Copy;
                                                                fontFamily:
                                                                    "Poppins",
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              )),
                                                        ],
                                                      );
                                                    }),
                                              );
                                            }
                                          } else if (snapshot.hasError) {
                                            print(snapshot.error);
                                            return const Center(
                                              child: Text("Sorry,not found!"),
                                            );
                                          }

                                          return CircularProgressIndicator();
                                        }),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: DarkTheme.normal
                                                  .withOpacity(0.7),
                                            )),
                                        child: Column(
                                          children: [
                                            Text("Add\nNew\nAddress",
                                                style: TextStyle(
                                                  //styleName: Small Copy;
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: DarkTheme.normal
                                                      .withOpacity(0.7),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Image.asset(
                                                "assets/images/location-add.png")
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Special Notes",
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
                            controller: controller.notesController,
                            cursorColor: AppColors.mainColor,
                            style: kThemeData.textTheme.bodyLarge,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 80, horizontal: 24),
                                // <-- SEE HERE

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: DarkTheme.normal.withOpacity(0.7),
                                    ),
                                    borderRadius: BorderRadius.circular(33)),
                                hintText:
                                    'Type anything specific to your child',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Color.fromRGBO(178, 187, 198, 1),
                                    letterSpacing: 0.04))),
                        const SizedBox(
                          height: 40,
                        ),
                        FutureBuilder<List<Datum>>(
                            future: CheckOutRepository.getAddress(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null &&
                                    snapshot.data!.isNotEmpty) {
                                  return ButtonsWidget(
                                      name: "Next",
                                      onPressed: () async {
                                        final status =
                                            await controller.requestToCheckOut(
                                                controller.fNameController.text
                                                    .trim(),
                                                controller.phoneController.text
                                                    .trim(),
                                                controller
                                                    .altPhoneController.text
                                                    .trim(),
                                                snapshot.data![0].city.id,
                                                controller.notesController.text
                                                    .trim());
                                        if (!status) {
                                          var snackBar = SnackBar(
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red,
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            content: Text(controller.authError
                                                .toUpperCase()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          controller.progressBarStatusOtp
                                              .value = false;
                                        } else {
                                          var snackBar = SnackBar(
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.green,
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            content:
                                                Text("Success!".toUpperCase()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Get.offNamed(Routes.CHECKOUT);
                                          controller.progressBarStatusOtp
                                              .value = false;
                                        }
                                      });
                                }
                              } else if (snapshot.hasError) {
                                print(snapshot.error);
                                return const Center(
                                  child: Text("Sorry,not found!"),
                                );
                              }

                              return CircularProgressIndicator();
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
