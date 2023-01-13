import 'package:adora_baby/app/modules/cart/views/cart_view.dart';
import 'package:flutter/material.dart';

import 'cart_widget.dart';

class CartTab extends StatefulWidget {
  @override
  State<CartTab> createState() => _RedeemTabBarState();
}

class _RedeemTabBarState extends State<CartTab>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 1);
    _controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: TabBar(
                  indicatorColor: Colors.black,
                  controller: _controller,
                  unselectedLabelColor: Colors.white,
                  isScrollable: true,

                  tabs: const [
                    Tab(
                      text: "My Cart",
                    ),
                    Tab(
                      text: "My Favourites",
                    ),
                  ]),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: TabBarView(controller: _controller, children: [
                Carts(),
              Text("abc")
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
