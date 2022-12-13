import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TabBars extends StatefulWidget {
  @override
  State<TabBars> createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars>
    with SingleTickerProviderStateMixin {
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

      children: [
        Flexible(
          child: TabBar(
              indicatorColor: Colors.black,
              controller: _controller,
              unselectedLabelColor: Colors.white,
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

       Flexible(child:  TabBarView(
           physics: const ScrollPhysics(),
           controller: _controller,
           children: const [Text("abc"),Text("abc"),Text("abc")

           ]),)
      ],
    );
  }
}
