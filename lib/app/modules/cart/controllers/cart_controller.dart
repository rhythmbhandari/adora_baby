import 'dart:async';

import 'package:adora_baby/app/data/models/get_address_model.dart';
import 'package:adora_baby/app/data/repositories/cart_repository.dart';
import 'package:adora_baby/app/data/repositories/checkout_repositories.dart';
import 'package:adora_baby/app/widgets/custom_progress_bar.dart';
import 'package:adora_baby/app/widgets/shimmer_widget.dart';
import 'package:adora_baby/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/get_carts_model.dart' as g;
import '../../../data/models/get_city_model.dart' as c;
import '../../../data/models/get_orders_model.dart' as o;
import '../../../data/models/get_single_order_model.dart' as s;

class CartController extends GetxController {
  //TODO: Implement ProfileController

  TextEditingController idController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController addNameController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  final progressBarStatusOtp = false.obs;


  var cityId = "".obs;
  var cityName = "".obs;



  Future<void> loadCityId() async {
    cityId.value = (await storage.readCityId())!;
  }


Future<void> loadCityName() async {
  cityName.value = (await storage.readCityName())!;
}

  @override
  void onReady() {
    super.onReady();
    loadCityName();
    loadCityId();
  }



  final total = 0.obs;

  final authError = ''.obs;
  final status = false.obs;
  final items = [""].obs;

  void deleteItem(String item) {
    items.remove(item);
    progressBarStatusDeleteCart.value = true;
  }

  final progressBarStatus = false.obs;
  final counter = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1].obs;
  bool selectAll = false;
  final selectOne = [
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

  void toggleAll() {
    selectAll = !selectAll;
    for (int i = 0; i < value.length; i++) {
      value[i] = selectAll;
    }
    update();
  }

  void toggleOne(int index) {
    for (int i = 0; i < value.length; i++) {
      if (i == index) {
        value[i] = !value[i];
      } else {
        value[i] = false;
      }
    }
    update();
  }

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
  final progress = CustomProgressBar().obs;
  Timer? timer;
  final addressValue = false.obs;



  int index = 0;

  void incrementCounter(int index) {
    if (counter[index] < 15) {
      counter[index]++;
    }
    update();
  }

  void decrementCounter(int index) {
    if (counter[index] > 1) {
      counter[index]--;
    }
    update();
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

  final fName = ''.obs;
  final pNum = ''.obs;
  final aNum = ''.obs;
  final note = ''.obs;

  Future<bool> validatePersonalInfo() async {
    fName.value = fNameController.text.trim();
    pNum.value = phoneController.text.trim();
    aNum.value = altPhoneController.text.trim();
    note.value = notesController.text.trim();

    bool isValid = true;
    if (fName.value.isEmpty) {
      isValid = false;
      authError.value = 'Name cannot be empty.'.tr;
    } else if (pNum.value.isEmpty) {
      isValid = false;
      authError.value = 'Number cannot be empty.'.tr;
    } else if (aNum.value.isEmpty) {
      isValid = false;
      authError.value = 'ALternate Number cannot be empty.'.tr;
    } else if (note.value.isEmpty) {
      isValid = false;
      authError.value = 'Notes cannot be empty.'.tr;
    }
    return isValid;
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

  final progressBarStatusDeleteCart = false.obs;

  Future<bool> requestToDeleteCart(String ids) async {
    update();

    try {
      final status = await CartRepository.deleteCart(ids).catchError((error) {
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

  Future<List<g.Datum>> cart() async {
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

  // Future<c.Datum> requestGetAllCities() async {
  //   try {
  //     final response =
  //         await CheckOutRepository.getAllCities().catchError((error) {
  //       authError.value = error;
  //       return false;
  //     });
  //
  //     if (response.isNotEmpty) {
  //       return response;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<bool> requestToCheckOut(String fullName, String phoneNumber,
      String altPhone, String address, String notes) async {
    try {
      final status = await CheckOutRepository.checkout(fullName.trim(),
              phoneNumber.trim(), altPhone.trim(), address.trim(), notes.trim())
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

  Future<List<Datum>> requestGetAddress() async {
    try {
      final response =
          await CheckOutRepository.getAddress().catchError((error) {
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

  Future<bool> requestToUpdateAddress(
    String city,
    String landmark,
    String type,
  ) async {
    try {
      final status = await CheckOutRepository.updateAddress(
              city.trim(), landmark.trim(), type.trim())
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

  Future<bool> requestToDeleteAddress() async {
    try {
      final status =
          await CheckOutRepository.deleteAddress().catchError((error) {
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
      final status = await CheckOutRepository.removeCheckout(id.trim())
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
      final response =
          await CheckOutRepository.getSingleOrder(id).catchError((error) {
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
      final response =
          await CheckOutRepository.updateCheckOut(a).catchError((error) {
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
