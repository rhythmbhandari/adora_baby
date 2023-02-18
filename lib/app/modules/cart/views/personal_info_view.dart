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
import '../../shop/widgets/auth_progress_indicator.dart';
import '../controllers/cart_controller.dart';
import '../widgets/address_widget.dart';

class PersonalInfoView extends GetView<CartController> {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return progressWrap(
        Scaffold(
            backgroundColor: LightTheme.white,
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: [
              Container(
                color: LightTheme.white,
                margin: EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                padding: EdgeInsets.only(
                  bottom: Get.height * 0.02,
                  top: Get.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios_new)),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      'Personal Information',
                      style: kThemeData.textTheme.displaySmall
                          ?.copyWith(color: DarkTheme.normal),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 32.0, right: 32.0, top: 27),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Identification",
                      style: kThemeData.textTheme.titleMedium?.copyWith(
                        color: DarkTheme.darkNormal,
                      ),
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
                            hintText: 'Fullname',
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
                      height: 24,
                    ),
                    Text(
                      "Contact Information",
                      style: kThemeData.textTheme.titleMedium?.copyWith(
                        color: DarkTheme.darkNormal,
                      ),
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
                        hintStyle: kThemeData.textTheme.bodyLarge?.copyWith(
                            color: const Color.fromRGBO(
                          178,
                          187,
                          198,
                          1,
                        )),
                      ),
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
                      height: 26,
                    ),
                    Text(
                      "Address Information",
                      style: kThemeData.textTheme.titleMedium?.copyWith(
                        color: DarkTheme.darkNormal,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Obx(() => controller.addressList.isNotEmpty
                                    ? buildAddressWidget(controller)
                                    : Container()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.ADD_ADDRESS);
                          },
                          child: Container(
                            width: Get.width * 0.25,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 25, bottom: 25),
                            margin: EdgeInsets.only(
                              left: 25,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromRGBO(
                                      192, 144, 254, 0.25)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: Column(
                              children: [
                                Image.asset("assets/images/location-add.png"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Add New Address" + '\n',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: kThemeData.textTheme.bodyMedium
                                        ?.copyWith(
                                            color: DarkTheme.darkLightActive)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ])))),
        controller.progressBarStatusInformation);
  }
}

// class PersonalInfoView extends GetView<CartController> {
//   const PersonalInfoView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: LightTheme.light,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(top: 60, bottom: 40),
//                   width: double.infinity,
//                   color: Colors.white,
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 25.0, right: 95),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 Get.back();
//                               },
//                               child: const Icon(Icons.arrow_back_ios_new)),
//                           Text(
//                             "Personal Information",
//                             style: kThemeData.textTheme.displaySmall,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//
//                         Container(
//                           padding: EdgeInsets.only(top: 40),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: DarkTheme.normal.withOpacity(0.7),
//                               )),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 30.0, right: 30),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     FutureBuilder<List<Datum>>(
//                                         future: CheckOutRepository.getAddress(),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.hasData) {
//                                             if (snapshot.data != null &&
//                                                 snapshot.data!.isNotEmpty) {
//                                               return SizedBox(
//                                                 height: 250,
//                                                 width: 200,
//                                                 child: ListView.builder(
//                                                     shrinkWrap: true,
//                                                     itemCount:
//                                                         snapshot.data!.length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       return Row(
//                                                         children: [
//                                                           Obx(
//                                                             () => Checkbox(
//                                                               shape:
//                                                                   const CircleBorder(),
//                                                               value: controller
//                                                                   .value[index],
//                                                               onChanged:
//                                                                   (bool? val) {
//                                                                 controller.value[
//                                                                         index] =
//                                                                     val!;
//                                                               },
//                                                             ),
//                                                           ),
//                                                           Text(
//                                                               snapshot
//                                                                   .data![index]
//                                                                   .city
//                                                                   .city,
//                                                               style: TextStyle(
//                                                                 //styleName: Small Copy;
//                                                                 fontFamily:
//                                                                     "Poppins",
//                                                                 color: Colors
//                                                                     .black
//                                                                     .withOpacity(
//                                                                         0.8),
//                                                                 fontSize: 14,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                               )),
//                                                         ],
//                                                       );
//                                                     }),
//                                               );
//                                             }
//                                           } else if (snapshot.hasError) {
//                                             print(snapshot.error);
//                                             return const Center(
//                                               child: Text("Sorry,not found!"),
//                                             );
//                                           }
//
//                                           return CircularProgressIndicator();
//                                         }),

//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(top: 20, bottom: 40),
//                   width: double.infinity,
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 50.0, right: 50),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Special Notes",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: "Poppins",
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         TextField(
//                             controller: controller.notesController,
//                             cursorColor: AppColors.mainColor,
//                             style: kThemeData.textTheme.bodyLarge,
//                             decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 80, horizontal: 24),
//                                 // <-- SEE HERE
//
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(33),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       width: 1,
//                                       color: DarkTheme.normal.withOpacity(0.7),
//                                     ),
//                                     borderRadius: BorderRadius.circular(33)),
//                                 hintText:
//                                     'Type anything specific to your child',
//                                 hintStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16,
//                                     fontFamily: 'Poppins',
//                                     color: Color.fromRGBO(178, 187, 198, 1),
//                                     letterSpacing: 0.04))),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         FutureBuilder<List<Datum>>(
//                             future: CheckOutRepository.getAddress(),
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData) {
//                                 if (snapshot.data != null &&
//                                     snapshot.data!.isNotEmpty) {
//                                   return ButtonsWidget(
//                                       name: "Next",
//                                       onPressed: () async {
//                                         final status =
//                                             await controller.requestToCheckOut(
//                                                 controller.fNameController.text
//                                                     .trim(),
//                                                 controller.phoneController.text
//                                                     .trim(),
//                                                 controller
//                                                     .altPhoneController.text
//                                                     .trim(),
//                                                 snapshot.data![0].city.id,
//                                                 controller.notesController.text
//                                                     .trim());
//                                         if (!status) {
//                                           var snackBar = SnackBar(
//                                             elevation: 0,
//                                             behavior: SnackBarBehavior.floating,
//                                             backgroundColor: Colors.red,
//                                             duration: const Duration(
//                                                 milliseconds: 2000),
//                                             content: Text(controller.authError
//                                                 .toUpperCase()),
//                                           );
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(snackBar);
//                                           controller.progressBarStatusOtp
//                                               .value = false;
//                                         } else {
//                                           var snackBar = SnackBar(
//                                             elevation: 0,
//                                             behavior: SnackBarBehavior.floating,
//                                             backgroundColor: Colors.green,
//                                             duration: const Duration(
//                                                 milliseconds: 2000),
//                                             content:
//                                                 Text("Success!".toUpperCase()),
//                                           );
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(snackBar);
//                                           Get.offNamed(Routes.CHECKOUT);
//                                           controller.progressBarStatusOtp
//                                               .value = false;
//                                         }
//                                       });
//                                 }
//                               } else if (snapshot.hasError) {
//                                 print(snapshot.error);
//                                 return const Center(
//                                   child: Text("Sorry,not found!"),
//                                 );
//                               }
//
//                               return CircularProgressIndicator();
//                             }),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
