import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_theme.dart';
import '../../../config/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/exit_dialog.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      child: Scaffold(
        bottomSheet: BottomNavBar(scaffoldKey: _scaffoldKey,),

        key: _scaffoldKey,
        drawerScrimColor: Colors.transparent,
        endDrawer: Container(
          width: Get.width * 0.85,
          child: Drawer(
            elevation: 0,
            backgroundColor: LightTheme.lightActive,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.08, horizontal: 10),
              children: [
                ListTile(
                  title: Text(
                    'Logout',
                    style: kThemeData.textTheme.bodyLarge
                        ?.copyWith(color: DarkTheme.normal, fontSize: 18),
                  ),
                  onTap: () async {
                    try {
                      await storage.delete(
                        Constants.ACCESS_TOKEN,
                      );
                      await storage.delete(
                        Constants.LOGGED_IN_STATUS,
                      );
                      await storage.delete(
                        Constants.REFRESH_TOKEN,
                      );
                      Get.offAllNamed(Routes.PHONE);
                    } catch (e) {
                      Get.offAllNamed(Routes.PHONE);
                    }
                  },
                  trailing: Icon(
                    Icons.logout,
                    color: DarkTheme.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
