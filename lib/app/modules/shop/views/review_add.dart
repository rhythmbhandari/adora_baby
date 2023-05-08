import 'package:adora_baby/app/modules/shop/controllers/shop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/hot_sales_model.dart';
import '../../../widgets/awesome_snackbar/custom_snack_bar.dart';
import '../../../widgets/awesome_snackbar/top_snack_bar.dart';
import '../../../widgets/gradient_icon.dart';
import '../widgets/auth_progress_indicator.dart';

class AddReview extends GetView<ShopController> {
  const AddReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotSales product = Get.arguments;
    return progressWrap(
        Scaffold(
            backgroundColor: LightTheme.white,
            body: SafeArea(
                child: Stack(children: [
              SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  size: 20,
                                  color: DarkTheme.darkNormal,
                                )),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product.name}",
                                  style: kThemeData.textTheme.displaySmall
                                      ?.copyWith(
                                    color: AppColors.primary700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  "Review this Product",
                                  style:
                                      kThemeData.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primary700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: LightTheme.whiteActive,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rate this Product',
                            style: kThemeData.textTheme.displaySmall?.copyWith(
                              color: AppColors.primary700,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          RatingBar.builder(
                            initialRating: controller.ratingsReview.value,
                            ignoreGestures: false,
                            itemSize: 42,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            glow: false,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.only(right: 30.0),
                            itemBuilder: (context, _) => GradientIcon(
                              Icons.star,
                              26.0,
                              const LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(127, 0, 255, 1),
                                  Color.fromRGBO(255, 0, 255, 1)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              controller.ratingsReview.value = rating;
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Write a Review',
                            style: kThemeData.textTheme.displaySmall?.copyWith(
                              color: AppColors.primary700,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextField(
                            cursorColor: AppColors.mainColor,
                            // focusNode: searchNode,
                            autofocus: true,
                            enabled: true,
                            readOnly: false,
                            controller: controller.reviewController,

                            maxLines: 7,
                            decoration: InputDecoration(
                              hintText: 'Input Value',
                              hintStyle:
                                  kThemeData.textTheme.bodyLarge?.copyWith(
                                      color: const Color.fromRGBO(
                                175,
                                152,
                                168,
                                1,
                              )),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 18),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(175, 152, 168, 1))),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(175, 152, 168, 1))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                  borderSide: const BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(175, 152, 168, 1))),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                controller.showProgressBarReview();
                                final status = await controller
                                    .initiateReview('${product.id}');
                                if (status) {
                                  controller.countingReview.value++;
                                  showTopSnackBar(
                                    Overlay.of(context)!,
                                    CustomSnackBar.success(
                                      message:
                                      'Review posted sucessfully.',
                                    ),
                                    displayDuration: const Duration(
                                      seconds: 3,
                                    ),
                                  );
                                  controller.update(['reviewId']);
                                  Get.back();
                                  controller.reviewController.text = '';
                                  controller.ratingsReview.value = 0.0;
                                } else {
                                  showTopSnackBar(
                                    Overlay.of(context)!,
                                    CustomSnackBar.error(
                                      message:
                                      '${controller.authError.toUpperCase()}',
                                    ),
                                    displayDuration: const Duration(
                                      seconds: 3,
                                    ),
                                  );
                                }

                                controller.hideProgressBarReview();
                              } catch (e) {
                                controller.hideProgressBarReview();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 90, right: 90),
                              decoration: BoxDecoration(
                                color: AppColors.primary500,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text("Post",
                                    style: kThemeData.textTheme.labelMedium),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]))
            ]))),
        controller.progressStatusReview);
  }
}
