import 'package:adora_baby/app/modules/profile/views/edit_child_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../controllers/profile_controller.dart';

void _showPicker(context, controller) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.primary500,
                  ),
                  title: Text('Photo Library'.tr,
                      style: kThemeData.textTheme.bodyMedium),
                  onTap: () async {
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      controller.getImageChild(ImageSource.gallery);
                      Navigator.of(context).pop();
                    } else if (status.isPermanentlyDenied) {
                      openAppSettings();
                    } else {}
                  }),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  color: AppColors.primary500,
                ),
                title:
                    Text('Camera'.tr, style: kThemeData.textTheme.bodyMedium),
                onTap: () async {
                  final status = await Permission.camera.request();
                  debugPrint('Status is $status');
                  if (status.isGranted) {
                    controller.getImageChild(ImageSource.camera);
                    Navigator.of(context).pop();
                  } else if (status.isPermanentlyDenied) {
                    openAppSettings();
                  } else {}
                },
              ),
            ],
          ),
        );
      });
}

Widget babyProfile(ProfileController controller, BuildContext context) {
  return Obx(() => Container(
      decoration: BoxDecoration(
          color: LightTheme.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 34),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'My Child',
                style: kThemeData.textTheme.displaySmall
                    ?.copyWith(color: DarkTheme.normal),
              ),
              SizedBox(
                height: 30,
              ),
              GetBuilder<ProfileController>(
                  builder: (value) => value.imageBoolChild.value
                      ? GestureDetector(
                          onTap: () {
                            _showPicker(context, controller);
                          },
                          child: Center(
                            child: ClipOval(
                              child: Image.file(
                                fit: BoxFit.cover,
                                height: Get.height * 0.14,
                                width: Get.height * 0.14,
                                value.imagesChild!,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            // controller.getImage();
                            _showPicker(context, controller);
                          },
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: Get.height * 0.10,
                                width: Get.height * 0.10,
                                imageUrl: controller.user.value.photos !=
                                            null &&
                                        controller.user.value.photos!.isNotEmpty
                                    ? '${controller.user.value.photos?[1]?.name}'
                                    : '',
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        )),
              Text(
                '${controller.user.value.babyName}',
                style: kThemeData.textTheme.displaySmall
                    ?.copyWith(color: DarkTheme.dark),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '${(DateTime.now().difference(controller.user.value.babyDob != null ? controller.user.value.babyDob! : DateTime.now()).inDays / 30).floor()} Months',
                style: kThemeData.textTheme.bodyLarge
                    ?.copyWith(color: DarkTheme.dark),
              ),
              SizedBox(
                height: 4,
              ),
              controller.selectedTags.isNotEmpty
                  ? Text(
                      'No Allergies, No Difficulties',
                      style: kThemeData.textTheme.bodyLarge
                          ?.copyWith(color: DarkTheme.normal),
                    )
                  : Container(),
              SizedBox(
                height: 12,
              ),
            ],
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                Get.to(EditChildProfile());
              },
              child: SvgPicture.asset(
                "assets/images/profile_edit.svg",
                height: 0.027 * Get.height,
              ),
            ),
            right: 0,
          )
        ],
      )));
}
