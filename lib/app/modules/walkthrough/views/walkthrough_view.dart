import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/walkthrough_controller.dart';

class WalkthroughView extends GetView<WalkthroughController> {
  const WalkthroughView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalkthroughView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'WalkthroughView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
