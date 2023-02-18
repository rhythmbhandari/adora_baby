import 'package:adora_baby/app/data/repositories/checkout_repositories.dart';
import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/get_address_model.dart';

class AddAddressView extends GetView<CartController> {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController(text: controller.cityName);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60, bottom: 40),
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 150.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
          },
                            child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                        Text(
                          "Address",
                          style: kThemeData.textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                    controller: cityController,
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
                        hintText: 'City',
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
                    controller: controller.landMarkController,
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
                        hintText: 'Nearest Landmark',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(178, 187, 198, 1),
                            letterSpacing: 0.04))),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Set as Primary Address",
                      style: TextStyle(
                        //styleName: Strong;
                        fontFamily: "Poppins",
                        color: Colors.deepOrangeAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Obx(() =>
                        FlutterSwitch(
                          activeColor: Colors.deepOrangeAccent,
                          width: 125.0,
                          height: 55.0,
                          valueFontSize: 25.0,
                          toggleSize: 45.0,
                          value: controller.status.value,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: false,
                          onToggle: (val) {
                            controller.status.value = val;
                          },
                        )),

                  ],
                ),
                const SizedBox(height: 20,),
                FutureBuilder<List<AddressModel>>(
                    future: CheckOutRepository.getAddress(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null &&
                            snapshot.data!.isNotEmpty) {
                          return ButtonsWidget(name: "Save Address", onPressed: () {
                            print("done");
                            controller.requestToUpdateAddress(snapshot.data![0].city.id,
                                controller.landMarkController.text.trim(),
                                controller.status.value ? "PRIMARY" : "SECONDARY");
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
        ),
      ),
    );
  }
}
