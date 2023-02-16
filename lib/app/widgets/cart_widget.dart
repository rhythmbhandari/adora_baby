import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../data/models/get_carts_model.dart';
import '../data/repositories/cart_repository.dart';
import 'buttons.dart';

class Carts extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    CartController controller=Get.find();
   return   Container(
     color: Colors.white,
     child: FutureBuilder<List<Datum>>(
         future: CartRepository.getCart(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             if (snapshot.data != null &&
                 snapshot.data!.isNotEmpty) {
               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Padding(
                     padding:
                     const EdgeInsets.only(left: 30.0, top: 20),
                     child: Text(
                       "${snapshot.data!.length} items in your cart",
                       style: kThemeData.textTheme.labelLarge,
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(
                         left: 30.0, right: 38, top: 40),
                     child: Row(
                       mainAxisAlignment:
                       MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Checkbox(
                               value: false,
                               onChanged: (bool? value) {},
                             ),
                             Text(
                               "Select All",
                               style: kThemeData.textTheme.bodyLarge,
                             ),
                           ],
                         ),
                         GestureDetector(
                             onTap: () {
                               // controller.requestToDeleteCart(
                               //     snapshot.data![0].id!);
                             },
                             child: const Text(
                               "Remove Selected",
                               style: TextStyle(
                                 color: Colors.black,
                                 fontFamily: "Poppins",
                                 fontSize: 16,
                                 fontWeight: FontWeight.w600,
                               ),
                             )
                         )
                       ],
                     ),
                   ),
                   GestureDetector(
                       onTap: () {},
                       child: AlignedGridView.count(
                           crossAxisCount: 1,
                           mainAxisSpacing: 20,
                           crossAxisSpacing: 20,
                           shrinkWrap: true,
                           itemCount: snapshot.data!.length,
                           physics:
                           const NeverScrollableScrollPhysics(),
                           itemBuilder: (context, int index) {
                             return Padding(
                               padding: const EdgeInsets.only(
                                   left: 30.0, right: 30, top: 10),
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                     borderRadius:
                                     BorderRadius.circular(20.0),
                                     side: BorderSide(
                                       color: Colors.grey
                                           .withOpacity(0.2),
                                     )),
                                 elevation: 5,
                                 child: Padding(
                                   padding: const EdgeInsets.only(
                                       left: 5,
                                       right: 5,
                                       top: 40,
                                       bottom: 40),
                                   child: Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment
                                         .spaceBetween,
                                     crossAxisAlignment:
                                     CrossAxisAlignment.start,
                                     children: [
                                       Flexible(
                                         fit: FlexFit.loose,
                                         child: Padding(
                                             padding:
                                             const EdgeInsets
                                                 .only(
                                                 top: 70.0),
                                             child: Obx(
                                                   () => Checkbox(
                                                 value: controller
                                                     .value[index],
                                                 onChanged:
                                                     (bool? val) {
                                                   controller.value[
                                                   index] = val!;
                                                 },
                                               ),
                                             )),
                                       ),
                                       SizedBox(
                                           height: 180,
                                           child: Image.network(
                                               snapshot
                                                   .data![index]
                                                   .product!
                                                   .productImages![
                                               0]!
                                                   .name!)),
                                       Column(
                                         crossAxisAlignment:
                                         CrossAxisAlignment
                                             .start,
                                         children: [
                                           SizedBox(
                                             width: 150,
                                             child: Text(
                                               snapshot
                                                   .data![index]
                                                   .product!
                                                   .shortName!,
                                               style:
                                               const TextStyle(
                                                   fontFamily:
                                                   "Poppins",
                                                   fontSize: 16,
                                                   fontWeight:
                                                   FontWeight
                                                       .w600,
                                                   color: Color
                                                       .fromRGBO(
                                                       151,
                                                       121,
                                                       142,
                                                       1)),
                                             ),
                                           ),
                                           SizedBox(
                                             width: 200,
                                             child: Text(
                                               snapshot.data![index]
                                                   .product!.name!,
                                               style: const TextStyle(
                                                   fontFamily:
                                                   "Poppins",
                                                   fontSize: 16,
                                                   fontWeight:
                                                   FontWeight
                                                       .w700,
                                                   color: AppColors
                                                       .mainColor),
                                             ),
                                           ),
                                           snapshot
                                               .data![index]
                                               .product!
                                               .stockAvailable!
                                               ? const Text(
                                               "In-Stock",
                                               style: TextStyle(
                                                 fontFamily:
                                                 "Poppins",
                                                 fontSize: 16,
                                                 fontStyle:
                                                 FontStyle
                                                     .italic,
                                                 fontWeight:
                                                 FontWeight
                                                     .w600,
                                                 color: Colors
                                                     .green,
                                               ))
                                               : const Text(
                                             "Out of stock",
                                             style: TextStyle(
                                                 fontStyle:
                                                 FontStyle
                                                     .italic,
                                                 fontFamily:
                                                 "Poppins",
                                                 fontSize: 16,
                                                 fontWeight:
                                                 FontWeight
                                                     .w600,
                                                 color: Colors
                                                     .red),
                                           ),
                                           const SizedBox(
                                             height: 20,
                                           ),
                                           Row(
                                             children: [
                                               Row(
                                                 mainAxisSize:
                                                 MainAxisSize
                                                     .min,
                                                 mainAxisAlignment:
                                                 MainAxisAlignment
                                                     .start,
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment
                                                     .start,
                                                 children: [
                                                   GestureDetector(
                                                     onTap: () {
                                                       controller
                                                           .decrementCounter(
                                                           index);
                                                     },
                                                     child:
                                                     Container(
                                                       padding:
                                                       const EdgeInsets
                                                           .all(2),
                                                       decoration: BoxDecoration(
                                                           shape: BoxShape
                                                               .circle,
                                                           border: Border.all(
                                                               color:
                                                               DarkTheme.normal)),
                                                       child:
                                                       const Icon(
                                                         Icons
                                                             .remove,
                                                         color: DarkTheme
                                                             .normal,
                                                       ),
                                                     ),
                                                   ),
                                                   const SizedBox(
                                                     width: 14,
                                                   ),
                                                   Flexible(
                                                     fit: FlexFit
                                                         .loose,
                                                     child: Padding(
                                                       padding: const EdgeInsets
                                                           .only(
                                                           top: 3.0),
                                                       child:
                                                       Container(
                                                           padding: const EdgeInsets.only(
                                                               left:
                                                               15,
                                                               right:
                                                               15,
                                                               top:
                                                               5,
                                                               bottom:
                                                               5),
                                                           decoration: BoxDecoration(
                                                               borderRadius: BorderRadius.circular(10),
                                                               border: Border.all(color: DarkTheme.normal)),
                                                           child: Center(
                                                             child:
                                                             Obx(
                                                                   () => Text(
                                                                 controller.counter[index].toString(),
                                                                 style: const TextStyle(color: DarkTheme.dark, fontFamily: 'Poppins', fontWeight: FontWeight.w900, fontSize: 10),
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
                                                       controller
                                                           .incrementCounter(
                                                           index);
                                                     },
                                                     child:
                                                     Container(
                                                       padding:
                                                       const EdgeInsets
                                                           .all(2),
                                                       decoration: BoxDecoration(
                                                           shape: BoxShape
                                                               .circle,
                                                           border: Border.all(
                                                               color:
                                                               DarkTheme.normal)),
                                                       child:
                                                       const Icon(
                                                         Icons.add,
                                                         color: DarkTheme
                                                             .normal,
                                                       ),
                                                     ),
                                                   ),
                                                   Column(
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment
                                                         .end,
                                                     children: [
                                                       Padding(
                                                         padding: const EdgeInsets
                                                             .only(
                                                             top:
                                                             2.0),
                                                         child: SvgPicture
                                                             .asset(
                                                           "assets/images/like.svg",
                                                           height:
                                                           25,
                                                         ),
                                                       ),
                                                       const SizedBox(
                                                         height: 15,
                                                       ),
                                                       Obx(
                                                               () =>
                                                               Text(
                                                                 "Rs. ${snapshot.data![index].product!.regularPrice! * controller.counter[index]}",
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
                           })),
                   Container(
                     color: LightTheme.whiteActive,
                     child: const Text(
                       "abc",
                       style:
                       TextStyle(color: LightTheme.whiteActive),
                     ),
                   ),
                   Container(
                       color: Colors.white,
                       child: Padding(
                           padding: const EdgeInsets.only(left: 70.0),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment:
                                 MainAxisAlignment.spaceBetween,
                                 children: [
                                   Expanded(
                                     child: Text(
                                       "Subtotal:",
                                       style: kThemeData
                                           .textTheme.bodyLarge,
                                     ),
                                   ),
                                   Obx(() => Expanded(
                                       child: Text(
                                         "Rs. ${snapshot.data![0].product!.regularPrice! * controller.counter[0]}",
                                         style: kThemeData
                                             .textTheme.displaySmall,
                                       ))),

                                 ],
                               ),
                               Row(
                                 mainAxisAlignment:
                                 MainAxisAlignment.spaceBetween,
                                 children: [
                                   Expanded(
                                     child: Text(
                                       "Diamond off:",
                                       style: kThemeData
                                           .textTheme.bodyLarge,
                                     ),
                                   ),
                                   Expanded(
                                       child: Text(
                                         "0",
                                         style: kThemeData
                                             .textTheme.displaySmall,
                                       )),

                                 ],
                               ),
                               Row(
                                 mainAxisAlignment:
                                 MainAxisAlignment.spaceBetween,
                                 children: [
                                   Expanded(
                                     child: Text(
                                       "Discount:",
                                       style: kThemeData
                                           .textTheme.bodyLarge,
                                     ),
                                   ),
                                   Expanded(
                                       child: Text(
                                         "Rs. 100",
                                         style: kThemeData
                                             .textTheme.displaySmall,
                                       )),

                                 ],
                               ),
                             ],
                           )
                       )),
                   const SizedBox(
                     height: 30,
                   ),

                   Padding(
                     padding: const EdgeInsets.only(left:30.0,right: 30),
                     child: ButtonsWidget(name: "Proceed", onPressed: (){
                       print("hi");
                     }),
                   ),
                   const SizedBox(
                     height: 100,
                   ),
                 ],
               );
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
