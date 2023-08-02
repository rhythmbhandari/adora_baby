import 'dart:developer';

import 'package:adora_baby/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../config/constants.dart';
import '../../../data/network/network_helper.dart';
import 'order_confirmation.dart';

class EsewaView extends StatefulWidget {
  const EsewaView({super.key, required this.pid, required this.successUrl});

  final String pid;
  final String successUrl;

  @override
  State<EsewaView> createState() => _EsewaViewState();
}

class _EsewaViewState extends State<EsewaView> {
  late final WebViewController controller;
  final CartController _cartController = Get.find();

  // final uri =
  //     Uri.parse('https://uat.esewa.com.np?amt=1&psc=0&pdc=0&txAmt=0&tAmt=100')
  //         .replace(
  //   queryParameters: {
  //     "amt": "1",
  //     "psc": "0",
  //     "pdc": "0",
  //     "txAmt": "0.0",
  //     "tAmt": "100.0",
  //     "pid": "ee2c3ca1-696b-4cc5-a6be-2c40d929d453",
  //     "scd": "EPAYTEST",
  //     "su": "http://merchant.com.np/page/esewa_payment_success",
  //     "fu": "http://merchant.com.np/page/esewa_payment_failed"
  //   },
  // );

  final amount = 1;
  final transactionAmount = 1;
  final serviceCharge = 0;
  final taxAmount = 0;
  final deliveryCharge = 0;
  final merchantCode = 'NP-ES-GAMING';
  final baseUrl = 'https://esewa.com.np/epay/main/';

  // final successUrl = 'http://merchant.com.np/page/esewa_payment_success?q=su';
  final failureUrl = 'http://merchant.com.np/page/esewa_payment_failed?q=fu';

  //     "psc": "0",
  //     "pdc": "0",
  //     "txAmt": "0.0",
  //     "tAmt": "100.0",
  //     "pid": "ee2c3ca1-696b-4cc5-a6be-2c40d929d453",
  //     "scd": "EPAYTEST",
  //     "su": "http://merchant.com.np/page/esewa_payment_success",
  //     "fu": "http://merchant.com.np/page/esewa_payment_failed"

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            log('Request url is ${request.url}');

            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith(
                'http://merchant.com.np/page/esewa_payment_failed?q=fu')) {
              log('Failed');
              Get.back();
              return NavigationDecision.prevent;
            }
            if (request.url
                .startsWith('$BASE_URL/Order/verify-payment/?pid=')) {
              log('Success');
              NetworkHelper().getRequest(
                request.url,
              );
              await Future.delayed(const Duration(seconds: 1)).then(
                (value) => Get.off(() => const OrderConfirmation()),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse(
            '$baseUrl?amt=${(_cartController.checkoutModel.value.subTotal-_cartController.checkoutModel.value.discount-_cartController.checkoutModel.value.dimondOff)}&pdc=${_cartController.checkoutModel.value.deliveryCharge}&psc=$serviceCharge&txAmt=$taxAmount&tAmt=${_cartController.checkoutModel.value.grandTotal}&pid=${widget.pid}&scd=$merchantCode&su=${widget.successUrl}&fu=$failureUrl',
          ),
          method: LoadRequestMethod.post);
    // #enddocregion webview_controller
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
// #enddocregion webview_widget
}
