import 'package:Marouf/models/main_response.dart';

class OrderHistory {
  final List<UserOrderModel>? userOrderModel;
  final String? dookAuthorizationToken;
  final bool? hasOnHoldPayment;
  final bool? isSucceeded;
  final List<Error>? errors;
  final int? totalNumberofResult;

  OrderHistory({
    this.userOrderModel,
    this.dookAuthorizationToken,
    this.hasOnHoldPayment,
    this.isSucceeded,
    this.errors,
    this.totalNumberofResult,
  });

  OrderHistory.fromJson(Map<String, dynamic> json)
      : userOrderModel = (json['UserOrderModel'] as List?)?.map((dynamic e) => UserOrderModel.fromJson(e as Map<String,dynamic>)).toList(),
        dookAuthorizationToken = json['DookAuthorizationToken'] as String?,
        hasOnHoldPayment = json['HasOnHoldPayment'] as bool?,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Error.fromJson(e as Map<String,dynamic>)).toList(),
        totalNumberofResult = json['TotalNumberofResult'] as int?;

  Map<String, dynamic> toJson() => {
    'UserOrderModel' : userOrderModel?.map((e) => e.toJson()).toList(),
    'DookAuthorizationToken' : dookAuthorizationToken,
    'HasOnHoldPayment' : hasOnHoldPayment,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList(),
    'TotalNumberofResult' : totalNumberofResult
  };
}

class UserOrderModel {
  final int? id;
  final String? creationDate;
  final int? statusID;
  final OrderStatus? orderStatus;
  final String? salesOrderNumber;
  bool? isRated;
  final String? deliveryDate;
  final int? deliveryMethodId;
  final String? driverId;
  final String? deliveryTrackURL;
  final CustomerAddress? customerAddress;
  final bool? isScheduled;
  final String? brandImage;
  final String? brandName;
  final double? totalAmount;
  final List<OrderItems>? orderItems;
  final String? currencyAbbreviation;
  final String? orderReferenceId;

  UserOrderModel({
    this.id,
    this.creationDate,
    this.statusID,
    this.orderStatus,
    this.salesOrderNumber,
    this.isRated,
    this.deliveryDate,
    this.deliveryMethodId,
    this.driverId,
    this.deliveryTrackURL,
    this.customerAddress,
    this.isScheduled,
    this.brandImage,
    this.brandName,
    this.totalAmount,
    this.orderItems,
    this.currencyAbbreviation,
    this.orderReferenceId,
  });

  UserOrderModel.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        creationDate = json['CreationDate'] as String?,
        statusID = json['StatusID'] as int?,
        orderStatus = (json['OrderStatus'] as Map<String,dynamic>?) != null ? OrderStatus.fromJson(json['OrderStatus'] as Map<String,dynamic>) : null,
        salesOrderNumber = json['SalesOrderNumber'] as String?,
        isRated = json['IsRated'] as bool?,
        deliveryDate = json['DeliveryDate'] as String?,
        deliveryMethodId = json['DeliveryMethodId'] as int?,
        driverId = json['DriverId'] as String?,
        deliveryTrackURL = json['DeliveryTrackURL'] as String?,
        customerAddress = (json['CustomerAddress'] as Map<String,dynamic>?) != null ? CustomerAddress.fromJson(json['CustomerAddress'] as Map<String,dynamic>) : null,
        isScheduled = json['IsScheduled'] as bool?,
        brandImage = json['BrandImage'] as String?,
        brandName = json['BrandName'] as String?,
        totalAmount = json['TotalAmount'] as double?,
        orderItems = (json['OrderItems'] as List?)?.map((dynamic e) => OrderItems.fromJson(e as Map<String,dynamic>)).toList(),
        currencyAbbreviation = json['CurrencyAbbreviation'] as String?,
        orderReferenceId = json['OrderReferenceId'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'CreationDate' : creationDate,
    'StatusID' : statusID,
    'OrderStatus' : orderStatus?.toJson(),
    'SalesOrderNumber' : salesOrderNumber,
    'IsRated' : isRated,
    'DeliveryDate' : deliveryDate,
    'DeliveryMethodId' : deliveryMethodId,
    'DriverId' : driverId,
    'DeliveryTrackURL' : deliveryTrackURL,
    'CustomerAddress' : customerAddress?.toJson(),
    'IsScheduled' : isScheduled,
    'BrandImage' : brandImage,
    'BrandName' : brandName,
    'TotalAmount' : totalAmount,
    'OrderItems' : orderItems?.map((e) => e.toJson()).toList(),
    'CurrencyAbbreviation' : currencyAbbreviation,
    'OrderReferenceId' : orderReferenceId
  };
}

class OrderStatus {
  final int? id;
  final String? name;
  final String? description;
  final String? iconUrl;

  OrderStatus({
    this.id,
    this.name,
    this.description,
    this.iconUrl,
  });

  OrderStatus.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as int?,
        name = json['Name'] as String?,
        description = json['Description'] as String?,
        iconUrl = json['IconUrl'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'Description' : description,
    'IconUrl' : iconUrl
  };
}

