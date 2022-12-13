import 'package:adora_baby/app/config/app_colors.dart';
import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/gradient_icon.dart';
import '../../../widgets/tab_bar.dart';
import '../controllers/cart_controller.dart';

class ProductDetails extends GetView<CartController> {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List data = Get.arguments;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 245, 252, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 88,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Center(
                      child: Text(
                        "Product Detail",
                        style: kThemeData.textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, int index) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Text(
                              data[0],
                              style: const TextStyle(
                                  color: AppColors.mainColor,
                                  fontFamily: "Playfair",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.01),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              height: 30,
                              child: ListView.builder(
                                  itemCount: int.parse(data[2]),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GradientIcon(
                                      Icons.star,
                                      23.0,
                                      const LinearGradient(
                                        colors: <Color>[
                                          AppColors.linear2,
                                          AppColors.linear1,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          229, 159, 164, 1))),
                              child: const Text(
                                "Supported Sitter",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(151, 121, 142, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Image.network(
                            data[1],
                            width: 250,
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                data[3] == true
                                    ? const Text(
                                        "In Stock",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    : const Text(
                                        "Out of Stock",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                SvgPicture.asset("assets/images/send.svg")
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 15, bottom: 15),
                            child: Text(
                              "Rs. ${data[4].toString()}",
                              style: kThemeData.textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, right: 30),
                              child: data[5] != null
                                  ? Text(data[5].toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ))
                                  : const Text("Weight N/A",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ))),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 8),
                            child: Text("Best by: ${data[6]}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 30.0, right: 30, top: 8),
                            child: Text("Delivered within: 22 October",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )),
                          )
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity",
                      style: kThemeData.textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.decrementCounter();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black)),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: Obx(
                                () => Text(
                                  controller.counter.value.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              )),
                          GestureDetector(
                            onTap: () {
                              controller.incrementCounter();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),


                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30),
                  child: TabBars(overView: 'Overview', details: data[7], reviews: data[8],),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: const Color.fromRGBO(243, 234, 249, 1),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10, bottom: 7),
              child: ButtonsWidget(
                name: "ADD TO CART",
                onPressed: () {
                  controller.requestAddToCart(data[0]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: SvgPicture.asset('assets/images/like.svg'),
            )
          ],
        )),
      ),
    );
  }
}
