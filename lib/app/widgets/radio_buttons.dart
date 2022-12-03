import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class RadioButtonWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const RadioButtonWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (title != null) title,
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _customRadioButton,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      width: 30,
      height: 40,
      decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mainColor
              : const Color.fromRGBO(243, 234, 249, 1),
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: const Color.fromRGBO(243, 234, 249, 1),
                  width: 5,
                )
              : null),
    );
  }
}
