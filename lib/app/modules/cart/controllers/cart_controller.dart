import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/get_carts_model.dart';

class CartController extends GetxController {
  //TODO: Implement ProfileController

  TextEditingController idController = TextEditingController();

  final authError = ''.obs;
  final progressBarStatus = false.obs;
  final counter = [1,2,3,4,5,6,7,8,9,10].obs;
  final value = [false,false,false,false,false,false,false,false,false,false].obs;
  final tappedIndex = 0.obs;
  final selected = false.obs;
  var sum = 0.obs;


  int index = 0;

  void incrementCounter(int index) {
    counter[index]++;
  }

  void decrementCounter(int index) {
    if (counter[index]> 1) {
      counter[index]--;
    }
  }

  listBool(String id) {
    return value;
  }

  Future<bool> requestAddToCart(String name) async {
    TextEditingController quantityController =
        TextEditingController(text: counter[index].toString());

    try {
      final status = await CartRepository.addToCart(
              name.toString(), quantityController.text.trim())
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
    TextEditingController quantityController =
        TextEditingController(text: counter.value.toString());

    try {
      final status = await CartRepository.updateCart(
              idController.text.trim(), quantityController.text.trim())
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

  Future<bool> requestToDeleteCart(String id) async {
    try {
      final status =
          await CartRepository.deleteCart(id.trim()).catchError((error) {
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

      final response = await CartRepository.getCart().catchError((error) {
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
