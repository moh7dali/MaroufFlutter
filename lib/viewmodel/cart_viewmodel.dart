import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/main.dart';
import 'package:Marouf/models/oorder_setup.dart';
import 'package:Marouf/models/order_model.dart';
import 'package:Marouf/models/promo_model.dart';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/helper.dart';
import 'package:Marouf/view/screens/drawerscreens/my_order_screen.dart';
import 'package:Marouf/viewmodel/main_viewmodel.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';
import '../models/also_added_model.dart';
import '../models/cart_model.dart';
import '../models/main_response.dart';
import '../models/schedule_times.dart';
import '../models/user_address.dart';
import '../utils/constant/shared_preferences_constant.dart';
import '../utils/device_info.dart';
import '../utils/error_helper.dart';
import '../utils/navigation.dart';
import '../utils/theme/app_theme.dart';
import '../view/screens/main_screen.dart';
import '../view/screens/signin_screen.dart';
import 'deal_week_viewmodel.dart';
import 'my_addresses_viewmodel.dart';

class CartViewModel extends GetxController {
  final scheduleDateKey = GlobalKey();
  final instructionsController = TextEditingController();
  final promoController = TextEditingController();
  final scrollController = ScrollController();
  PromoModel? promoModel;
  OrderSetup? orderSetup;
  bool canNowDelivery = false;
  double deliveryFeesDiscount = 0;
  bool isProcessed = false;
  bool isCartLoading = true;
  bool isLoading = false;
  bool isOnlinePayment = false;
  bool isPromoValue = false;
  bool isWrapProduct = false;
  String paymentType = "";
  bool isPoint = false;
  bool promoDone = false;
  bool hasPromo = false;
  bool promoTrue = false;
  DeviceInfo deviceInfo = DeviceInfo();
  String orderTime = 'now';
  DateTime? orderDate;
  String errorText = '';
  String unitPrice = '';
  double subTotal = 0;
  double discountPromo = 0;
  double pointsRedeemed = 0;
  int? discountAmountPercent;
  double? grandAmount;
  double? deliveryFee = 0;
  double? discountPrice = 0;
  PeopleAlsoAddedModel alsoAddedProducts = PeopleAlsoAddedModel();
  double finalAmount = 0;
  double taxAmount = 0;
  int paymentTypIde = 1;
  late List<CartItem> cartItems;

  String checkoutId = "";
  int itemCountDeliveryMethodList = 0;

  CartViewModel(this.cartItems);

  @override
  void onInit() async {
    currentRout = '/cart';
    isPoint = false;
    paymentType = "";
    update();
    if (cartItems.isNotEmpty) {
      // getAlsoPeopleAdded();
      await getOrderStatus(Addresses());
      log(json.encode(List<dynamic>.from(cartItems.map((x) => x.toJson()))),
          name: 'cartLog');
      deviceInfo.getDeviceInfo();
    }
    cartList.addListener(() async {
      cartItems = cartList.value;
      calculatePrices();
    });
    // getProfile();
  }

  refreshPage() async {
    currentRout = '/cart';
    isPoint = false;
    paymentType = "";
    update();
    if (cartItems.isNotEmpty) {
      // getAlsoPeopleAdded();
      await getOrderStatus(Addresses());
      log(json.encode(List<dynamic>.from(cartItems.map((x) => x.toJson()))),
          name: 'cartLog');
      deviceInfo.getDeviceInfo();
    }
    cartList.addListener(() async {
      cartItems = cartList.value;
      calculatePrices();
    });
    // getProfile();
  }

  ScheduleTimes? scheduleTimes;
  DateWithTime? selectedDate;
  String? selectedDay;
  bool? canSelectedDayDelivery;
  String? selectedTime;
  int selectedTimeIndex = 0;
  Map<String, bool> deliveryDays = {};

