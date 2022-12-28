import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../data/models/get_carts_model.dart';
import '../../shop/widgets/hot_sales.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteActive,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Datum>>(
                  future: CartRepository.getCart(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return GestureDetector(
                            onTap: () {},
                            child: AlignedGridView.count(
                                crossAxisCount: 1,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, right: 30, top: 80),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                          )),
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 40,
                                            bottom: 40),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top:70.0),
                                                child: Checkbox(
                                                  checkColor: Colors.greenAccent,
                                                  activeColor: Colors.red,
                                                  value: true,
                                                  onChanged: (bool? values) {
                                                    values!= true;
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: 180,
                                                child: Image.network(snapshot
                                                    .data![index]
                                                    .product
                                                    .productImages[index]
                                                    .name)),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data![index]
                                                      .product.shortName,
                                                  style: const TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                          151, 121, 142, 1)),
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    snapshot.data![index]
                                                        .product.name,
                                                    style: const TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                ),
                                                snapshot.data![index].product
                                                        .stockAvailable
                                                    ? const Text("In-Stock",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 16,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.green,
                                                        ))
                                                    : const Text(
                                                        "OUt of stock",
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.red),
                                                      ),
                                                const SizedBox(height: 20,),
                                                Row(
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller.decrementCounter();
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.all(2),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border:
                                                                Border.all(color: DarkTheme.normal)),
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color: DarkTheme.normal,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 14,
                                                        ),
                                                        Flexible(
                                                          fit: FlexFit.loose,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top:3.0),
                                                            child: Container(
                                                                padding: const EdgeInsets.only(
                                                                    left: 15, right: 15, top: 5, bottom: 5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    border:
                                                                    Border.all(color: DarkTheme.normal)),
                                                                child: Center(
                                                                  child: Obx(
                                                                        () => Text(
                                                                      controller.counter.value.toString(),
                                                                      style: const TextStyle(
                                                                          color: DarkTheme.dark,
                                                                          fontFamily: 'Poppins',
                                                                          fontWeight: FontWeight.w900,
                                                                          fontSize: 10),
                                                                    ),
                                                                  ),
                                                                )),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 14,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller.incrementCounter();
                                                            print(snapshot.data![index].product.regularPrice*controller.counter.value);

                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.all(2),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border:
                                                                Border.all(color: DarkTheme.normal)),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color: DarkTheme.normal,
                                                            ),
                                                          ),
                                                        ),
                                                      
                                                         Column(
                                                           crossAxisAlignment: CrossAxisAlignment.end,
                                                           children: [
                                                             Padding(
                                                               padding: const EdgeInsets.only(top: 2.0),
                                                               child: SvgPicture.asset("assets/images/like.svg",height: 25,),
                                                             ),
                                                             const SizedBox(height: 15,),
                                                             Obx(()=>Text("Rs. ${snapshot.data![index].product.regularPrice*controller.counter.value}",
                                                               style: const TextStyle(
                                                                   color: DarkTheme.dark,
                                                                   fontFamily: 'Poppins',
                                                                   fontWeight: FontWeight.w700,
                                                                   fontSize: 16),

                                                             ))
                                                           ],
                                                         )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                      }
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text("Sorry,not found!"),
                      );
                    }

                    return Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: LightTheme.lightActive,
                        enabled: true,
                        child: _buildImage());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return GridView.count(
      childAspectRatio: 0.6,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(
        4,
        (index) => Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: const Color.fromRGBO(192, 144, 254, 0.25)),
              borderRadius: BorderRadius.circular(15)),
          child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(243, 234, 249, 1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: Text(
                "snapshot.data![index].name",
                style: kThemeData.textTheme.bodyMedium,
              )),
        ),
      ),
    );
  }
}
