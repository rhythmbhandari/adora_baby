import 'dart:async';
import 'dart:developer';

import 'package:adora_baby/app/data/models/cart_model.dart';
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
import '../../../enums/progress_status.dart';

class CartController extends GetxController {
  //TODO: Implement ProfileController

  TextEditingController idController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController addNameController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  final progressBarStatusOtp = false.obs;

  String? cityName;

  name() async {
    cityName = (await storage.readCityId())!;
  }

  final authError = ''.obs;
  final status = false.obs;

  final mainCheckbox = false.obs;

  final RxList cartList = [].obs;

  final RxList addressList = [].obs;

  final priceCart = 0.0.obs;

  final tempSelectedCart = [].obs;

  final RxMap cartMap = {}.obs;

  showLoading(Rx<ProgressStatus> status) =>
      status.value = ProgressStatus.loading;

  showSearching(Rx<ProgressStatus> status) =>
      status.value = ProgressStatus.searching;

  completeLoading(Rx<ProgressStatus> progressStatus, bool isEmpty) => {
        if (isEmpty)
          {
            progressStatus.value = ProgressStatus.empty,
          }
        else
          {
            progressStatus.value = ProgressStatus.success,
          }
      };

  showNetworkError(
    Rx<ProgressStatus> progressStatus,
  ) =>
      progressStatus.value = ProgressStatus.internetError;

  showError(
    Rx<ProgressStatus> progressStatus,
  ) =>
      progressStatus.value = ProgressStatus.error;

  hideError(
    Rx<ProgressStatus> progressStatus,
  ) =>
      progressStatus.value = ProgressStatus.idle;

  final progressBarStatusCart = ProgressStatus.loading.obs;

  final progressBarStatusInformation = ProgressStatus.idle.obs;

  final counter = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1].obs;
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
  final progress = CustomProgressBar().obs;
  Timer? timer;
  final addressValue = false.obs;

  final selectedAddress = ''.obs;

  @override
  void onInit() {
    name();
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    await Future.wait(
      [
        cart(),
        getAddressList(),
      ],
    );
  }

  int index = 0;

  Future<bool> getAddressList() async {
    try {
      showSearching(progressBarStatusInformation);
      final response = await CheckOutRepository.getAddress();
      if (response.isNotEmpty) {
        addressList.value = response;
        addressList[0].checked = true;
        completeLoading(progressBarStatusInformation, false);
        return true;
      } else {
        completeLoading(
          progressBarStatusInformation,
          true,
        );
        return false;
      }
    } catch (e) {
      showError(
        progressBarStatusInformation,
      );
      return false;
    }
  }

  Future<bool> cart() async {
    try {
      showSearching(progressBarStatusCart);
      final response = await CartRepository.getCart();
      if (response.isNotEmpty) {
        cartList.value = response;
        for (final cart in cartList) {
          if (cart.quantity > cart.product.stockQuantity ?? 0) {
            cart.quantity = cart.product.stockQuantity ?? 0;
          }
          cart.product.priceItem = cart.quantity *
              (cart.product.salePrice ?? cart.product.regularPrice);
        }
        completeLoading(progressBarStatusCart, false);
        return true;
      } else {
        completeLoading(
          progressBarStatusCart,
          true,
        );
        return false;
      }
    } catch (e) {
      showError(
        progressBarStatusCart,
      );
      return false;
    }
  }

  Future<bool> calculateGrandTotal(RxList cartTempList) async {
    try {
      var tempPrice = 0.0;
      for (final cart in cartTempList) {
        if (cart.checkBox) {
          tempPrice += cart.quantity *
              (cart.product.salePrice ?? cart.product.regularPrice);
        }
      }
      priceCart.value = tempPrice;
      return true;
    } catch (e) {
      return false;
    }
  }

  addToCartPressed(int index) async {
    if (cartList[index].quantity < cartList[index].product.stockQuantity) {
      cartList[index].quantity += 1;
      await calculatePriceItem(index);
      await calculateGrandTotal(cartList);
      await addToCartMap(index);
      log('Cart Map $cartMap');
      cartList.refresh();
      update(['add_remove_cart'], true);
    }
  }

  calculatePriceItem(int index) async {
    cartList[index].product.priceItem = cartList[index].quantity *
        (cartList[index].product.salePrice ??
            cartList[index].product.regularPrice);
  }

  addToCartMap(int index) async {
    cartMap[cartList[index].id] = {
      'id': cartList[index].id,
      'quantity': cartList[index].quantity
    };
  }

  removeFromCartPressed(int index) async {
    var quantity = cartList[index].quantity;
    if (quantity != 1 && quantity >= 0) {
      cartList[index].quantity -= 1;
      await calculatePriceItem(index);
      await calculateGrandTotal(cartList);
      await addToCartMap(index);
      log('Cart Map $cartMap');
      cartList.refresh();
      update(['add_remove_cart'], true);
    }
  }

  individualCheckboxPressed(bool? val, int index) async {
    cartList[index].checkBox = val!;
    var list = [];
    for (final cart in cartList) {
      if (cart.checkBox) {
        list.add(cart.checkBox);
      }
    }
    if (cartList.length == list.length) {
      mainCheckbox.value = true;
    } else {
      mainCheckbox.value = false;
    }
    await calculateGrandTotal(cartList);
    cartList.refresh();
    update(
      ['individualCheckbox', 'mainCheckbox'],
      true,
    );
  }

  mainCheckboxPressed(
    bool? val,
  ) async {
    for (final cartItem in cartList) {
      cartItem.checkBox = val;
    }
    mainCheckbox.value = val ?? false;
    await calculateGrandTotal(cartList);
    update(
      ['individualCheckbox', 'mainCheckbox'],
      true,
    );
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

  Future<List<AddressModel>> requestGetAddress() async {
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
