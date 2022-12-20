import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/get_carts_model.dart';


class CartController extends GetxController {

  //TODO: Implement ProfileController
  var quantity=5;
  TextEditingController idController = TextEditingController();

  final authError = ''.obs;
  final progressBarStatus = false.obs;
  final counter =0.obs;
  void incrementCounter() {
      counter.value++;

  }
  void decrementCounter() {
    if(counter.value>0){
      counter.value--;
    }


  }

  Future<bool> requestAddToCart(String name) async {

    TextEditingController quantityController = TextEditingController(text: counter.value.toString());

    try {
      final status =
      await CartRepository.addToCart(name.toString(),quantityController.text.trim())
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
    TextEditingController quantityController = TextEditingController(text: quantity.toString());

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
  Future<List<Datum>> cart() async {
    try {
      final response =
      await CartRepository.getCart().catchError((error) {
        authError.value = error;
        return false;
      });

      if (response.isNotEmpty) {
        return response;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

}