class CustomerAddress {
  final String? name;
  final int? latitude;
  final int? longitude;
  final String? phone;
  final String? address;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final String? customerName;

  CustomerAddress({
    this.name,
    this.latitude,
    this.longitude,
    this.phone,
    this.address,
    this.buildingNumber,
    this.floor,
    this.apartment,
    this.customerName,
  });

  CustomerAddress.fromJson(Map<String, dynamic> json)
      : name = json['Name'] as String?,
        latitude = json['Latitude'] as int?,
        longitude = json['Longitude'] as int?,
        phone = json['Phone'] as String?,
        address = json['Address'] as String?,
        buildingNumber = json['BuildingNumber'] as String?,
        floor = json['Floor'] as String?,
        apartment = json['Apartment'] as String?,
        customerName = json['CustomerName'] as String?;

  Map<String, dynamic> toJson() => {
    'Name' : name,
    'Latitude' : latitude,
    'Longitude' : longitude,
    'Phone' : phone,
    'Address' : address,
    'BuildingNumber' : buildingNumber,
    'Floor' : floor,
    'Apartment' : apartment,
    'CustomerName' : customerName
  };
}

class OrderItems {
  final int? iD;
  final int? quantity;
  final String? name;
  final String? url;
  final int? price;
  final int? totalPrice;
  final int? totalPriceWithOptionItemsPrices;
  final String? currencyAbbreviation;
  final String? specialInstructions;
  final double? weight;
  final int? weightUnitId;
  final int? pricingTypes;
  final List<OrderItemOptions>? orderItemOptions;
  final List<ProductProperties>? productProperties;

  OrderItems({
    this.iD,
    this.quantity,
    this.name,
    this.url,
    this.price,
    this.totalPrice,
    this.totalPriceWithOptionItemsPrices,
    this.currencyAbbreviation,
    this.specialInstructions,
    this.weight,
    this.weightUnitId,
    this.pricingTypes,
    this.orderItemOptions,
    this.productProperties,
  });

  OrderItems.fromJson(Map<String, dynamic> json)
      : iD = json['ID'] as int?,
        quantity = json['Quantity'] as int?,
        name = json['Name'] as String?,
        url = json['Url'] as String?,
        price = json['Price'] as int?,
        totalPrice = json['TotalPrice'] as int?,
        totalPriceWithOptionItemsPrices = json['TotalPriceWithOptionItemsPrices'] as int?,
        currencyAbbreviation = json['CurrencyAbbreviation'] as String?,
        specialInstructions = json['SpecialInstructions'] as String?,
        weight = json['Weight'] as double?,
        weightUnitId = json['WeightUnitId'] as int?,
        pricingTypes = json['PricingTypes'] as int?,
        orderItemOptions = (json['OrderItemOptions'] as List?)?.map((dynamic e) => OrderItemOptions.fromJson(e as Map<String,dynamic>)).toList(),
        productProperties = (json['ProductProperties'] as List?)?.map((dynamic e) => ProductProperties.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'ID' : iD,
    'Quantity' : quantity,
    'Name' : name,
    'Url' : url,
    'Price' : price,
    'TotalPrice' : totalPrice,
    'TotalPriceWithOptionItemsPrices' : totalPriceWithOptionItemsPrices,
    'CurrencyAbbreviation' : currencyAbbreviation,
    'SpecialInstructions' : specialInstructions,
    'Weight' : weight,
    'WeightUnitId' : weightUnitId,
    'PricingTypes' : pricingTypes,
    'OrderItemOptions' : orderItemOptions?.map((e) => e.toJson()).toList(),
    'ProductProperties' : productProperties?.map((e) => e.toJson()).toList()
  };
}

class OrderItemOptions {
  final int? productOptionItemId;
  final int? quantity;
  final int? optionId;

  OrderItemOptions({
    this.productOptionItemId,
    this.quantity,
    this.optionId,
  });

  OrderItemOptions.fromJson(Map<String, dynamic> json)
      : productOptionItemId = json['ProductOptionItemId'] as int?,
        quantity = json['Quantity'] as int?,
        optionId = json['OptionId'] as int?;

  Map<String, dynamic> toJson() => {
    'ProductOptionItemId' : productOptionItemId,
    'Quantity' : quantity,
    'OptionId' : optionId
  };
}

class ProductProperties {
  final String? name;
  final String? value;
  final int? type;
  final String? imageUrl;
  final int? id;

  ProductProperties({
    this.name,
    this.value,
    this.type,
    this.imageUrl,
    this.id,
  });

  ProductProperties.fromJson(Map<String, dynamic> json)
      : name = json['Name'] as String?,
        value = json['Value'] as String?,
        type = json['Type'] as int?,
        imageUrl = json['ImageUrl'] as String?,
        id = json['Id'] as int?;

  Map<String, dynamic> toJson() => {
    'Name' : name,
    'Value' : value,
    'Type' : type,
    'ImageUrl' : imageUrl,
    'Id' : id
  };
}
