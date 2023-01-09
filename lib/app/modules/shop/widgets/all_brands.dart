// import 'package:adora_baby/app/data/repositories/shop_respository.dart';
// import 'package:flutter/material.dart';
// import '../../../config/app_theme.dart';
// import '../../../data/models/stages_brands.dart';
// import '../../../widgets/custom_progress_bar.dart';
//
// class AllBrands extends StatelessWidget {
//   const AllBrands({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 30.0,
//         right: 30,
//
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: FutureBuilder<List<Datum>>(
//                   future: ShopRepository.brands(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       if (snapshot.data != null) {
//                        return GridView.count(
//                          mainAxisSpacing: 10,
//                          crossAxisSpacing: 10,
//                          childAspectRatio: 0.7,
//                                 shrinkWrap: true,
//                                 crossAxisCount: 2,
//                                 children: List.generate(
//                                   snapshot.data!.length,
//                                   (index) => Container(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                             color: const Color.fromRGBO(
//                                                 192, 144, 254, 0.25)),
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Column(
//                                       children: [
//                                         Stack(
//                                           children: [
//                                             Image.network(
//                                               snapshot.data![index].image,
//                                               height: 100,
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         Expanded(
//                                           child: Container(
//                                               padding: const EdgeInsets.only(
//                                                   left: 5, right: 5),
//                                               decoration: const BoxDecoration(
//                                                   color: Color.fromRGBO(
//                                                       243, 234, 249, 1),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   15),
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   15))),
//                                               child: Text(
//                                                 snapshot.data![index].name,
//                                                 style: kThemeData
//                                                     .textTheme.bodyMedium,
//                                               )),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//
//                       } else {
//                         return Container();
//                       }
//                     } else if (snapshot.hasError) {
//                       print(snapshot.error);
//                       return const Center(
//                         child: Text("Sorry,not found!"),
//                       );
//                     }
//
//                     return Center(
//                         child: CustomProgressBar());
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
