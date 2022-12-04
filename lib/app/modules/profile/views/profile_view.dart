import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../config/constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            storage.writeData(Constants.LOGGED_IN_STATUS, null);
          },
          child: Text(
            'Click to remove logged in',
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
