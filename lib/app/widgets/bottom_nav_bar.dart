import 'dart:developer';

import 'package:adora_baby/app/config/app_theme.dart';
import 'package:adora_baby/app/modules/cart/views/cart_view.dart';
import 'package:adora_baby/app/modules/profile/views/profile_view.dart';
import 'package:adora_baby/app/modules/shop/views/shop_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../modules/home/controllers/home_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currentPage;
  final HomeController controller = Get.find();

  final List<Widget> text = [
    Text(
      "Shop",
      style: kThemeData.textTheme.labelMedium?.copyWith(fontSize: 10),
    ),
    Text(
      "Cart",
      style: kThemeData.textTheme.labelMedium?.copyWith(fontSize: 10),
    ),
    Text(
      "Profile",
      style: kThemeData.textTheme.labelMedium?.copyWith(fontSize: 10),
    ),
  ];

  @override
  void initState() {
    currentPage = 0;
    controller.isRedirected.listen((p0) {
      log('It is $p0');
      if (p0 != 3) {
        tabController.index = p0;
      }
    });
    tabController = TabController(length: 3, vsync: this);
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
      bottom: 30,
        opacity: 0.9,
        width: Get.width * 0.7,
        // width: 350,
        sigmaX: 5,
        sigmaY: 5,
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 10),
        hideOnScroll: false,
        body: (context, controller) => TabBarView(
                controller: tabController,
                dragStartBehavior: DragStartBehavior.down,
                physics: const BouncingScrollPhysics(),
                children: [
                  // Text("home"),
                  // Text("moments"),
                  ShopView(),
                  const CartView(),
                  const ProfileView()
                ]),
        child: Container(
          decoration: BoxDecoration(
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
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            controller: tabController,
            onTap: (value) {
              log('Value is $value');
            },
            indicator: const DotIndicator(),
            tabs: [
              // currentPage == 0
              //     ? text[0]
              //     : const TabsIcon(
              //         images: "assets/images/home.svg",
              //       ),
              // currentPage == 1
              //     ? text[1]
              //     : const TabsIcon(
              //         images: "assets/images/gallery.svg",
              //       ),
              currentPage == 0
                  ? text[0]
                  : const TabsIcon(
                      images: "assets/images/shop.svg",
                    ),
              currentPage == 1
                  ? text[1]
                  : const TabsIcon(
                      images: "assets/images/shopping-cart.svg",
                    ),
              currentPage == 2
                  ? text[2]
                  : const TabsIcon(
                      images: "assets/images/profile.svg",
                    )
            ],
          ),
        ));
  }
}

class DotIndicator extends Decoration {
  const DotIndicator({
    this.color = Colors.white,
    this.radius = 4.0,
  });

  final Color color;
  final double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(
      color: color,
      radius: radius,
      onChange: onChanged,
    );
  }
}

class _DotPainter extends BoxPainter {
  _DotPainter({
    required this.color,
    required this.radius,
    VoidCallback? onChange,
  })  : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        super(onChange);
  final Paint _paint;
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    canvas.drawCircle(
      Offset(rect.bottomCenter.dx, rect.bottomCenter.dy - radius),
      radius,
      _paint,
    );
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
      this.height = 30,
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
