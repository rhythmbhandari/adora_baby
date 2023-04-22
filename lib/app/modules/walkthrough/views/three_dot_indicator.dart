import 'package:adora_baby/app/config/app_colors.dart';
import 'package:flutter/material.dart';

class ThreeDotIndicator extends StatelessWidget {
  final int positionIndex, currentIndex;

  const ThreeDotIndicator(
      {super.key, required this.currentIndex, required this.positionIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: positionIndex == currentIndex ? 17 : 8.5,
      width: positionIndex == currentIndex ? 17 : 8.5,
      decoration: BoxDecoration(
        color: positionIndex == currentIndex
            ? AppColors.secondary600
            : AppColors.secondary600.withOpacity(0.59),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
