import 'package:adora_baby/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/cart_controller.dart';

Widget buildAddressWidget(ProfileController controller) {
  final cards = <Widget>[];
  Widget FeaturedCard;

  if (controller != null) {
    for (int index = 0; index < controller.addressList.length; index++) {
      cards.add(GetBuilder<ProfileController>(
        id: 'addressCheckBox',
        builder: (myController) => GestureDetector(
          onTap: () {
            for (final address in myController.addressList) {
              address.checked = false;
            }
            myController.addressList[index].checked = true;
            myController.update(
              ['addressCheckBox'],
            );
          },
          child: Container(
              padding: const EdgeInsets.only(
                top: 21,
                bottom: 21,
              ),
              margin: EdgeInsets.only(
                  right: index == myController.addressList.length - 1 ? 15 : 25,
                  bottom: 10,
                  left: 3),
              width: Get.width * 0.65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromRGBO(192, 144, 254, 0.25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        side: const BorderSide(
                            width: 1, color: AppColors.primary900),
                        focusColor: AppColors.primary900,
                        value: myController.addressList[index].checked,
                        onChanged: (bool? val) {
                          for (final address in myController.addressList) {
                            address.checked = false;
                          }
                          myController.addressList[index].checked = true;
                          myController.update(
                            ['addressCheckBox'],
                          );
                        },
                        // onChanged: (value) => onChanged,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(myController.addressList[index].addressType,
                            maxLines: 1,
                            style: kThemeData.textTheme.titleMedium
                                ?.copyWith(color: DarkTheme.darkNormal)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            '${myController.addressList[index].nearestLandmark} , ${myController.addressList[index].city.city}' +
                                '\n',
                            softWrap: true,
                            maxLines: 2,
                            style: kThemeData.textTheme.bodyMedium?.copyWith(
                              color: DarkTheme.darkNormal,
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.cityController.text =
                          myController.addressList[index].city.city;
                      controller.selectedCity.value =
                          myController.addressList[index].city.id;
                      controller.landMarkController.text =
                          myController.addressList[index].nearestLandmark;
                      controller.addNameController.text =
                          myController.addressList[index].address;
                      controller.isPrimaryAddAddress.value = myController
                              .addressList[index].addressType
                              .toString()
                              .toLowerCase()
                              .contains('primary')
                          ? true
                          : false ?? false;
                      Get.toNamed(Routes.ADD_ADDRESS, arguments: [true, myController.addressList[index].id, false]);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: SvgPicture.asset(
                        "assets/images/profile_edit.svg",
                        height: 24,
                        width: 24,
                        color: DarkTheme.darkNormal,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ));
    }
    FeaturedCard = Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: cards),
          ),
          SizedBox(
            height: 0,
          ),
        ],
      ),
    );
  } else {
    FeaturedCard = Container();
  }
  return FeaturedCard;
}