  checkPromo(String promo) async {
    isLoading = true;
    update();
    await HttpClientApp().request(
      method: 'GET',
      url:
      '${APIUrls.checkPromo}?promotionCode=${promoController.text.replaceAll(" ", "")}&orderAmount=$subTotal',
      body: {},
      files: {},
    ).then((response) async {
      print(response);
      promoModel = PromoModel.fromJson(json.decode(response));
      hasPromo = true;
      isLoading = false;
      handlePromoResponse1();
      update();
      if (promoModel!.errors==null) {
        checkPromPrices();
        calculatePrices();
      }
      // else{
      //   if (promoModel!.errors!.isNotEmpty) {
      //     Helper().errorSnackBar(promoModel!.errors![0].errorMessage!);
      //   } else {
      //     Helper().errorSnackBar('defaultError'.tr);
      //   }}
    });
  }

  checkPromPrices() {
    if (hasPromo && promoModel != null) {
      if (promoModel!.promotionType == 0) {
        isPromoValue = false;
        var percPromo = (promoModel?.value ?? 0) / 100;
        var finalPromo = subTotal * percPromo;
        log(finalPromo.toString(),name: "______________");
        if (finalPromo >= subTotal) {
          discountPromo = subTotal;
        } else {
          discountPromo = finalPromo;
        }
      } else {
        isPromoValue = true;
        if ((promoModel?.value ?? 0) >= subTotal) {
          discountPromo = subTotal;
        } else {
          discountPromo = promoModel?.value ?? 0;
        }
      }
      //checkMax
      if (promoModel?.maximumAmount != null) {
        print('maximumAmount1 ${promoModel?.maximumAmount}');
        print('discountPromo2 ${discountPromo}');
        print(
            'discountPromo3 ${discountPromo > double.parse(promoModel!.maximumAmount.toString())}');
        if (discountPromo >
            double.parse(promoModel!.maximumAmount.toString())) {
          discountPromo = double.parse(promoModel!.maximumAmount.toString());
        }
      }
      handlePromoResponse1();
      //checkMin
      if (promoModel?.minimumOrderAmount != null) {
        print('minimumOrderAmount ${promoModel?.minimumOrderAmount}');
        if (subTotal <
            double.parse(promoModel!.minimumOrderAmount.toString())) {
          print(
              'minimumOrderAmount- subtotal ${promoModel?.minimumOrderAmount}');
          discountPromo = 0;
          promoDone = true;
          promoTrue = false;
          errorText =
          '${'promoLessThanMinimum'.tr} ${promoModel!.minimumOrderAmount}';
          update();
        } else {
          if (promoModel!.promotionType == 0) {
            isPromoValue = false;
            var percPromo = (promoModel?.value ?? 0) / 100;
            var finalPromo = subTotal * percPromo;
            print(finalPromo);
            if (finalPromo >= subTotal) {
              discountPromo = subTotal;
            } else {
              discountPromo = finalPromo;
            }
          } else {
            isPromoValue = true;
            if ((promoModel?.value ?? 0) >= subTotal) {
              discountPromo = subTotal;
            } else {
              discountPromo = promoModel?.value ?? 0;
            }
          }
          //checkMax
          if (promoModel?.maximumAmount != null) {
            print('maximumAmount1 ${promoModel?.maximumAmount}');
            print('discountPromo2 ${discountPromo}');
            print(
                'discountPromo3 ${discountPromo > double.parse(promoModel!.maximumAmount.toString())}');
            if (discountPromo >
                double.parse(promoModel!.maximumAmount.toString())) {
              discountPromo =
                  double.parse(promoModel!.maximumAmount.toString());
            }
          }
          promoDone = true;
          promoTrue = true;
          errorText = '';
          update();
        }
      }
      calculatePrices();
    } else {
      calculatePrices();
    }
  }

  login(Function function) async {
    SharedPreferences.getInstance().then((value) async {
      if (value.getBool(SharedPreferencesKey.isSuccessLogin) ?? false) {
        String? phone = value.getString(SharedPreferencesKey.mobileNumber);

        await HttpClientApp().login(function);
      } else {
        Helper().actionDialog(
          'notRegisterUser'.tr,
          'pleaseRegister'.tr,
          confirm: () {
            NavigationApp.offUntil(SigninScreen());
          },
          cancel: () {
            Get.back();
          },
          confirmText: 'register'.tr,
        );
      }
    });
  }

