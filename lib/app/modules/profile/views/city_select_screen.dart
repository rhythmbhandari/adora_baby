
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/app_colors.dart';
import '../controllers/profile_controller.dart';

class CitySelectScreen extends GetView<ProfileController> {
  const CitySelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshControllerCity =
        RefreshController(initialRefresh: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 248, 244, 1),
      body: SafeArea(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(33),
                          border: Border.all(
                            color: const Color.fromRGBO(84, 104, 129, 1)
                                .withOpacity(0.4),
                          ),
                        ),
                        child: TextField(
                          cursorColor: const Color.fromRGBO(84, 104, 129, 1),
                          // focusNode: searchNode,
                          autofocus: false,
                          style: Get.theme.textTheme.bodyLarge?.copyWith(
                            color: const Color.fromRGBO(84, 104, 129, 1),
                          ),
                          onSubmitted: (_) => searchSubCategory1(),
                          onChanged: (_) => searchSubCategory1(),
                          controller: controller.searchCitiesController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: Get.theme.textTheme.bodyLarge?.copyWith(
                              color: const Color.fromRGBO(84, 104, 129, 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: AppColors.secondary50)),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: AppColors.secondary50)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: AppColors.secondary50)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: AppColors.secondary50,
                height: 8,
                thickness: 8,
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: 34,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    'Select City',
                    style: Get.theme.textTheme.bodyLarge?.copyWith(
                        color: const Color.fromRGBO(84, 104, 129, 1),
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  )),
              const Divider(
                color: AppColors.primary50,
                height: 1,
                thickness: 1,
              ),
              Expanded(
                child: SmartRefresher(
                  physics: const AlwaysScrollableScrollPhysics(),
                  enablePullDown: true,
                  enablePullUp: false,
                  header: const ClassicHeader(
                    refreshStyle: RefreshStyle.Follow,
                    releaseIcon: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CupertinoActivityIndicator()),
                    failedIcon: Icon(Icons.error, color: Colors.grey),
                    idleIcon: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CupertinoActivityIndicator.partiallyRevealed(
                          progress: 0.4,
                        )),
                    releaseText: '',
                    idleText: '',
                    failedText: '',
                    completeText: '',
                    refreshingText: '',
                    refreshingIcon: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CupertinoActivityIndicator()),
                  ),
                  footer: const ClassicFooter(
                    // refreshStyle: RefreshStyle.Follow,
                    canLoadingText: '',
                    loadStyle: LoadStyle.ShowWhenLoading,
                    noDataText: '',
                    noMoreIcon: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child:
                            Icon(Icons.expand_circle_down, color: Colors.red)),
                    canLoadingIcon: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CupertinoActivityIndicator()),
                    failedIcon: Icon(Icons.error, color: Colors.grey),
                    idleIcon: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CupertinoActivityIndicator.partiallyRevealed(
                          progress: 0.4,
                        )),
                    idleText: '',
                    failedText: '',
                    loadingText: '',
                    loadingIcon: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CupertinoActivityIndicator()),
                  ),
                  controller: refreshControllerCity,
                  onRefresh: () => controller.onRefreshCategories(
                    refreshControllerCity,
                  ),
                  child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      itemCount: controller.filteredCitiesList.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedCity.value =
                                controller.filteredCitiesList[index].id;
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.secondary50,
                              ),
                            ),
                            // height: 110,
                            // width: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${controller.filteredCitiesList[index].city.toString().capitalize}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: Get.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                          color:
                                              const Color.fromRGBO(84, 104, 129, 1),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchSubCategory1() {
    var nepali = RegExp(r'[\u0900-\u097F]+');

    final str = controller.searchCitiesController.text;
    if (nepali.hasMatch(str)) {
    } else {
    }
    if (controller.searchCitiesController.text != '') {
      controller.filteredCitiesList.value = controller.citiesList
          .where(
            (e) => e.city.toString().toLowerCase().replaceAll(' ', '').contains(
                controller.searchCitiesController.text
                    .toLowerCase()
                    .replaceAll(' ', '')),
          )
          .toList();
    } else {
      controller.filteredCitiesList.value = controller.citiesList;
    }
  }
}
