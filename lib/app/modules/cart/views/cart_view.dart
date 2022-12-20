import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../data/models/get_carts_model.dart';
import '../../../widgets/hot_sales.dart';
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
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                height: 200,
                                                child: Image.network(snapshot.data![index].product.productImages[index].name)),
                                            Column(
                                              children: [



                                                SizedBox(
                                                  width:180,
                                                  child: Text(
                                                      snapshot.data![index].product.name),
                                                ),
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
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(
        4,
        (index) => Container(
          padding: const EdgeInsets.only(top: 10),
          margin: EdgeInsets.all(10),
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
