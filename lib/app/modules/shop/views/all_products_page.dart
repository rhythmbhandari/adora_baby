import 'package:adora_baby/app/modules/shop/controllers/all_products_controller.dart';
import 'package:adora_baby/app/modules/shop/enums/all_filters_enum.dart';
import 'package:adora_baby/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/hot_sales_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/gradient_icon.dart';
import '../../cart/widgets/empty_widget.dart';
import '../controllers/shop_controller.dart';
import 'getBrandName.dart';

class AllProductsView extends HookWidget {
  AllProductsView( {Key? key, }) : super(key: key);
  
  final ShopController shopController = Get.find();
  final AllProductsController controller = Get.put(AllProductsController(url: Get.arguments['url'] ?? 'shops'));

  @override
  Widget build(BuildContext context) {
    final title = Get.arguments['title'] ?? 'All Products';
    final searchController = useTextEditingController();
    return WillPopScope(
      onWillPop: () async {
        controller.selectedStages.value = '';
        controller.selectedFilter.value = AllFilters.high;
        controller.searchText.value = "";
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 88,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: GestureDetector(
                              onTap: () {
                                controller.selectedStages.value = '';
                                controller.selectedFilter.value = AllFilters.high;
                                controller.searchText.value = "";
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              )),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "$title",
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                        ),
                        const Expanded(flex: 3, child: SizedBox()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  Expanded(
                    child: Container(
                      color: LightTheme.whiteActive,
                      child: Column(
                        children: [
                          Hero(
                            tag: 'search',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 32.0, right: 32, top: 33),
                                child: TextField(
                                  cursorColor: AppColors.mainColor,
                                  autofocus: false,
                                  controller: searchController,
                                  style: kThemeData
                                      .textTheme.bodyLarge
                                      ?.copyWith(
                                      color: DarkTheme.dark),
                                  onSubmitted: (value) =>
                                      controller.onSearch(value),
                                  decoration: InputDecoration(
                                    hintText: 'Search for Items',
                                    filled: true,
                                    hintStyle: kThemeData
                                        .textTheme.bodyLarge
                                        ?.copyWith(
                                        color: const Color(
                                            0xffAF98A8)),
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 18),
                                    suffixIcon: GestureDetector(
                                      onTap: () =>
                                          controller.onSearch(
                                              searchController.text
                                                  .trim()),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            top: 8.0,
                                            right: 23,
                                            bottom: 8),
                                        child: SvgPicture.asset(
                                            "assets/images/search-normal.svg"),
                                      ),
                                    ),
                                    fillColor: Colors.white,
                                    focusedBorder:
                                    OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(33),
                                        borderSide:
                                        const BorderSide(
                                            width: 1,
                                            color: Color
                                                .fromRGBO(
                                                175,
                                                152,
                                                168,
                                                1))),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            33),
                                        borderSide:
                                        const BorderSide(
                                            width: 1,
                                            color:
                                            Color.fromRGBO(
                                                175,
                                                152,
                                                168,
                                                1))),
                                    enabledBorder:
                                    OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(33),
                                        borderSide:
                                        const BorderSide(
                                            width: 1,
                                            color: Color
                                                .fromRGBO(
                                                175,
                                                152,
                                                168,
                                                1))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      allStages(context),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/filter-search.svg"),
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      const Text(
                                        "All Stages",
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                              241, 149, 157, 1),
                                          //styleName: Button Text;
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () =>
                                        mostRecentPressed(
                                            context),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/sort.svg"),
                                        const SizedBox(
                                          width: 11,
                                        ),
                                        const Text(
                                          "Most Recent",
                                          style: TextStyle(
                                            color:
                                            Color.fromRGBO(
                                                241,
                                                149,
                                                157,
                                                1),
                                            //styleName: Button Text;
                                            fontFamily:
                                            "Poppins",
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              color: AppColors.primary300,
                              onRefresh: () => Future.sync(
                                    () => controller.pagingController.refresh(),
                              ),
                              child: PagedListView<int, HotSales>(
                                physics: const AlwaysScrollableScrollPhysics(),
                                pagingController: controller.pagingController,
                                padding: const EdgeInsets.symmetric( vertical: 20),
                                builderDelegate: PagedChildBuilderDelegate<HotSales>(
                                  animateTransitions: true,
                                  firstPageErrorIndicatorBuilder:
                                      (_) => EmptyWidget(
                                      isSearched: true),
                                  noItemsFoundIndicatorBuilder: (context) => EmptyWidget(
                                      isSearched: true),
                                  noMoreItemsIndicatorBuilder: (context) => const Center(child: Text('All products loaded.')),
                                  itemBuilder: (context, product, index) =>
                                      GestureDetector(
                                        onTap: () {
                                          shopController
                                              .productSelected
                                              .value = product;
                                          Get.toNamed(
                                            Routes.PRODUCT_DETAILS,
                                          );
                                        },
                                        child: Container(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 10),
                                          margin:
                                          const EdgeInsets.only(
                                              left: 36,
                                              right: 36,
                                              bottom: 16),
                                          alignment:
                                          Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: const Color
                                                      .fromRGBO(
                                                      192,
                                                      144,
                                                      254,
                                                      0.25)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(
                                                      0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: const Offset(
                                                      0,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15)),
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .only(
                                                        top: 12,
                                                        bottom:
                                                        8),
                                                    child: Center(
                                                      child: Image
                                                          .network(
                                                        product.productImages
                                                            ?.firstWhere(
                                                              (image) => image?.isFeaturedImage != null && image?.isFeaturedImage == true,
                                                          orElse: () => ProductImage(name: 'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png'),
                                                        )
                                                            ?.name ??
                                                            'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png',
                                                        height:
                                                        Get.height *
                                                            0.25,
                                                      ),
                                                    ),
                                                  ),
                                                  product.salePrice !=
                                                      0 &&
                                                      product.salePrice !=
                                                          null
                                                      ? Container(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top:
                                                        2,
                                                        bottom:
                                                        2,
                                                        left:
                                                        6,
                                                        right:
                                                        6),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        8),
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                      gradient:
                                                      const LinearGradient(
                                                        begin:
                                                        Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          AppColors.linear2,
                                                          AppColors.linear1,
                                                        ],
                                                      ),
                                                    ),
                                                    child:
                                                    const Text(
                                                      "Sale!",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white,
                                                          fontFamily:
                                                          "Poppins",
                                                          fontSize:
                                                          16,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontStyle: FontStyle.normal,
                                                          letterSpacing: 0.04),
                                                    ),
                                                  )
                                                      : Container(),
                                                ],
                                              ),
                                              Container(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 13,
                                                    right: 13),
                                                width:
                                                Get.width * 1.5,
                                                decoration: const BoxDecoration(
                                                    color: Color
                                                        .fromRGBO(
                                                        243,
                                                        234,
                                                        249,
                                                        1),
                                                    borderRadius: BorderRadius.only(
                                                        bottomRight:
                                                        Radius.circular(
                                                            15),
                                                        bottomLeft:
                                                        Radius.circular(
                                                            15))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      getBrandName(
                                                          product
                                                              .categories),
                                                      maxLines: 1,
                                                      style: kThemeData
                                                          .textTheme
                                                          .labelSmall
                                                          ?.copyWith(
                                                          color: AppColors
                                                              .secondary700,
                                                          fontSize:
                                                          12),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      product.name ??
                                                          'N/A',
                                                      maxLines: 2,
                                                      style: kThemeData
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                          color: AppColors
                                                              .primary700,
                                                          fontSize:
                                                          14),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    RatingBar
                                                        .builder(
                                                      initialRating:
                                                      product.rating
                                                          ?.gradeAvg ??
                                                          0.0,
                                                      ignoreGestures:
                                                      true,
                                                      itemSize: 12,
                                                      direction: Axis
                                                          .horizontal,
                                                      allowHalfRating:
                                                      true,
                                                      glow: false,
                                                      itemCount: 5,
                                                      itemPadding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          0.0),
                                                      itemBuilder:
                                                          (context,
                                                          _) =>
                                                          GradientIcon(
                                                            Icons.star,
                                                            10.0,
                                                            const LinearGradient(
                                                              colors: <
                                                                  Color>[
                                                                Color.fromRGBO(
                                                                    127,
                                                                    0,
                                                                    255,
                                                                    1),
                                                                Color.fromRGBO(
                                                                    255,
                                                                    0,
                                                                    255,
                                                                    1)
                                                              ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                            ),
                                                          ),
                                                      onRatingUpdate:
                                                          (rating) {
                                                        print(
                                                            rating);
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    product.salePrice !=
                                                        0 &&
                                                        product.salePrice !=
                                                            null
                                                        ? Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                          Text(
                                                            "Rs. ${product.regularPrice}",
                                                            maxLines: 2,
                                                            style: kThemeData.textTheme.bodyMedium?.copyWith(color: DarkTheme.lightActive, decoration: TextDecoration.lineThrough),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Rs. ${product.salePrice}",
                                                          maxLines:
                                                          2,
                                                          style:
                                                          kThemeData.textTheme.bodyMedium?.copyWith(color: DarkTheme.normal),
                                                        ),
                                                        const SizedBox(
                                                          width:
                                                          20,
                                                        )
                                                      ],
                                                    )
                                                        : Text(
                                                      "Rs. ${product.regularPrice}",
                                                      maxLines:
                                                      2,
                                                      style: kThemeData
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(color: DarkTheme.normal),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                ),
                                // separatorBuilder: (context, index) =>
                                // const Divider(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          )),
    );
  }

  void mostRecentPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selectedFilter.value = AllFilters.values[index];
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0) ...[
                        Center(
                          child: Text(
                            'Filters',
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ] else
                        ...[],
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AllFilters.values[index].filterName,
                              style: kThemeData.textTheme.bodyLarge
                                  ?.copyWith(color: DarkTheme.dark),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(
                                      243,
                                      234,
                                      249,
                                      1,
                                    ),
                                    shape: BoxShape.circle),
                              ),
                              Obx(
                                () => controller.selectedFilter.value == AllFilters.values[index]
                                    ? Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                color: AppColors.primary500,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (AllFilters.values.length == index + 1) ...[
                        const SizedBox(
                          height: 32,
                        ),
                        ButtonsWidget(
                            name: 'Apply Filter',
                            onPressed: () {
                              controller.onOrderSelect();
                              Navigator.pop(context);
                            })
                      ]
                    ],
                  ),
                ),
              );
            },
            itemCount: AllFilters.values.length,
          );
        });
  }

  void allStages(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.selectedStages.value = shopController.stagesList[index].id;
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0) ...[
                        Center(
                          child: Text(
                            'Stages',
                            style: kThemeData.textTheme.displaySmall
                                ?.copyWith(color: DarkTheme.dark),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ] else
                        ...[],
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${shopController.stagesList[index].name}',
                              style: kThemeData.textTheme.bodyLarge
                                  ?.copyWith(color: DarkTheme.dark),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(
                                      243,
                                      234,
                                      249,
                                      1,
                                    ),
                                    shape: BoxShape.circle),
                              ),
                              Obx(
                                () => controller.selectedStages.value == shopController.stagesList[index].id
                                    ? Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                color: AppColors.primary500,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (shopController.stagesList.length == index + 1) ...[
                        const SizedBox(
                          height: 32,
                        ),
                        ButtonsWidget(
                            name: 'Apply Filter',
                            onPressed: () {
                              controller.onCategorySelect(controller.selectedStages.value);
                              Navigator.pop(context);
                            })
                      ]
                    ],
                  ),
                ),
              );
            },
            itemCount: shopController.stagesList.length,
          );
        });
  }
}