  checkout(var body) async {
    Helper().loading();
    await HttpClientApp()
        .request(
            method: 'POST',
            url: APIUrls.addOrder,
            body: body,
            files: {},
            isJson: true)
        .then((response) async {
      isProcessed = false;
      update();
      Get.back();
      print(response);

      if (response != '' || response != 'null') {}

      OrderModel orderModel = OrderModel.fromJson(json.decode(response));
      if (orderModel.isSucceeded!) {
        String ids = '';
        String names = '';
        cartList.value.forEach((element) {
          ids += '${element.itemId!},';
          names += '${element.itemName!},';
        });
        if (names.length > 99) {
          names = 'CheckIds';
        }
        //Todo : analytic google and facebook

        if (isOnlinePayment) {
          checkoutId = orderModel.paymentToken!;
          print('FlutterCheckoutId: $checkoutId');
          // initHyperPay();
          _getPaymentResponse(checkoutId, 'test');
        } else {
          orderDone('orderReceived'.tr, 'orderText'.tr, false);
        }
      } else {
        if (orderModel.orderPossibilityResult!.reasonForStoppingOrder != null) {
          Helper().errorSnackBar(
              '${orderModel.orderPossibilityResult!.reasonForStoppingOrder}'
                  .tr);
        } else {
          if (orderModel.errors!.isNotEmpty) {
            Helper().errorSnackBar(
                ErrorHelper(orderModel.errors![0].errorCode!,
                        orderModel.errors![0].errorMessage!, orderModel)
                    .handleError(),
                isPend: true);
          } else {
            Helper().errorSnackBar('defaultError'.tr);
          }
        }
      }
    });
  }

  static const platform =
      MethodChannel("com.mozaic.www.maroufcoffee/getPaymentMethod");

  Future<void> _getPaymentResponse(String checkoutID, String mode) async {
    try {
      var result = await platform.invokeMethod('getPaymentMethod', checkoutID);
      log('getPaymentMethod: ${result.toString()}', name: 'Payment');
      handleResponse(checkoutID, result.toString());
    } on PlatformException catch (e) {
      print("Failed to get payment metohd: '${e.message}'.");
    }
  }

  handleResponse(String checkoutID, String response) {
    List<String> list = response.split('#');
    if (response.contains('SYNC')) {
      //getPaymentStatus

      getStatusPayment(checkoutID, list[1]);
    } else if (response.contains('ASYNC')) {
      //NoThing to do

      failPayment(checkoutID, list[1]);
    } else if (response.contains('FAIL')) {
      //failPayment
      failPayment(checkoutID, list[1]);
    } else if (response.contains('CANCEL')) {
      //cancelPayment
      cancelPayment(checkoutID, list[1]);
    } else if (response.contains('ERROR')) {
      //failPayment
      failPayment(checkoutID, list[1]);
    } else {
      //failPayment
      failPayment(checkoutID, list[1]);
    }
  }

