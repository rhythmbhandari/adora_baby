import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/exit_dialog.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return ExitDialog();
          },
        );
        return false;
      },
      child: const Scaffold(
        bottomSheet: BottomNavBar(),
      ),
    );
  }
}
