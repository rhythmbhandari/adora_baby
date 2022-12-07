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
import '../controllers/cart_controller.dart';

class ProductDetails extends GetView<CartController> {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List data = Get.arguments;


    return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 245, 252, 1),
        body: SafeArea(
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
                      padding: const EdgeInsets.only(left:30.0),
                      child: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                          child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                    ),
                    const SizedBox(width: 60,),
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
              Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
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
                                    itemBuilder: (context,index){
                                  return  GradientIcon(

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
                              height: 20,
                            ),
                            Center(
                                child: Image.network(
                              data[1],
                              width: 250,
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Text(controller.quantity.toString()),

            ],
          ),

        ),
    bottomNavigationBar: Container(
      height: 70,
      color: const Color.fromRGBO(
          243, 234, 249, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 30,top: 10,bottom: 7),
        child: Center(child: ButtonsWidget(name: "ADD TO CART", onPressed: () {
          controller.requestAddToCart(data[0]);
        },)),
      ),
    ),


    );
  }
}
