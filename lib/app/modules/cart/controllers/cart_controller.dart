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

import '../../../data/models/checkout_model.dart';
import '../../../data/models/get_carts_model.dart' as g;
import '../../../data/models/get_city_model.dart' as c;
import '../../../data/models/get_orders_model.dart' as o;
import '../../../data/models/get_single_order_model.dart' as s;
import '../../../enums/progress_status.dart';
import '../../profile/controllers/profile_controller.dart';

class CartController extends GetxController {
  //TODO: Implement ProfileController

  TextEditingController idController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController altPhoneController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  TextEditingController couponController = TextEditingController();

  final progressBarStatusOtp = false.obs;

  String? cityName;

  name() async {
    cityName = (await storage.readCityId())!;
  }

  final authError = ''.obs;

  final mainCheckbox = false.obs;

  final RxList cartList = [].obs;

  Rx<CheckoutModel> checkoutModel = CheckoutModel(
          id: '',
          cart: [''],
          fullName: '',
          phoneNumber: '',
          altPhoneNumber: '',
          address: '',
          specialNotes: '',
          isDimondUse: false,
          subTotal: 0,
          dimondOff: 0,
          discount: 0,
          deliveryCharge: 0,
          grandTotal: 0,
          isCouponUse: false)
      .obs;

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

  final progressBarStatusCheckout = ProgressStatus.idle.obs;

  final cashOnDeliveryCheckBox = true.obs;

