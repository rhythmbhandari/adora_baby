import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WalkthroughContent extends StatelessWidget {
  final String heading;
  final String content;
  final String imageUrl;
  final bool centerImage;
  final Color appColors;
  final double index;

  const WalkthroughContent(
      {super.key,
      required this.heading,
      required this.content,
      this.centerImage = true,
      required this.appColors,
      required this.index,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: index == 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.06),
                Center(
                  child: SvgPicture.asset(
                    imageUrl,
                    height: Get.height * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                Text(
                  heading,
                  textAlign: TextAlign.start,
                  style: Get.textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(color: const Color(0xff1D242D)),
                  textAlign: TextAlign.start,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.1),
                Text(
                  heading,
                  textAlign: TextAlign.start,
                  style: Get.textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: Get.textTheme.bodyLarge
                      ?.copyWith(color: const Color(0xff1D242D)),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: Get.height * 0.05),
                index == 2
                    ? Center(
                        child: Image.asset(
                          imageUrl,
                          height: Get.height * 0.6,
                          // fit: BoxFit.contain,
                        ))
                    : Center(
                        child: SvgPicture.asset(
                          imageUrl,

                          height: Get.height * 0.6,
                          // fit: BoxFit.contain,
                        ),
                      ),
                SizedBox(height: Get.height * 0.08),
              ],
            ),
    );
  }
}
