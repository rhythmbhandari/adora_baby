import 'package:adora_baby/app/config/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../controllers/search_controller.dart';

class SearchResultsView extends GetView<SearchController>  {
  const SearchResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final node = FocusScope.of(context);
    // node.requestFocus(searchNode);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 248, 244, 1),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 11.0, left: 32, bottom: 10),
                        // padding: const EdgeInsets.only(left: 10),
                        child: const Icon(Icons.arrow_back_ios,
                            color: Color.fromRGBO(84, 104, 129, 1)))),
                Expanded(
                  child: Hero(
                    tag: 'search',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 11.0, left: 14, right: 32, bottom: 10),
                        color: Colors.white,
                        child: TextField(
                          cursorColor: AppColors.primary300,
                          // focusNode: searchNode,
                          // autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Hair-cut',

                            label: Text(
                              'Hair-cut',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintStyle: kThemeData.textTheme.bodyLarge,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            suffixIcon: Image.asset(
                              'assets/images/search-normal.png',
                              color: const Color.fromRGBO(84, 104, 129, 1),
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.secondary500)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.secondary500)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.secondary500)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Container(
                color: const Color(0xfff5f0e7),
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 34, vertical: 12),
                child: Text(
                  '20 results for "Hair-cut" ',
                  style: kThemeData.textTheme.bodyLarge,
                ),
              ),
              Container(
                color: const Color.fromRGBO(254, 211, 156, 1),
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 34, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                          color: Color.fromRGBO(8, 76, 177, 1),
                          fontSize: 16.0,
                          fontFamily: 'Encode Sans',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 33),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // border: Border.all(color: AppColors.dan50),
                                color: Colors.white,
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 1,
                                    spreadRadius: 1.5,
                                    offset: Offset(-0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      child: Image.asset(
                                          'assets/images/Frame 15.png')),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Neel Davids Salon sdfkjsbdfs',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  84, 104, 129, 1)),
                                        ),
                                        const Text(
                                          'Starting at Rs. 350',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  84, 104, 129, 1)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Slots Available:',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Color.fromRGBO(
                                                  29, 36, 45, 1)),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.cloud_outlined,
                                              color: AppColors.secondary500,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.sunny,
                                              color: AppColors.secondary500,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.sunny_snowing,
                                              color: AppColors.primary300,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        )));
  }
}