  final useDiamondCheckBox = false.obs;

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
      ],
    );
  }

  int index = 0;

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
              ((cart.product.salePrice) ??  cart.product.regularPrice );
        }
        completeLoading(progressBarStatusCart, false);
        return true;
      } else {
        completeLoading(
          progressBarStatusCart,
          true,
        );
        cartList.value = [];
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

  Future<bool> addToCartPressed(int index) async {
    try {
      showLoading(progressBarStatusCart);

      if (cartList[index].quantity < cartList[index].product.stockQuantity) {
        cartList[index].quantity += 1;
        final status = await requestUpdateToCart(
            cartList[index].id, cartList[index].quantity);
        if (status) {
          log('Cart Map $cartMap');
          cartList.refresh();
          update(['add_remove_cart'], true);
          await calculatePriceItem(index);
          await calculateGrandTotal(cartList);
          completeLoading(
            progressBarStatusCart,
            false,
          );
          return true;
        } else {
          completeLoading(
            progressBarStatusCart,
            false,
          );
          authError.value = 'Could not add to cart.';
          return false;
        }
      }
      completeLoading(
        progressBarStatusCart,
        false,
      );
      authError.value =
          'Stock more than ${cartList[index].quantity} is not available.';
      return false;
    } catch (e) {
      completeLoading(
        progressBarStatusCart,
        false,
      );
      return false;
    }
  }

  calculatePriceItem(int index) async {
    cartList[index].product.priceItem = cartList[index].quantity *
        (cartList[index].product.salePrice ??
            cartList[index].product.regularPrice);
  }

  Future<bool> removeFromCartPressed(int index) async {
    try {
      showLoading(progressBarStatusCart);

      var quantity = cartList[index].quantity;
      if (quantity != 1 && quantity >= 0) {
        cartList[index].quantity -= 1;
        final status = await requestUpdateToCart(
            cartList[index].id, cartList[index].quantity);
        if (status) {
          await calculatePriceItem(index);
          await calculateGrandTotal(cartList);
          log('Cart Map $cartMap');
          cartList.refresh();
          update(['add_remove_cart'], true);
          completeLoading(
            progressBarStatusCart,
            false,
          );
          return true;
        } else {
          completeLoading(
            progressBarStatusCart,
            false,
          );
          authError.value = 'Could not remove from cart.';
          return false;
        }
        // await addToCartMap(index);
      }
      completeLoading(
        progressBarStatusCart,
        false,
      );
      authError.value = 'Please use remove selected to delete item from cart';
      return false;
    } catch (e) {
      completeLoading(
        progressBarStatusCart,
        false,
      );
      return false;
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
          name.toString(), quantityController.text.trim());

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }

  Future<bool> validatePersonalInfo() async {
    String fName = fNameController.text.trim();
    String pNum = phoneController.text.trim();
    String aNum = altPhoneController.text.trim();
    String note = notesController.text.trim();
    final ProfileController profileController = Get.find();
    AddressModel? selectedAddress = profileController.addressList
        .firstWhere((address) => address.checked, orElse: () => null);

    log('Selected Address is $selectedAddress');

    bool isValid = true;
    if (fName.isEmpty) {
      isValid = false;
      authError.value = 'Name cannot be empty.'.tr;
      return isValid;
    } else if (pNum.isEmpty) {
      isValid = false;
      authError.value = 'Number cannot be empty.'.tr;
      return isValid;
    } else if (pNum.length != 10) {
      isValid = false;
      authError.value = 'Phone numbers are 10 digit.'.tr;
      return isValid;
    } else if (aNum.isEmpty) {
      isValid = false;
      authError.value = 'Alternate number cannot be empty.'.tr;
      return isValid;
    } else if (aNum.length != 10) {
      isValid = false;
      authError.value = 'Alternate numbers should be 10 digit.'.tr;
      return isValid;
    } else if (selectedAddress == null) {
      isValid = false;
      authError.value = 'Please select an address.'.tr;
      return isValid;
    }
    var cartList = [];
    for (var e in cartMap.entries) {
      cartList.add(e.value['id']);
    }
    log('Cart List is $cartList');
    final status = await requestToCheckOut(
      fName,
      pNum,
      aNum,
      selectedAddress.id,
      note,
      cartList,
    );
    if (status) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestUpdateToCart(String id, int quantity) async {
    try {
      final status = await CartRepository.updateCart(
        id,
        quantity,
      );

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }

  final progressBarStatusDeleteCart = false.obs;

  Future<bool> requestToDeleteCart(List ofId) async {
    try {
      final status = await CartRepository.deleteCart(ofId);

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = error.toString();
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
      String altPhone, String address, String notes, List cartList) async {
    try {
      final status = await CheckOutRepository.checkout(
          fullName.trim(),
          phoneNumber.trim(),
          altPhone.trim(),
          address.trim(),
          notes.trim(),
          cartList);

      checkoutModel.value = status;
      return true;
    } catch (e) {
      log('Error is $e');
      authError.value = e.toString();
      return false;
    }
  }

  Future<List<AddressModel>> requestGetAddress() async {
    try {
      final response = await CheckOutRepository.getAddress();

      if (response.isNotEmpty) {
        return response;
      } else {
        return [];
      }
    } catch (error) {
      authError.value = '$error';
      return [];
    }
  }

  Future<bool> requestToDeleteAddress(String id) async {
    try {
      final status = await CheckOutRepository.deleteAddress(id.trim());

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }

  Future<bool> requestToUpdateCheckOut(
      String id, bool isDiamond, String couponCode) async {
    try {
      final status = await CheckOutRepository.updateCheckOut(
        id,
        isDiamond,
        couponCode,
      );
      checkoutModel.value = status;
      return true;
    } catch (e) {
      authError.value = e.toString();
      return false;
    }
  }

  Future<bool> requestToRemoveCheckOut(String id) async {
    try {
      final status = await CheckOutRepository.removeCheckout(id.trim());

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      authError.value = '$error';
      return false;
    }
  }

  Future<bool> requestToPlaceOrder() async {
    try {
      final status =
          await CheckOutRepository.placeOrder(checkoutModel.value.id);

      if (status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      authError.value = e.toString();
      return false;
    }
  }

  Future<List<o.Datum>> requestGetOrders() async {
    try {
      final response = await CheckOutRepository.getOrders();

      if (response.isNotEmpty) {
        return response;
      } else {
        return [];
      }
    } catch (error) {
      authError.value = '$error';
      return [];
    }
  }

  Future<List<s.GetSingleOrder>> requestGetSingleOrder(String id) async {
    try {
      final response = await CheckOutRepository.getSingleOrder(id);
      if (response.isNotEmpty) {
        return response;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> requestUpdateCheckOut(
      String id, bool isDiamondUsed, String couponCode) async {
    try {
      final response = await CheckOutRepository.updateCheckOut(
          id, isDiamondUsed, couponCode);
      checkoutModel.value = response;
      return true;
    } catch (error) {
      authError.value = error.toString();
      return false;
    }
  }
}
