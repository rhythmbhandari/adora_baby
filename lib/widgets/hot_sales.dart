import 'package:adora_baby/repositories/shop_respository.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/config/app_colors.dart';
import '../app/config/app_theme.dart';
import '../models/hot_sales_model.dart';

class HotSale extends StatelessWidget {
  const HotSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40.0,
        right: 40,
        top: 80,
        bottom: 40,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Hot Sales",
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontFamily: "PLayfair",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.01,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: FutureBuilder<List<Datum>>(
                  future: ShopRepository.hotSales(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return GridView.count(
                          childAspectRatio: 0.55,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(
                            snapshot.data!.length,
                            (index) => Container(
                              padding: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          192, 144, 254, 0.25)),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Image.network(snapshot.data![index].productImages[index].name, height: 100,),
                                      snapshot.data![index].productImages[index].isFeaturedImage==true?
                                      Container(
                                        padding:const EdgeInsets.only(top: 2,bottom: 2,left: 6,right: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              AppColors.linear2,
                                              AppColors.linear1,
                                            ],
                                          ),
                                        ),
                                        child:  const Text("Sale!",style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 0.04),
                                        ),
                                      ): const SizedBox()
                                    ],
                                  ),
                                  const SizedBox(height: 5,),

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(
                                              243, 234, 249, 1),
                                          borderRadius:
                                              BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))),
                                      child: Text(

                                        snapshot.data![index].name,
                                        style: kThemeData.textTheme.bodyMedium,

                                      )
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "You don’t seem to have hot sales. Try again later",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Graphik',
                                color: Colors.white.withOpacity(0.67),
                                letterSpacing: 1.25,
                                fontWeight: FontWeight.w300),
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text("Sorry,not found!"),
                      );
                    }

                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(top: 0.2 * Get.height),
                      child: const CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
