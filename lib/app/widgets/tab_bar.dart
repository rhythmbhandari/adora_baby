import 'package:adora_baby/app/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBars extends StatefulWidget {
  final String overView;
  final String details;
  final String reviews;

  const TabBars({super.key, required this.overView, required this.details, required this.reviews});
  @override
  State<TabBars> createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: TabBar(
                indicatorColor: Colors.black,
                controller: _controller,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: "Overview",
                  ),
                  Tab(
                    text: "Details",
                  ),
                  Tab(
                    text: "Reviews",
                  ),
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: SizedBox(
            height: 200,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [Text(widget.overView,style: kThemeData.textTheme.bodyLarge,),
                  Text(widget.details,style: kThemeData.textTheme.bodyLarge,), Text(widget.reviews,style: kThemeData.textTheme.bodyLarge,)]),
          ),
        )
      ],
    );
  }
}
