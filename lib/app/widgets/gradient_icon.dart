import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child:
      // Icon(
      //   icon,
      //   size: size,
      //   color: Colors.white,
      // ),
      SvgPicture.asset("assets/images/star.svg",
          height: size, color: Colors.white),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}