  getStatusPayment(String checkoutId, sdkTransaction) async {
    Helper().loading();
    await HttpClientApp()
        .request(
      method: 'POST',
      url: APIUrls.getPaymentStatus,
      body: {
        "PaymentToken": checkoutId,
        "MobileSDKResponse": sdkTransaction,
      },
      isJson: true,
      files: {},
    )
        .then((response) {
      Get.back();
      log(response, name: 'PaymentStatus');
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        if (json.decode(response)['Data'] != null) {
          int da = int.parse(json.decode(response)['Data'].toString());
          switch (da) {
            case 1: //Pending
              orderDone('orderPending'.tr, 'paymentPendingMessage'.tr, true);
              break;
            case 2: //Success
              //Log.e("Transaction", "checkPaymentStatus onResponse Pending");
              orderDone('orderReceived'.tr, 'orderText'.tr, false);
              break;
            case 0: //None NotFound
            case 3: //Failed
            case 4: //Canceled
            case 5: //Expired
              //Log.e("Transaction", "checkPaymentStatus onResponse Failed");
              paymentError("orderFailed".tr, 'paymentFailedMessage'.tr);
              break;
          }
        } else {
          paymentError("orderFailed".tr, 'paymentFailedMessage'.tr);
        }
      }
    });
  }

  failPayment(String checkoutId, sdkTransaction) async {
    Helper().loading();
    await HttpClientApp()
        .request(
      method: 'POST',
      url: APIUrls.logPaymentFailure,
      body: {
        "PaymentToken": checkoutId,
        "MobileSDKResponse": sdkTransaction,
      },
      isJson: true,
      files: {},
    )
        .then((response) {
      Get.back();
      log(response, name: 'PaymentStatus');
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        paymentError("orderFailed".tr, 'paymentFailedMessage'.tr);
      } else {
        paymentError("orderFailed".tr, 'paymentFailedMessage'.tr);
      }
    });
  }

  cancelPayment(String checkoutId, sdkTransaction) async {
    Helper().loading();
    await HttpClientApp()
        .request(
      method: 'POST',
      url: '${APIUrls.cancelOrderPayment}?PaymentToken=$checkoutId',
      body: {},
      isJson: true,
      files: {},
    )
        .then((response) {
      Get.back();
      log(response, name: 'PaymentStatus');
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (mainResponse.isSucceeded!) {
        paymentError("orderFailed".tr, 'paymentFailedMessage'.tr);
      } else {
        paymentError("orderFailed".tr, 'paymentFailedMessage'.tr);
      }
    });
  }

  orderDone(String title, String message, bool isPend) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(SharedPreferencesKey.cart, []);
      cartList.value = cartFromJson(
          "${prefs.getStringList(SharedPreferencesKey.cart) ?? []}");
    });
    Get.dialog(
      AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          contentPadding: EdgeInsets.all(0),
          content: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Image.asset(
              isPend
                  ? AssetsConstant.paymentPendingGif
                  : AssetsConstant.orderComplete,
              height: Get.height * .2,
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(title.tr,
                          style: AppTheme.boldStyle(
                              color: Colors.black, size: 15)),
                      Text(message.tr,
                          textAlign: TextAlign.center,
                          style: AppTheme.lightStyle(color: Colors.black))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(Get.width * .35, Get.height * .075),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: AppTheme.colorAccent),
                        onPressed: () {
                          Get.deleteAll();
                          Get.back();
                          Get.to(MyOrderScreen(),duration: const Duration(seconds: 1),
                               transition: Transition.fadeIn);
                          // Get.offAll(MainScreen(),
                          //     duration: const Duration(seconds: 1),
                          //     transition: Transition.fadeIn);
                          // MainViewModel mainViewModel =
                          //     Get.isRegistered<MainViewModel>()
                          //         ? Get.find<MainViewModel>()
                          //         : Get.put(MainViewModel());
                          // mainViewModel.changeTab(3);
                        },
                        child: Text(
                          "orderHistory".tr,
                          style: AppTheme.lightStyle(
                              color: Colors.white, size: 18),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(Get.width * .35, Get.height * .075),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: AppTheme.colorPrimary),
                        onPressed: () {
                          Get.deleteAll();
                          Get.offAll(MainScreen(),
                              duration: const Duration(seconds: 1),
                              transition: Transition.fadeIn);
                          MainViewModel mainViewModel =
                              Get.isRegistered<MainViewModel>()
                                  ? Get.find<MainViewModel>()
                                  : Get.put(MainViewModel());
                          mainViewModel.changeTab(0);
                        },
                        child: Text("home".tr,
                            style: AppTheme.lightStyle(
                                color: Colors.white, size: 18))),
                  ],
                ),
              ],
            )
          ]),
    );
  }

  paymentError(String title, String message) {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  child: Image.asset(
                    AssetsConstant.paymentFailedGif,
                    height: Get.height * .2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title.tr),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message.tr,
                textAlign: TextAlign.center,
                style: AppTheme.lightStyle(color: Colors.black)),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.colorPrimary,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'done'.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Future getOrderStatus(Addresses? selectedAddress) async {
    await HttpClientApp()
        .request(
      method: 'Get',
      url: APIUrls.orderSetup,
      // body: {
      //   "CityId": selectedAddress?.cityId,
      //   "Latitude": selectedAddress?.latitude,
      //   "Longitude": selectedAddress?.longitude,
      //   "BrandId": 1,
      //   "CustomerAddressId": selectedAddress?.id,
      //   "SubTotalAmount": subTotal,
      //   "ShouldCalculateDeliveryFees": true,
      //   "ShouldCalculateTheClosestBranch": true
      // },
      body: {},
      isJson: true,
      files: {},
    )
        .then((response) async {
      // getScheduleTimes();
      log(jsonEncode(jsonDecode(response)), name: 'orderSetub ');
      orderSetup = OrderSetup.fromJson(json.decode(response));
      // deliveryFee = orderSetup!.deliveryFees;
      if (orderSetup?.deliveryRuleModel?.maximumDayToOrder != null &&
          orderSetup?.deliveryRuleModel?.minimumDayToOrder != null) {
        if (orderSetup?.deliveryRuleModel?.minimumDayToOrder == 0) {
          canNowDelivery = true;
          orderTime = 'now';
        } else {
          canNowDelivery = false;
          orderTime = 'later';
        }
        DateTime first = DateTime.now().add(Duration(
            days: orderSetup?.deliveryRuleModel?.minimumDayToOrder ?? 0));
        DateTime last = first.add(Duration(
            days: orderSetup?.deliveryRuleModel?.maximumDayToOrder ?? 0 + 1));
        print('deliveryRuleModel12 : $first  -  $last  ');
        DateTime temp = first;
        final items = List<DateTime>.generate(
            (orderSetup?.deliveryRuleModel?.maximumDayToOrder ?? 0) + 1,
            (i) => first.add(Duration(days: i)));
        items.forEach((element) {
          print('dayName ${DateFormat(
            'yyyy-MM-dd - EEEE',
          ).format(element)}');
          getDayNumberAndTranslate(
            DateFormat(
              'EEEE',
            ).format(element),
            DateFormat(
              'yyyy-MM-dd',
            ).format(element),
          );
        });
        print('deliveryDays: ${deliveryDays}');
      }
      calculatePrices();
      isCartLoading = false;
      MyAddressesViewModel myAddressesViewModel = MyAddressesViewModel();
      if (myAddressesViewModel.selectedAddress != null) {
        getDeliveryFee(myAddressesViewModel.selectedAddress!.id!);
      } else {
        myAddressesViewModel.getUserAddress().then((value) {
          if (myAddressesViewModel.selectedAddress != null) {
            getDeliveryFee(myAddressesViewModel.selectedAddress!.id!);
          }
        });
      }
      update();
      log(orderSetup!.toJson().toString());
      if (orderSetup!.isSucceeded!) {
        if (orderSetup!.availablePaymentTypes!.length != null)
          itemCountDeliveryMethodList =
              orderSetup!.availablePaymentTypes!.length;
        //rrequest
      } else {
        if (orderSetup!.errors!.isNotEmpty) {
          Helper().errorSnackBar(orderSetup!.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  //"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"

  getDayNumberAndTranslate(String day, String date) {
    switch (day) {
      case 'Sunday':
        deliveryDays.putIfAbsent(
            '${day.tr}, $date',
            () => orderSetup!.deliveryRuleModel!.deliveryRuleDefinitionsModel!
                .firstWhere((element) => element.dayId == 1)
                .canDeliver!);
        break;
      case 'Monday':
        deliveryDays.putIfAbsent(
            '${day.tr}, $date',
            () => orderSetup!.deliveryRuleModel!.deliveryRuleDefinitionsModel!
                .firstWhere((element) => element.dayId == 2)
                .canDeliver!);
        break;
      case 'Tuesday':
        deliveryDays.putIfAbsent(
            '${day.tr}, $date',
            () => orderSetup!.deliveryRuleModel!.deliveryRuleDefinitionsModel!
                .firstWhere((element) => element.dayId == 3)
                .canDeliver!);
        break;
      case 'Wednesday':
        deliveryDays.putIfAbsent(
            '${day.tr}, $date',
            () => orderSetup!.deliveryRuleModel!.deliveryRuleDefinitionsModel!
                .firstWhere((element) => element.dayId == 4)
                .canDeliver!);
        break;
      case 'Thursday':
        deliveryDays.putIfAbsent(
            '${day.tr}, $date',
            () => orderSetup!.deliveryRuleModel!.deliveryRuleDefinitionsModel!
                .firstWhere((element) => element.dayId == 5)
                .canDeliver!);
        break;
      case 'Friday':
        deliveryDays.putIfAbsent(
            '${day.tr}, $date',
            () => orderSetup!.deliveryRuleModel!.deliveryRuleDefinitionsModel!
                .firstWhere((element) => element.dayId == 6)
                .canDeliver!);
        break;
      case 'Saturday':
        deliveryDays.putIfAbsent(
            '${day.tr}, $date',
            () => orderSetup!.deliveryRuleModel!.deliveryRuleDefinitionsModel!
                .firstWhere((element) => element.dayId == 7)
                .canDeliver!);
        break;
    }
  }

  Future getDeliveryFee(addressId) async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getDeliveryFee}?brandId=1&customerAddressId=$addressId',
      body: {},
      files: {},
    ).then((response) async {
      log(json.decode(response)["Data"].toString(), name: 'delevevevev1');
      MainResponse mainResponse = MainResponse.fromJson(json.decode(response));
      if (json.decode(response)["Data"] != null) {
        deliveryFee = json.decode(response)["Data"];
        log(deliveryFee.toString(), name: 'delevevevev2');
        calculatePrices();
        update();
      } else {
        if (mainResponse.errors!.isNotEmpty) {
          Helper().errorSnackBar(mainResponse.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  Future getAlsoPeopleAdded() async {
    await HttpClientApp().request(
      method: 'GET',
      url: '${APIUrls.getAlsoPeopleAdded}?brandId=1',
      body: {},
      files: {},
    ).then((response) async {
      alsoAddedProducts = PeopleAlsoAddedModel.fromJson(json.decode(response));
      update();
      print(alsoAddedProducts.productItems!.length);
      isLoading = false;
      if (alsoAddedProducts.isSucceeded!) {
      } else {
        if (alsoAddedProducts.errors!.isNotEmpty) {
          Helper().errorSnackBar(alsoAddedProducts.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
      update();
    });
  }

  unAvailableTime(
      OrderPossibilityResult orderPossibilityResult, bool isCanOrder) {
    print(jsonEncode(orderPossibilityResult.toJson()));
  }

  getScheduleTimes() async {
    await HttpClientApp()
        .request(
      method: 'GET',
      url: APIUrls.orderAvailableTime,
      body: {},
      isJson: true,
      files: {},
    )
        .then((response) async {
      log(response, name: 'getScheduleTimes');
      scheduleTimes = ScheduleTimes.fromJson(json.decode(response));
      if (scheduleTimes!.isSucceeded!) {
        selectedDate = scheduleTimes!.data!.first;
      } else {
        if (scheduleTimes!.errors!.isNotEmpty) {
          Helper().errorSnackBar(scheduleTimes!.errors![0].errorMessage!);
        } else {
          Helper().errorSnackBar('defaultError'.tr);
        }
      }
    });
  }

  calculatePrices() {
    print("sasa");
    print('finalAmount: $finalAmount');
    print('deliveryFeesDiscount: $deliveryFeesDiscount');
    print('deliveryFees: $deliveryFee');
    subTotal = 0;
    if (cartItems.isNotEmpty) {
      unitPrice = cartItems.first.itemPriceUnit!;
      cartItems.forEach((element) {
        if (element.itemTotalOfferPrice! > 0) {
          subTotal += element.itemTotalOfferPrice!;
        } else {
          subTotal += element.itemTotalPrice!;
        }
      });
      //TODO: calculate DeliveryDicount
      calculateDeliveryFesDiscount();

      double discount = orderSetup?.discount ?? 0;
      taxAmount = (orderSetup?.tax ?? 0) * subTotal;
      if (discount > 0) {
        discountAmountPercent = (discount * 100).toInt();
        discount = subTotal * discount;
        discountPrice = discount;
        grandAmount = subTotal - discount - discountPromo;
        finalAmount = grandAmount! + (deliveryFeesDiscount) + taxAmount;
      } else {
        finalAmount =
            subTotal - discountPromo + deliveryFeesDiscount + taxAmount;
      }
    }
    if (isPoint) {
      print('finalAmount: $finalAmount');
      print('deliveryFeesDiscount: $deliveryFeesDiscount');
      print('deliveryFees: $deliveryFee');
      double finalAmountWithOutDeliveryFee =
          finalAmount - (deliveryFeesDiscount);

      if ((orderSetup?.userBalance ?? 0) > finalAmountWithOutDeliveryFee) {
        pointsRedeemed = finalAmountWithOutDeliveryFee;
        finalAmount = 0 + (deliveryFeesDiscount);
      } else {
        finalAmount = finalAmountWithOutDeliveryFee -
            (orderSetup?.userBalance ?? 0) +
            (deliveryFeesDiscount);
        pointsRedeemed = (orderSetup?.userBalance ?? 0);
      }
    }
    calculateDeliveryFesDiscount();
    update();
  }

  handlePromoResponse1() {
    switch (promoModel!.promotionCodeStatus) {
      case 4: //Active
        promoDone = true;
        promoTrue = true;
        errorText = '';
        update();
        break;
      default:
        promoDone = true;
        promoTrue = false;
        if (promoModel!.errors!.isNotEmpty) {
          errorText = promoModel!.errors![0].errorMessage!;
          //errorText = 'invalidPromoCode'.tr;
        } else {
          errorText = 'somethingWrong'.tr;
        }
        update();
        break;
    }
  }

  bool hasDiscount = false;
  double finalDeliveryFees = 0;

  calculateDeliveryFesDiscount() {
    print("sasa2");
    print('finalAmount: $finalAmount');
    print('deliveryFeesDiscount: $deliveryFeesDiscount');
    print('deliveryFees: $deliveryFee');
    deliveryFeesDiscount = deliveryFee ?? 0;
    if ((orderSetup?.deliveryFeesDiscounts ?? []).isNotEmpty) {
      print('orderSetup::: ${jsonEncode(orderSetup!.toJson())}');
      for (var element in orderSetup!.deliveryFeesDiscounts!) {
        print(
            'deliveryFeesDiscounts: ${subTotal >= element.fromValue && subTotal <= element.toValue}');
        if (subTotal >= element.fromValue && subTotal <= element.toValue) {
          hasDiscount = true;
          update();
          if (element.discountTypeId == 0) {
            //Percentage
            deliveryFeesDiscount =
                (deliveryFee ?? 0) - (element.discountValue * deliveryFee);
          } else if (element.discountTypeId == 1) {
            //Amount
            if (element.discountValue > deliveryFee) {
              deliveryFeesDiscount = 0;
            } else {
              deliveryFeesDiscount = (deliveryFee ?? 0) - element.discountValue;
            }
          }
        }
      }
    }
    if (deliveryFeesDiscount == deliveryFee) {
      hasDiscount = false;
      update();
    }
  }
}
