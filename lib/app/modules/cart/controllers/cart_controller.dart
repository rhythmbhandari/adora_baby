import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //TODO: Implement ProfileController
  TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController idController = TextEditingController();

  final authError = ''.obs;



  Future<bool> requestAddToCart() async {
    try {
      final status =
      await CartRepository.addToCart(productController.text.trim(),quantityController.text.trim())
          .catchError((error) {
        authError.value = error;
        return false;
      });

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  Future<bool> requestUpdateToCart() async {
    try {
      final status =
      await CartRepository.updateCart(idController.text.trim(),quantityController.text.trim())
          .catchError((error) {
        authError.value = error;
        return false;
      });

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> requestToDeleteCart() async {
    try {
      final status =
      await CartRepository.deleteCart(idController.text.trim())
          .catchError((error) {
        authError.value = error;
        return false;
      });

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

}
