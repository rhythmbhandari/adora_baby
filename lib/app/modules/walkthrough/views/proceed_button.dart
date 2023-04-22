import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProceedButton extends StatelessWidget {
  final void Function() onPressed;

  const ProceedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(Get.theme.primaryColor),
        elevation: MaterialStateProperty.all<double>(2),
      ),
      onPressed: onPressed,
      icon: Text(
        'Next',
        style: Get.textTheme.headline5
            ?.copyWith(fontSize: 14, color: Colors.white),
      ),
      label: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
