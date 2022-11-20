import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../controllers/walkthrough_controller.dart';
import 'walkthrough_content.dart';

class PageViewContent extends StatelessWidget {
  final void Function(int)? onPageChanged;
  final PageController pageController;

  PageViewContent({required this.onPageChanged, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: onPageChanged,
      controller: pageController,
      children: <Widget>[
        WalkthroughContent(
          index: 0,
          heading: 'Track your baby’s activities',
          centerImage: false,
          content:
              'Identify trends and habits of your baby to better understand your child',
          imageUrl: 'assets/images/walkthrough_1.svg',
          appColors: Colors.red,
        ),
        WalkthroughContent(
          heading: 'Get exclusive tips on parenting',
          index: 1,
          content:
              'It takes a village to raise a child. Get suggestions and tips from Adora.Baby',
          imageUrl: 'assets/images/walkthrough_2.svg',
          appColors: Colors.green,
        ),
        WalkthroughContent(
          heading: 'Shop best quality products',
          index: 2,
          content:
              'Only the best for your baby. We make zero compromises when it comes to quality.',
          imageUrl: 'assets/images/walkthrough_3.png',
          appColors: Colors.yellow,
        )
      ],
    );
  }
}
