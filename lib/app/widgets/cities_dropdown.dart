import 'package:adora_baby/app/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class AddressDropDown extends StatelessWidget {
  const AddressDropDown({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.addressList,
    required this.isAddressSelected,
  }) : super(key: key);

  final String label;
  final String? value;
  final List addressList;
  final void Function(String?)? onChanged;
  final bool isAddressSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.only(
              left: 0.02 * Get.height,
              right: 0.01 * Get.height,
              top: 0.007 * Get.height,
              bottom: 0.01 * Get.height,
            ),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(33.0),
              border: Border.all(
                  color: DarkTheme.normal.withOpacity(0.5), width: 1),
            ),

            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  enableFeedback: false,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Select City',
                    // floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(178, 187, 198, 1),
                        letterSpacing: 0.04),
                    border: InputBorder.none,
                    // contentPadding: EdgeInsets.all(8)
                  ),
                  style: kThemeData.textTheme.bodyLarge?.copyWith(
                      color: DarkTheme.normal.withOpacity(0.7)),
                  value: value,
                  items: addressList
                      .map((item) => DropdownMenuItem<String>(
                            alignment: Alignment.centerLeft,
                            value: item.id,
                            child: Text(
                              item.city,
                              textAlign: TextAlign.left,
                              style: kThemeData.textTheme.bodyLarge?.copyWith(
                                  color: DarkTheme.normal.withOpacity(0.7)),
                            ),
                          ))
                      .toList(),
                  onChanged: onChanged),
            ),
          );
  }
}
