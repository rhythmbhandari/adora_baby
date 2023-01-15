import 'package:adora_baby/app/data/models/get_address_model.dart';
import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/data/repositories/checkout_repositories.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:adora_baby/app/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/get_carts_model.dart';
import '../../../data/models/get_city_model.dart' as c;
import '../../../data/models/get_orders_model.dart' as o;
import '../../../data/models/get_single_order_model.dart' as s;

class CartController extends GetxController {
  //TODO: Implement ProfileController

  TextEditingController idController = TextEditingController();

  final authError = ''.obs;
  final progressBarStatus = false.obs;
  final counter = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].obs;
  final value = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ].obs;
  final tappedIndex = 0.obs;
  final selected = false.obs;
  var sum = 0.obs;


  int index = 0;

  void incrementCounter(int index) {
    counter[index]++;
  }

  void decrementCounter(int index) {
    if (counter[index] > 1) {
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
  final progressBarStatusDeleteCart= true.obs;

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

  Future<List<c.Datum>> requestGetAllCities() async {
    try {
      final response = await CheckOutRepository.getAllCities().catchError((
          error) {
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


  Future<bool> requestToCheckOut(String id, String fullName, String phoneNumber,
      String altPhone, String address, String notes) async {
    try {
      final status =
      await CheckOutRepository.checkout(
          id.trim(), fullName.trim(), phoneNumber.trim(), altPhone.trim(),
          address.trim(), notes.trim()).catchError((error) {
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

  Future<List<GetAddress>> requestGetAddress() async {
    try {
      final response = await CheckOutRepository.getAddress().catchError((
          error) {
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

  Future<bool> requestToUpdateAddress(String city, String landmark,
      String type,) async {
    try {
      final status =
      await CheckOutRepository.updateAddress(
          city.trim(), landmark.trim(), type.trim()).catchError((error) {
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

  Future<bool> requestToDeleteAddress(String id) async {
    try {
      final status =
      await CheckOutRepository.deleteAddress(id.trim()).catchError((error) {
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

  Future<bool> requestToRemoveCheckOut(String id) async {
    try {
      final status =
      await CheckOutRepository.removeCheckout(id.trim()).catchError((error) {
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

  Future<bool> requestToPlaceOrder(String id) async {
    try {
      final status =
      await CheckOutRepository.placeOrder(id.trim()).catchError((error) {
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

  Future<List<o.Datum>> requestGetOrders() async {
    try {
      final response = await CheckOutRepository.getOrders().catchError((error) {
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

  Future<List<s.GetSingleOrder>> requestGetSingleOrder(String id) async {
    try {
      final response = await CheckOutRepository.getSingleOrder(id).catchError((
          error) {
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

  Future<bool> requestUpdateCheckOut(bool a) async {
    try {
      final response = await CheckOutRepository.updateCheckOut(a).catchError((
          error) {
        authError.value = error;
        return false;
      });

      if (response) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
