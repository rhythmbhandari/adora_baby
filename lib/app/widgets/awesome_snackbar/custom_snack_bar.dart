import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/app_colors.dart';

/// Popup widget that you can use by default to show some information
class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar.success({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = successSvg,
    this.textStyle = const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.success900,
        fontFamily: 'Poppins'
    ),
    this.maxLines = 3,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = const Color.fromRGBO(203, 244, 161, 1),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  const CustomSnackBar.warning({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = warningSvg,
    this.textStyle = const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.warning500,
        fontFamily: 'Poppins'
    ),
    this.maxLines = 3,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = const Color.fromRGBO(244, 195, 163, 1),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  static const String warningSvg = 'assets/images/warning-circle-noti.svg';
  static const String successSvg = 'assets/images/tick-circle.svg';
  static const String errorSvg = 'assets/images/close-circle-noti.svg';
  static const String infoSvg= 'assets/images/info-circle-noti.svg';



  const CustomSnackBar.info({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = infoSvg,
    this.textStyle = const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.error900,
        fontFamily: 'Poppins'
    ),
    this.maxLines = 3,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = const Color.fromRGBO(218, 140, 245, 1),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  const CustomSnackBar.error({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = errorSvg,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.error900,
      fontFamily: 'Poppins'
    ),
    this.maxLines = 3,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = const Color.fromRGBO(244, 161, 161, 1),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);



  final String message;
  final String icon;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int maxLines;
  final int iconRotationAngle;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final double iconPositionTop;
  final double iconPositionLeft;
  final EdgeInsetsGeometry messagePadding;
  final double textScaleFactor;
  final TextAlign textAlign;

  @override
  CustomSnackBarState createState() => CustomSnackBarState();
}

class CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(top: 18, bottom: 24, left: 32, right: 27),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
        border: Border.all(color: widget.backgroundColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            widget.icon,
            height: 60,
            width: 60,
          ),
          Expanded(
            child: Padding(
              padding: widget.messagePadding,
              child: Text(
                '${widget.message}',
                style: theme.textTheme.bodyText2?.merge(widget.textStyle),
                textAlign: widget.textAlign,
                overflow: TextOverflow.ellipsis,
                maxLines: widget.maxLines,
                textScaleFactor: widget.textScaleFactor,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  'assets/images/close-circle.svg',
                  height: 24,
                  width: 24,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  'assets/images/close-circle.svg',
                  color: Colors.transparent,
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
          Container(),
        ],
      )
    );
  }
}

const kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 8),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(25));
