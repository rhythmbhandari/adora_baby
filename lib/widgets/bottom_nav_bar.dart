import 'package:adora_baby/app/config/app_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/config/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Widget> text = [
    AutoSizeText(
      'Home',
      style: kThemeData.textTheme.labelMedium,
      maxLines: 1,
    ),
    AutoSizeText(
      'Moments',
      style: kThemeData.textTheme.labelMedium,
      maxLines: 1,
    ),
    AutoSizeText(
      'Shop',
      style: kThemeData.textTheme.labelMedium,
      maxLines: 1,
    ),
    AutoSizeText(
      'Cart',
      style: kThemeData.textTheme.labelMedium,
      maxLines: 1,
    ),
    AutoSizeText(
      'Profile',
      style: kThemeData.textTheme.labelMedium,
      maxLines: 1,
    )
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FrostedBottomBar(
        opacity: 0.6,
        sigmaX: 5,
        sigmaY: 5,
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 10),
        hideOnScroll: false,
        body: (context, controller) => Padding(
              padding: const EdgeInsets.only(top: 100),
              child: TabBarView(
                  controller: tabController,
                  dragStartBehavior: DragStartBehavior.down,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    Text("home"),
                    Text("moments"),
                    Text("shop"),
                    Text("cart"),
                    Text("profile"),
                  ]),
            ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.linear2,
                AppColors.linear1,
              ],
            ),
          ),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding:
                const EdgeInsets.only(left: 10, right: 10, top: 35),
            controller: tabController,
            indicator: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            tabs: [
              currentPage == 0
                  ? text[0]
                  : const TabsIcon(
                      images: "assets/images/home.svg",
                    ),
              currentPage == 1
                  ? text[1]
                  : const TabsIcon(
                      images: "assets/images/gallery.svg",
                    ),
              currentPage == 2
                  ? text[2]
                  : const TabsIcon(
                      images: "assets/images/shop.svg",
                    ),
              currentPage == 3
                  ? text[3]
                  : const TabsIcon(
                      images: "assets/images/shopping-cart.svg",
                    ),
              currentPage == 4
                  ? text[4]
                  : const TabsIcon(
                      images: "assets/images/profile.svg",
                    )
            ],
          ),
        ));
  }
}

class TabsIcon extends StatelessWidget {
  final String texts;
  final double height;
  final double width;
  final String images;

  const TabsIcon(
      {Key? key,
      this.texts = "Home",
      this.height = 60,
      this.width = 50,
      required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: SvgPicture.asset(
          images,
        ),
      ),
    );
  }
}
