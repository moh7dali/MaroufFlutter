import 'dart:convert';

List<CartItem> cartFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  CartItem({
    this.itemId,
    this.itemName,
    this.itemCategoryId,
    this.itemUrl,
    this.itemPrice,
    this.itemOfferPrice,
    this.itemTotalOfferPrice,
    this.itemPriceId,
    this.itemPriceUnit,
    this.itemBrandId,
    this.itemBrandName,
    this.hasOptions,
    this.itemInstructions,
    this.itemQuantity,
    this.itemUniqueId,
    this.itemTotalPrice,
    this.productProperties,
    this.itemOptions,
  });

  String? itemId;
  String? itemName;
  String? itemCategoryId;
  String? itemUrl;
  double? itemPrice;
  double? itemOfferPrice;
  double? itemTotalOfferPrice;
  String? itemPriceId;
  String? itemPriceUnit;
  String? itemBrandId;
  String? itemBrandName;
  String? hasOptions;
  String? itemInstructions;
  dynamic itemQuantity;
  String? itemUniqueId;
  double? itemTotalPrice;
  List<ItemOption>? itemOptions;
  List<ProductProperties1>? productProperties;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    itemId: json["ItemId"] == null ? null : json["ItemId"],
    itemName: json["ItemName"] == null ? null : json["ItemName"],
    itemCategoryId:
    json["ItemCategoryId"] == null ? null : json["ItemCategoryId"],
    itemUrl: json["ItemURL"] == null ? null : json["ItemURL"],
    itemPrice: json["ItemPrice"] == null
        ? null
        : double.parse(json["ItemPrice"].toString()),
    itemOfferPrice: json["ItemOfferPrice"] == null
        ? null
        : double.parse(json["ItemOfferPrice"].toString()),
    itemTotalOfferPrice: json["ItemTotalOfferPrice"] == null
        ? null
        : double.parse(json["ItemTotalOfferPrice"].toString()),
    itemPriceId: json["ItemPriceId"] == null ? null : json["ItemPriceId"],
    itemPriceUnit:
    json["ItemPriceUnit"] == null ? null : json["ItemPriceUnit"],
    itemBrandId: json["ItemBrandId"] == null ? null : json["ItemBrandId"],
    itemBrandName:
    json["ItemBrandName"] == null ? null : json["ItemBrandName"],
    hasOptions: json["HasOptions"] == null ? null : json["HasOptions"],
    itemInstructions:
    json["ItemInstructions"] == null ? null : json["ItemInstructions"],
    itemQuantity:
    json["ItemQuantity"] == null ? null : json["ItemQuantity"],
    itemUniqueId:
    json["ItemUniqueId"] == null ? null : json["ItemUniqueId"],
    itemTotalPrice: json["ItemTotalPrice"] == null
        ? null
        : double.parse(json["ItemTotalPrice"].toString()),
    itemOptions: json["itemOptions"] == null
        ? null
        : List<ItemOption>.from(
        json["itemOptions"].map((x) => ItemOption.fromJson(x))),
    productProperties: json["ProductProperties"] == null
        ? null
        : List<ProductProperties1>.from(json["ProductProperties"]
        .map((x) => ProductProperties1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ItemId": itemId == null ? null : itemId,
    "ItemName": itemName == null ? null : itemName,
    "ItemCategoryId": itemCategoryId == null ? null : itemCategoryId,
    "ItemURL": itemUrl == null ? null : itemUrl,
    "ItemPrice": itemPrice == null ? null : itemPrice,
    "ItemOfferPrice": itemOfferPrice == null ? null : itemOfferPrice,
    "ItemTotalOfferPrice":
    itemTotalOfferPrice == null ? null : itemTotalOfferPrice,
    "ItemPriceId": itemPriceId == null ? null : itemPriceId,
    "ItemPriceUnit": itemPriceUnit == null ? null : itemPriceUnit,
    "ItemBrandId": itemBrandId == null ? null : itemBrandId,
    "ItemBrandName": itemBrandName == null ? null : itemBrandName,
    "HasOptions": hasOptions == null ? null : hasOptions,
    "ItemInstructions": itemInstructions == null ? null : itemInstructions,
    "ItemQuantity": '$itemQuantity',
    "ItemUniqueId": itemUniqueId == null ? null : itemUniqueId,
    "ItemTotalPrice": itemTotalPrice == null ? null : itemTotalPrice,
    "itemOptions": itemOptions == null
        ? null
        : List<dynamic>.from(itemOptions!.map((x) => x.toJson())),
    "ProductProperties": productProperties == null
        ? null
        : List<dynamic>.from(productProperties!.map((x) => x.toJson())),
  };
}

class ItemOption {
  ItemOption(
      {this.optionId,
        this.optionPrice,
        this.optionName,
        this.optionParentId,
        this.optionParentName});

  String? optionId;
  double? optionPrice;
  String? optionName;
  String? optionParentId;
  String? optionParentName;

  factory ItemOption.fromJson(Map<String, dynamic> json) => ItemOption(
    optionId: json["optionId"] == null ? null : json["optionId"],
    optionPrice: json["optionPrice"],
    optionName: json["optionName"] == null ? null : json["optionName"],
    optionParentId:
    json["optionParentId"] == null ? null : json["optionParentId"],
    optionParentName: json["optionParentName"],
  );

  Map<String, dynamic> toJson() => {
    "optionId": optionId == null ? null : optionId,
    "optionPrice": optionPrice,
    "optionParentName": optionParentName,
    "optionName": optionName == null ? null : optionName,
    "optionParentId": optionParentId == null ? null : optionParentId,
  };
}

class ProductProperties1 {
  ProductProperties1({
    this.id,
    this.value,
  });

  dynamic id;
  String? value;

  factory ProductProperties1.fromJson(Map<String, dynamic> json) =>
      ProductProperties1(
        id: json["Id"] == null ? null : json["Id"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "Value": value,
  };
}
