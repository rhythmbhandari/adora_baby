import 'package:adora_baby/app/modules/profile/views/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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
        bottomSheet: BottomNavBar(
          scaffoldKey: _scaffoldKey,
        ),
        key: _scaffoldKey,
        drawerScrimColor: Colors.transparent,
        endDrawer: Container(
          width: Get.width * 0.85,
          child: Drawer(
            elevation: 0,
            backgroundColor: LightTheme.lightActive,
            child: SafeArea(
              child: Column(
                // Important: Remove any padding from the ListView.

                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.00, horizontal: 10),
                      children: [
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          title: Text(
                            'Menu',
                            style: kThemeData.textTheme.titleMedium?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            _scaffoldKey.currentState!.closeEndDrawer();
                          },
                          trailing: SvgPicture.asset(
                            "assets/images/close-circle.svg",
                            height: 28,
                            color: DarkTheme.normal,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          minLeadingWidth: 0,
                          title: Text(
                            'Change Password',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {
                            Get.to(() => ChangePassword());
                            _scaffoldKey.currentState!.closeEndDrawer();
                          },
                          leading: SvgPicture.asset(
                            "assets/images/eye.svg",
                            height: 26,
                            // width: 28,
                            color: DarkTheme.normal,
                          ),
                        ),
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -2),
                          minLeadingWidth: 0,
                          title: Text(
                            'Notification',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () async {
                            // final status = await Permission.notification.op;

                            openAppSettings();
                          },
                          leading: SvgPicture.asset(
                            "assets/images/notification.svg",
                            height: 26,
                            // width: 28,
                            // color: DarkTheme.normal,
                          ),
                        ),
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -2),
                          minLeadingWidth: 0,
                          title: Text(
                            'Adora Baby',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () async {
                            Uri url = Uri.parse('https://adora.baby/');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          leading: SvgPicture.asset(
                            "assets/images/global.svg",
                            height: 26,
                            // width: 28,
                            // color: DarkTheme.normal,
                          ),
                        ),
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -2),
                          minLeadingWidth: 0,
                          title: Text(
                            'Facebook',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () async {
                            Uri url = Uri.parse(
                                'https://www.facebook.com/adorababies');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          leading: SvgPicture.asset(
                            "assets/images/facebook.svg",
                            height: 26,
                            // width: 28,
                            // color: DarkTheme.normal,
                          ),
                        ),
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -2),
                          minLeadingWidth: 0,
                          title: Text(
                            'Instagram',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () async {
                            Uri url = Uri.parse(
                                'https://www.instagram.com/_adorababy/');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          leading: SvgPicture.asset(
                            "assets/images/instagram.svg",
                            height: 26,
                            // width: 28,
                            // color: DarkTheme.normal,
                          ),
                        ),
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -2),
                          minLeadingWidth: 0,
                          title: Text(
                            'Tiktok',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () async {
                            Uri url =
                                Uri.parse('https://www.tiktok.com/@adora.baby');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          leading: SvgPicture.asset(
                            "assets/images/tiktok.svg",
                            height: 26,
                            // width: 28,
                            // color: DarkTheme.normal,
                          ),
                        ),
                        ListTile(
                          selectedTileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          minLeadingWidth: 0,
                          title: Text(
                            'Contact Us',
                            style: kThemeData.textTheme.bodyLarge?.copyWith(
                              color: DarkTheme.normal,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () async {
                            Uri url = Uri.parse('tel://+977-9846954208');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          leading: SvgPicture.asset(
                            "assets/images/profile_call.svg",
                            height: 26,
                            // width: 28,
                            // color: DarkTheme.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: DarkTheme.darkLightActive,
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: kThemeData.textTheme.bodyLarge
                          ?.copyWith(color: DarkTheme.normal, fontSize: 18),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    minLeadingWidth: 0,
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
                    leading: SvgPicture.asset(
                      "assets/images/logout.svg",
                      height: 28,
                      color: DarkTheme.normal,
                    ),
                  ),
                  Divider(
                    color: DarkTheme.darkLightActive,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Uri url = Uri.parse(
                          'https://www.google.com/search?q=adora+baby+terms+and+condition');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      'Terms of Service',
                      textAlign: TextAlign.center,
                      style: kThemeData.textTheme.bodyMedium?.copyWith(
                        color: DarkTheme.normal,
                        fontSize: 16,
                        // fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
