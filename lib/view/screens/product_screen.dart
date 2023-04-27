import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:Marouf/view/widgets/image_preview_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../models/order_history.dart' as orderModel;
import '../../models/product_details.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/helper.dart';
import '../../utils/theme/app_theme.dart';
import '../../viewmodel/product_viewmodel.dart';
import '../widgets/actions_app_bar_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/product_details_loading.dart';
import 'main_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.productItem, {Key? key}) : super(key: key);
  final int productItem;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductViewModel>(
      init: ProductViewModel(productItem),
      tag: 'ProductItem_${productItem}',
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          controller.tagButton = 'null';
          controller.update();
          Get.back();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppTheme.colorAccent),
            title: Text(controller.productDetails.name ?? '',
                style: AppTheme.lightStyle(
                    color: AppTheme.colorAccent, size: 16.sp)),
            actions: const [
              ActionsAppBarWidget(
                isHome: true,
              )
            ],
          ),
          bottomNavigationBar: controller.isLoading
              ? Container(
                  height: 0,
                )
              : controller.productDetails.hasOnlineOrdering == true
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Hero(
                        tag: controller.tagButton,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!controller.isProcessed) {
                              controller.isProcessed = true;
                              controller.update();
                              controller.login(() {
                                if (controller.selectedPrice != null) {
                                  if ((controller.productDetails
                                                  .productProperties ??
                                              [])
                                          .isNotEmpty &&
                                      controller.selectedColor == null) {
                                    Helper()
                                        .errorSnackBar('pleaseSelectColor'.tr);
                                    controller.isProcessed = false;
                                    controller.update();
                                  } else {
                                    bool isRequiredSelected = true;
                                    controller.radioValues
                                        .forEach((key, value) {
                                      if (value == null) {
                                        isRequiredSelected = false;
                                        Helper().errorSnackBar(
                                            '${'pleaseSelectFrom'.tr}: ${controller.productDetails.productItemOptions!.firstWhere((element) => element.optionId == key).optionLable}');
                                        controller.isProcessed = false;
                                        controller.update();
                                      } else {
                                        isRequiredSelected = true;
                                      }
                                    });
                                    if (isRequiredSelected) {
                                      var uuid = const Uuid();
                                      String uniqueId = uuid.v1();

                                      String productName =
                                          controller.productDetails.name ?? '';
                                      if (controller.productDetails
                                              .productItemPriceModel!.length >
                                          1) {
                                        productName =
                                            '$productName - ${controller.selectedPrice.size}';
                                      }

                                      var body = {
                                        "ItemId":
                                            "${controller.productDetails.id!}",
                                        "ItemName": productName,
                                        "ItemCategoryId":
                                            "${controller.productDetails.categoryId!}",
                                        "ItemURL": controller.productDetails
                                                .productItemImageModel!.isEmpty
                                            ? ''
                                            : controller
                                                    .productDetails
                                                    .productItemImageModel
                                                    ?.first
                                                    .url ??
                                                '',
                                        "ItemPrice":
                                            '${controller.selectedPrice.price}',
                                        "ItemOfferPrice": controller
                                                    .selectedPrice.offerPrice >
                                                0
                                            ? controller
                                                .selectedPrice.offerPrice
                                            : 0.0,
                                        "ItemTotalOfferPrice": controller
                                                    .selectedPrice.offerPrice >
                                                0
                                            ? controller.finalPrice
                                            : 0.0,
                                        "ItemPriceId":
                                            '${controller.selectedPrice.id!}',
                                        "ItemPriceUnit": controller
                                            .selectedPrice.currancyDisplayName!,
                                        "ItemBrandId": '1',
                                        "ItemBrandName": 'Marouf Coffee',
                                        "HasOptions":
                                            '${controller.productDetails.hasOptions!}',
                                        "ItemInstructions": controller
                                            .specialInstructionsController.text,
                                        "ItemQuantity":
                                            '${controller.quantity}',
                                        "ItemUniqueId": uniqueId,
                                        "ItemTotalPrice": controller.finalPrice!
                                            .toStringAsFixed(2),
                                        "ItemLabel":
                                            "${controller.productDetails.label ?? ""}"
                                      };
                                      if (controller.productDetails
                                              .productItemPriceModel!.length >
                                          1) {
                                        for (var element in controller
                                            .productDetails
                                            .productItemPriceModel!) {
                                          if (element.id ==
                                              controller.selectedPrice.id) {
                                            body.putIfAbsent('ItemPriceName',
                                                () => element.size);
                                          }
                                        }
                                      }
                                      if (controller.selectedColor != null) {
                                        body.putIfAbsent(
                                            'ProductProperties',
                                            () => [
                                                  {
                                                    "Id": controller
                                                        .selectedColor!.id!,
                                                    "Value": controller
                                                        .selectedColor!.value!,
                                                  }
                                                ]);
                                        body['ItemURL'] = controller
                                                    .selectedColor!.imageUrl !=
                                                null
                                            ? controller
                                                .selectedColor!.imageUrl!
                                            : '';
                                      }
                                      var listOption = [];
                                      if (controller
                                          .productDetails.hasOptions!) {
                                        controller.optionsValue
                                            .forEach((key, value) {
                                          value.forEach((element1) {
                                            OptionItem optionItem = controller
                                                .productDetails
                                                .productItemOptions!
                                                .firstWhere((element2) =>
                                                    element2.optionId == key)
                                                .optionItems!
                                                .firstWhere((element3) =>
                                                    element3
                                                        .productOptionItemId ==
                                                    element1);

                                            var jsonOptions = {};
                                            jsonOptions.putIfAbsent(
                                                'optionId',
                                                () =>
                                                    '${optionItem.productOptionItemId}');
                                            jsonOptions.putIfAbsent(
                                                'optionParentName',
                                                () =>
                                                    '${controller.optionsValueName[key]}');
                                            jsonOptions.putIfAbsent(
                                                'optionPrice',
                                                () => optionItem.price);
                                            jsonOptions.putIfAbsent(
                                                'optionName',
                                                () => '${optionItem.name}');
                                            jsonOptions.putIfAbsent(
                                                'optionParentId', () => '$key');
                                            listOption.add(jsonOptions);
                                          });
                                        });
                                        controller.radioValues
                                            .forEach((key, value) {
                                          OptionItem optionItem = controller
                                              .productDetails
                                              .productItemOptions!
                                              .firstWhere((element2) =>
                                                  element2.optionId == key)
                                              .optionItems!
                                              .firstWhere((element3) =>
                                                  element3
                                                      .productOptionItemId ==
                                                  value);

                                          var jsonOptions = {};
                                          jsonOptions.putIfAbsent(
                                              'optionId',
                                              () =>
                                                  '${optionItem.productOptionItemId}');
                                          jsonOptions.putIfAbsent(
                                              'optionParentName',
                                              () =>
                                                  '${controller.optionsValueName[key]}');
                                          jsonOptions.putIfAbsent('optionPrice',
                                              () => optionItem.price!);
                                          jsonOptions.putIfAbsent('optionName',
                                              () => '${optionItem.name}');
                                          jsonOptions.putIfAbsent(
                                              'optionParentId', () => '$key');
                                          listOption.add(jsonOptions);
                                        });
                                      }
                                      body.putIfAbsent(
                                          'itemOptions', () => listOption);

                                      log('oioih ${body}');
                                      controller.addToCart(body, context);
                                    }
                                  }
                                } else {
                                  Helper()
                                      .errorSnackBar('pleaseSelectPrice'.tr);
                                  controller.isProcessed = false;
                                  controller.update();
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: controller.isProcessed
                                  ? Colors.grey
                                  : AppTheme.colorPrimary),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('addToCart'.tr,
                                    style: AppTheme.lightStyle(
                                        color: Colors.white, size: 18.sp)),
                                controller.finalPrice == null
                                    ? Text("")
                                    : Text(
                                        '${controller.finalPrice!.toStringAsFixed(2)} ${controller.productDetails.productItemPriceModel![0].currancyDisplayName}',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.lightStyle(
                                            color: Colors.white, size: 18.sp),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
          body: controller.isLoading
              ? const ProductDetailsLoading()
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          children: [
                            controller.productDetails.productItemImageModel!
                                    .isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: GestureDetector(
                                          onTap: () {
                                            context.pushTransparentRoute(
                                                CachedNetworkImage(
                                                    imageUrl: controller
                                                            .selectedProperty !=
                                                        null
                                                    ? controller
                                                        .selectedProperty!
                                                        .imageUrl!
                                                    : controller
                                                            .productDetails
                                                            .productItemImageModel!
                                                            .first
                                                            .url ??
                                                        AssetsConstant.placeHolder,fit: BoxFit.cover,));
                                          },
                                          child: Column(
                                            children: [
                                              FittedBox(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: CachedNetworkImage(
                                                      imageUrl: controller.selectedProperty !=
                                                              null
                                                          ? controller
                                                              .selectedProperty!
                                                              .imageUrl!
                                                          : controller
                                                                  .productDetails
                                                                  .productItemImageModel!
                                                                  .first
                                                                  .url ??
                                                              AssetsConstant
                                                                  .logo,
                                                      height: Get.height * .25,
                                                      fit: BoxFit.fitWidth,
                                                      placeholder: (w, e) =>
                                                          Image.asset(
                                                        AssetsConstant.loading,
                                                        fit: BoxFit.cover,
                                                        height: Get.height * .3,
                                                        width: Get.height * .2,
                                                      ),
                                                      errorWidget: (c, e, s) =>
                                                          Image.asset(
                                                              AssetsConstant
                                                                  .logo),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    child: Image.asset(
                                      AssetsConstant.placeHolder,
                                      height: Get.height*.25,
                                      width: Get.width,
                                    ),
                                  ),
                            if (controller.productDetails.productItemImageModel!
                                    .length >
                                1)
                              SizedBox(
                                height: Get.height * .1,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.productDetails
                                          .productItemImageModel?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        orderModel.ProductProperties?
                                            productProperties =
                                            orderModel.ProductProperties(
                                                imageUrl: controller
                                                    .productDetails
                                                    .productItemImageModel![
                                                        index]
                                                    .url!);
                                        controller.selectedProperty =
                                            productProperties;
                                        controller.update();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: controller
                                                        .productDetails
                                                        .productItemImageModel![
                                                            index]
                                                        .url !=
                                                    null
                                                ? controller
                                                    .productDetails
                                                    .productItemImageModel![
                                                        index]
                                                    .url!
                                                : '',
                                            fit: BoxFit.cover,
                                            height: Get.height * .07,
                                            placeholder: (w, e) => Image.asset(
                                              AssetsConstant.loading,
                                              fit: BoxFit.cover,
                                              height: Get.height * .07,
                                            ),
                                            errorWidget: (c, e, s) =>
                                                Image.asset(
                                              AssetsConstant.placeHolder,
                                              height: Get.height * .07,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            if (controller.productDetails.productUrl != null)
                              GestureDetector(
                                onTap: () async {
                                  String url =
                                      "${controller.productDetails.productUrl}";
                                  Uri uri = Uri.parse(url);
                                  if (!await launchUrl(uri,
                                      mode: LaunchMode.externalApplication)) {
                                    throw 'Could not launch $uri';
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.red),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: Get.width * .05,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0,
                                                  vertical: 5),
                                              child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  size: 40,
                                                  color: Colors.red),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text('watchOnYoutube'.tr,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${controller.productDetails.name}',
                                          textAlign: TextAlign.center,
                                          style: AppTheme.boldStyle(
                                              color: Colors.black, size: 18.sp),
                                        ),
                                      ),
                                    ],
                                  )),
                                  if (controller.productDetails.description !=
                                      null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${controller.productDetails.description}',
                                              textAlign: TextAlign.center,
                                              textDirection: intl.Bidi
                                                      .detectRtlDirectionality(
                                                          '${controller.productDetails.description}')
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                              style: AppTheme.lightStyle(
                                                  color: Colors.black
                                                      .withOpacity(.5),
                                                  size: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (controller.selectedPrice != null)
                                    if (controller.selectedPrice.price
                                            .toString() !=
                                        '0.0')
                                      Column(
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              '${controller.selectedPrice.price} ${controller.selectedPrice.currancyDisplayName}',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.lightStyle(
                                                      color:
                                                          AppTheme.colorPrimary,
                                                      size: 20)
                                                  .copyWith(
                                                      decoration: controller
                                                                  .productDetails
                                                                  .productItemPriceModel![
                                                                      0]
                                                                  .offerPrice >
                                                              0
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration
                                                              .none),
                                            ),
                                          ),
                                          if (controller
                                                  .productDetails
                                                  .productItemPriceModel![0]
                                                  .offerPrice >
                                              0)
                                            FittedBox(
                                              child: Text(
                                                '${controller.selectedPrice.offerPrice} ${controller.selectedPrice.currancyDisplayName}',
                                                textAlign: TextAlign.center,
                                                style: AppTheme.boldStyle(
                                                    color: Colors.red,
                                                    size: 18),
                                              ),
                                            ),
                                        ],
                                      ),
                                ],
                              ),
                            ),
                            if (controller.productDetails.itemNumber != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      '${'itemNumber'.tr}: ${controller.productDetails.itemNumber}',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.boldStyle(
                                          color: AppTheme.colorAccent,
                                          size: 16),
                                    ),
                                  ],
                                ),
                              ),

                            //properties
                            if (controller
                                .productDetails.productProperties!.isNotEmpty)
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'color'.tr,
                                            style: AppTheme.lightStyle(
                                                color: Colors.black, size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            if (controller
                                .productDetails.productProperties!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 21.0),
                                child: SizedBox(
                                    height: Get.height * .042,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.productDetails
                                          .productProperties!.length,
                                      itemBuilder: (context, index) => Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.selectedProperty =
                                                  controller.productDetails
                                                          .productProperties![
                                                      index];
                                              controller.selectedColor =
                                                  controller.productDetails
                                                          .productProperties![
                                                      index];
                                              controller.update();
                                            },
                                            child: Card(
                                              color: controller
                                                          .selectedColor?.id ==
                                                      controller
                                                          .productDetails
                                                          .productProperties![
                                                              index]
                                                          .id
                                                  ? Colors.grey.shade400
                                                  : Colors.transparent,
                                              elevation: controller
                                                          .selectedColor?.id ==
                                                      controller
                                                          .productDetails
                                                          .productProperties![
                                                              index]
                                                          .id
                                                  ? 2
                                                  : 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              margin: const EdgeInsets.all(0),
                                              child: SizedBox(
                                                height: Get.height * .04,
                                                width: Get.height * .04,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      Get.height * .006),
                                                  child: Container(
                                                    height: Get.height * .03,
                                                    width: Get.height * .03,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: HexColor.fromHex(
                                                            controller
                                                                .productDetails
                                                                .productProperties![
                                                                    index]
                                                                .value!)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * .03,
                                            width: Get.height * .01,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),

                            //prices
                            if (controller.productDetails.productItemPriceModel!
                                    .length >
                                1)
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 8, left: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              requiredPrice(
                                                  controller.productDetails
                                                          .productItemPriceModel ??
                                                      [],
                                                  controller),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Text(
                                      //   '${item.optionPrice!.toStringAsFixed(2)} ${'sar'.tr}',
                                      //   style: AppTheme.boldStyle(
                                      //       color: Colors.black,
                                      //       size: 12),
                                      // ),
                                    ],
                                  )),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "quantity".tr,
                                    style: AppTheme.lightStyle(
                                        color: Colors.black, size: 20),
                                  ),
                                  Container(
                                    height: Get.width * .1,
                                    width: Get.width * .33,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme.colorAccent,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: GestureDetector(
                                              onTapDown: (details) {
                                                controller.startPositionAdd =
                                                    true;
                                                controller.startPositionSub =
                                                    false;
                                                controller.update();
                                              },
                                              onTapUp: (details) {
                                                controller.quantityAdd();
                                              },
                                              onTapCancel: () {
                                                controller.quantityAdd();
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Icon(Icons.add,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          bottom: 0,
                                          left: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme.colorAccent,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: GestureDetector(
                                              onTapDown: (details) {
                                                controller.startPositionAdd =
                                                    false;
                                                controller.startPositionSub =
                                                    true;
                                                controller.update();
                                              },
                                              onTapUp: (details) {
                                                controller.quantitySub();
                                              },
                                              onTapCancel: () {
                                                controller.quantitySub();
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(6.0),
                                                child: Icon(Icons.remove,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        AnimatedAlign(
                                          duration:
                                              const Duration(milliseconds: 100),
                                          alignment: controller.startPositionAdd
                                              ? Alignment.centerRight
                                              : controller.startPositionSub
                                                  ? Alignment.centerLeft
                                                  : Alignment.center,
                                          child: Container(
                                              height: Get.width * .1,
                                              width: Get.width * .1,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppTheme.colorPrimary,
                                                      width: 2),
                                                  color: AppTheme.colorPrimary,
                                                  shape: BoxShape.circle),
                                              child: Center(
                                                child: Text(
                                                    controller.quantity
                                                        .toString(),
                                                    style: AppTheme.lightStyle(
                                                        color: Colors.white,
                                                        size: 18.sp)),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: const [
                                  Expanded(child: Divider()),
                                ],
                              ),
                            ),
                            //product Option
                            if (controller
                                .productDetails.productItemOptions!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, right: 8, left: 8),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.productDetails
                                      .productItemOptions!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    ProductItemOption item = controller
                                        .productDetails
                                        .productItemOptions![index];
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0),
                                            child: Card(
                                              margin: const EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: ExpansionTile(
                                                  initiallyExpanded: false,
                                                  collapsedIconColor:
                                                      Colors.white,
                                                  collapsedTextColor:
                                                      Colors.white,
                                                  iconColor: Colors.white,
                                                  collapsedBackgroundColor:
                                                      AppTheme.colorPrimaryDark,
                                                  backgroundColor:
                                                      AppTheme.colorPrimaryDark,
                                                  title: Text(item.optionLable!,
                                                      style: AppTheme.boldStyle(
                                                          color: Colors.white,
                                                          size: 13.sp)),
                                                  children: [
                                                    Container(
                                                      color: Colors.white,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                          item.optionType == 1
                                                              ? multiOptions(
                                                                  item,
                                                                  controller)
                                                              : requiredOptions(
                                                                  item,
                                                                  controller),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   '${item.optionPrice!.toStringAsFixed(2)} ${'sar'.tr}',
                                        //   style: AppTheme.boldStyle(
                                        //       color: Colors.black,
                                        //       size: 12),
                                        // ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            // if ((controller
                            //             .productDetails.relatedProductModel ??
                            //         [])
                            //     .isNotEmpty)
                            //   Column(
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Expanded(
                            //             child: Padding(
                            //               padding: const EdgeInsets.only(
                            //                   top: 16.0,
                            //                   left: 16,
                            //                   right: 16,
                            //                   bottom: 8),
                            //               child: Text(
                            //                 'relatedProduct'.tr,
                            //                 style: const TextStyle(
                            //                   fontSize: 15,
                            //                   color: AppTheme.colorPrimary,
                            //                   fontWeight: FontWeight.bold,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(
                            //         height: Get.height * .3,
                            //         child: ListView.builder(
                            //             shrinkWrap: true,
                            //             scrollDirection: Axis.horizontal,
                            //             itemCount: controller.productDetails
                            //                 .relatedProductModel!.length,
                            //             itemBuilder: (context, index) {
                            //               return ProductCardWidget(controller
                            //                   .productDetails
                            //                   .relatedProductModel![index]);
                            //             }),
                            //       ),
                            //       SizedBox(
                            //         height: Get.height * .02,
                            //       ),
                            //     ],
                            //   ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: AppTheme.colorPrimary)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: controller.specialInstructionsController,
                                    decoration: InputDecoration(
                                      hintText: 'specialInstructions'.tr,
                                      hintStyle: AppTheme.lightStyle(
                                          color: AppTheme.colorAccent),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget requiredOptions(ProductItemOption item, ProductViewModel controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: item.optionItems!.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                controller.radioValues[item.optionId!] =
                    item.optionItems![index].productOptionItemId!;
                if (controller.radioPrices.containsKey(item.optionId!)) {
                  controller.radioPrices[item.optionId!] =
                      item.optionItems![index].price;
                } else {
                  controller.radioPrices.putIfAbsent(
                      item.optionId!, () => item.optionItems![index].price);
                }
                controller.calculateFinalPrice();
                controller.update();
              },
              leading: IgnorePointer(
                ignoring: true,
                child: Radio<int>(
                  value: item.optionItems![index].productOptionItemId!,
                  groupValue: controller.radioValues[item.optionId!],
                  fillColor: MaterialStateProperty.all(AppTheme.colorPrimary),
                  onChanged: (val) {},
                ),
              ),
              title: Text(item.optionItems![index].name!,
                  style: AppTheme.lightStyle(
                      color: AppTheme.colorAccent, size: 14.sp)),
              trailing: Text(
                  '${item.optionItems![index].price == 0 ? ''.tr : item.optionItems![index].price} ${item.optionItems![index].price == 0 ? '' : controller.productDetails.productItemPriceModel![0].currancyDisplayName}',
                  style:
                      AppTheme.lightStyle(color: AppTheme.colorPrimary)),
            ));
  }

  Widget requiredPrice(
      List<ProductItemPriceModel> items, ProductViewModel controller) {
    return Wrap(
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color:controller.selectedColorPrice==e.id?AppTheme.colorPrimary:Colors.black,width: 2),borderRadius: BorderRadius.circular(10)),
                width: Get.width * .4,
                child: ListTile(
                  tileColor: Colors.transparent,
                  onTap: () {
                    controller.selectedColorPrice=e.id;
                    controller.selectedPrice = e;
                    controller.calculateFinalPrice();
                    controller.update();
                  },
                  contentPadding: EdgeInsets.all(0),
                  // leading: IgnorePointer(
                  //   ignoring: true,
                  //   child: Radio<ProductItemPriceModel>(
                  //     value: e,
                  //     groupValue: controller.selectedPrice,
                  //     fillColor: MaterialStateProperty.all(AppTheme.colorPrimary),
                  //     onChanged: (val) {},
                  //   ),
                  // ),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(e.size!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: AppTheme.boldStyle(
                                    color: AppTheme.colorAccent, size: 12.sp)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              '${e.price} ${e.currancyDisplayName}',
                              textAlign: TextAlign.center,
                              style: AppTheme.lightStyle(
                                      color: AppTheme.colorAccent.withOpacity(.6),
                                      size: Get.width * .035)
                                  .copyWith(
                                      decoration: e.offerPrice > 0
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          if (e.offerPrice > 0)
                            Text(
                              '${e.offerPrice} ${e.currancyDisplayName}',
                              textAlign: TextAlign.center,
                              style: AppTheme.boldStyle(
                                  color: Colors.red, size: Get.width * .035),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget multiOptions(ProductItemOption item, ProductViewModel controller) {
    List<int> options = controller.optionsValue[item.optionId!] ?? [];
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: item.optionItems!.length,
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            if (options
                .contains(item.optionItems![index].productOptionItemId)) {
              options.remove(item.optionItems![index].productOptionItemId!);
            } else {
              options.add(item.optionItems![index].productOptionItemId!);
            }
            if (controller.optionPrices
                .containsKey(item.optionItems![index].productOptionItemId)) {
              controller.optionPrices
                  .remove(item.optionItems![index].productOptionItemId!);
            } else {
              controller.optionPrices.putIfAbsent(
                  item.optionItems![index].productOptionItemId!,
                  () => item.optionItems![index].price!);
            }
            controller.optionsValue[item.optionId!] = options;
            controller.calculateFinalPrice();
            controller.update();
          },
          leading: IgnorePointer(
            ignoring: true,
            child: Checkbox(
              fillColor: MaterialStateProperty.all(AppTheme.colorPrimary),
              onChanged: (bool? value) {},
              value: options
                  .contains(item.optionItems![index].productOptionItemId!),
            ),
          ),
          trailing: Text(
              '${item.optionItems![index].price == 0 ? ''.tr : item.optionItems![index].price} ${item.optionItems![index].price == 0 ? '' : controller.productDetails.productItemPriceModel![0].currancyDisplayName}',
              style: AppTheme.lightStyle(color: AppTheme.colorAccent)),
          title: Text(item.optionItems![index].name!,
              style: AppTheme.lightStyle(
                  color: AppTheme.colorAccent, size: 14.sp))),
    );
  }
}
