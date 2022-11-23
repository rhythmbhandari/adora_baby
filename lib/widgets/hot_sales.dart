
import 'package:adora_baby/repositories/shop_respository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/config/app_colors.dart';


class HotSale extends StatelessWidget {
  const HotSale({super.key});


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
        left: 40.0, right: 40, top: 80, bottom: 40,),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Center(
              child: Text("Hot Sales", style: TextStyle(
                color: AppColors.mainColor,
                fontFamily: "PLayfair",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.01,


              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: FutureBuilder<dynamic>(
                  future: ShopRepository.hotSales(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return  GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                                  itemCount: snapshot.data!.name.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Container(

                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  192, 144, 254, 0.25)),
                                          borderRadius: BorderRadius.circular(
                                              15)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,

                                        children: [
                                          Expanded(child:  Image.network(snapshot.data[index]!.productImages[index].name,fit: BoxFit.fill), ),
                                          Container(
                                              color: const Color.fromRGBO(
                                                  243, 234, 249, 1),
                                              width: double.infinity,
                                              child: Text(snapshot.data[index]!.name))
                                        ],
                                      ),
                                    );
                                  });

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