class OrderDetails {
  final dynamic id;
  final dynamic status;
  final OrderStatus? orderStatus;
  final dynamic totalAmount;
  final dynamic subTotalAmount;
  final dynamic tax;
  final double? discount;
  final dynamic nonExclusiveTaxRatio;
  final dynamic nonExclusiveTaxAmount;
  final bool? isRated;
  final dynamic deliveryFees;
  final dynamic deliveryFeesOfferPrice;
  final bool? isScheduled;
  final String? salesOrderNumber;
  final dynamic discountAmount;
  final dynamic brandDiscount;
  final String? specialInstructions;
  final String? creationDate;
  final String? deliveryDate;
  final dynamic taxAmount;
  final String? currencyAbbreviation;
  final String? promotionCode;
  final dynamic redemptionAmount;
  final String? deliveryTrackURL;
  final String? driverId;
  final String? dookAuthorizationToken;
  final OrderBranchDetails? orderBranchDetails;
  final CustomerAddress? customerAddress;
  final List<OrderItems>? orderItems;
  final dynamic deliveryMethodId;
  final String? deliveryMethod;
  final bool? isSucceeded;
  final List<Errors>? errors;
  final String? expectedDeliveryDate;
  final dynamic totalDiscountAmount;
  final dynamic paymentType;
  final GiftDetails? giftDetails;

  OrderDetails({
    this.id,
    this.status,
    this.orderStatus,
    this.totalAmount,
    this.subTotalAmount,
    this.tax,
    this.discount,
    this.nonExclusiveTaxRatio,
    this.nonExclusiveTaxAmount,
    this.isRated,
    this.deliveryFees,
    this.deliveryFeesOfferPrice,
    this.isScheduled,
    this.salesOrderNumber,
    this.discountAmount,
    this.brandDiscount,
    this.specialInstructions,
    this.creationDate,
    this.deliveryDate,
    this.taxAmount,
    this.currencyAbbreviation,
    this.promotionCode,
    this.redemptionAmount,
    this.deliveryTrackURL,
    this.driverId,
    this.dookAuthorizationToken,
    this.orderBranchDetails,
    this.customerAddress,
    this.orderItems,
    this.deliveryMethodId,
    this.deliveryMethod,
    this.isSucceeded,
    this.errors,
    this.expectedDeliveryDate,
    this.totalDiscountAmount,
    this.paymentType,
    this.giftDetails,
  });

  OrderDetails.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as dynamic,
        status = json['Status'] as dynamic,
        orderStatus = (json['OrderStatus'] as Map<String,dynamic>?) != null ? OrderStatus.fromJson(json['OrderStatus'] as Map<String,dynamic>) : null,
        totalAmount = json['TotalAmount'] as dynamic,
        subTotalAmount = json['SubTotalAmount'] as dynamic,
        tax = json['Tax'] as dynamic,
        discount = json['Discount'] ,
        nonExclusiveTaxRatio = json['NonExclusiveTaxRatio'] as dynamic,
        nonExclusiveTaxAmount = json['NonExclusiveTaxAmount'] as dynamic,
        isRated = json['IsRated'] as bool?,
        deliveryFees = json['DeliveryFees'] as dynamic,
        deliveryFeesOfferPrice = json['DeliveryFeesOfferPrice'] as dynamic,
        isScheduled = json['IsScheduled'] as bool?,
        salesOrderNumber = json['SalesOrderNumber'] as String?,
        discountAmount = json['DiscountAmount'] as dynamic,
        brandDiscount = json['BrandDiscount'] as dynamic,
        specialInstructions = json['SpecialInstructions'] as String?,
        creationDate = json['CreationDate'] as String?,
        deliveryDate = json['DeliveryDate'] as String?,
        taxAmount = json['TaxAmount'] as dynamic,
        currencyAbbreviation = json['CurrencyAbbreviation'] as String?,
        promotionCode = json['PromotionCode'] as String?,
        redemptionAmount = json['RedemptionAmount'] as dynamic,
        deliveryTrackURL = json['DeliveryTrackURL'] as String?,
        driverId = json['DriverId'] as String?,
        dookAuthorizationToken = json['DookAuthorizationToken'] as String?,
        orderBranchDetails = (json['OrderBranchDetails'] as Map<String,dynamic>?) != null ? OrderBranchDetails.fromJson(json['OrderBranchDetails'] as Map<String,dynamic>) : null,
        customerAddress = (json['CustomerAddress'] as Map<String,dynamic>?) != null ? CustomerAddress.fromJson(json['CustomerAddress'] as Map<String,dynamic>) : null,
        orderItems = (json['OrderItems'] as List?)?.map((dynamic e) => OrderItems.fromJson(e as Map<String,dynamic>)).toList(),
        deliveryMethodId = json['DeliveryMethodId'] as dynamic,
        deliveryMethod = json['DeliveryMethod'] as String?,
        isSucceeded = json['IsSucceeded'] as bool?,
        errors = (json['Errors'] as List?)?.map((dynamic e) => Errors.fromJson(e as Map<String,dynamic>)).toList(),
        expectedDeliveryDate = json['ExpectedDeliveryDate'] as String?,
        totalDiscountAmount = json['TotalDiscountAmount'] as dynamic,
        paymentType = json['PaymentType'] as dynamic,
        giftDetails = (json['GiftDetails'] as Map<String,dynamic>?) != null ? GiftDetails.fromJson(json['GiftDetails'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Status' : status,
    'OrderStatus' : orderStatus?.toJson(),
    'TotalAmount' : totalAmount,
    'SubTotalAmount' : subTotalAmount,
    'Tax' : tax,
    'Discount' : discount,
    'NonExclusiveTaxRatio' : nonExclusiveTaxRatio,
    'NonExclusiveTaxAmount' : nonExclusiveTaxAmount,
    'IsRated' : isRated,
    'DeliveryFees' : deliveryFees,
    'DeliveryFeesOfferPrice' : deliveryFeesOfferPrice,
    'IsScheduled' : isScheduled,
    'SalesOrderNumber' : salesOrderNumber,
    'DiscountAmount' : discountAmount,
    'BrandDiscount' : brandDiscount,
    'SpecialInstructions' : specialInstructions,
    'CreationDate' : creationDate,
    'DeliveryDate' : deliveryDate,
    'TaxAmount' : taxAmount,
    'CurrencyAbbreviation' : currencyAbbreviation,
    'PromotionCode' : promotionCode,
    'RedemptionAmount' : redemptionAmount,
    'DeliveryTrackURL' : deliveryTrackURL,
    'DriverId' : driverId,
    'DookAuthorizationToken' : dookAuthorizationToken,
    'OrderBranchDetails' : orderBranchDetails?.toJson(),
    'CustomerAddress' : customerAddress?.toJson(),
    'OrderItems' : orderItems?.map((e) => e.toJson()).toList(),
    'DeliveryMethodId' : deliveryMethodId,
    'DeliveryMethod' : deliveryMethod,
    'IsSucceeded' : isSucceeded,
    'Errors' : errors?.map((e) => e.toJson()).toList(),
    'ExpectedDeliveryDate' : expectedDeliveryDate,
    'TotalDiscountAmount' : totalDiscountAmount,
    'PaymentType' : paymentType,
    'GiftDetails' : giftDetails?.toJson()
  };
}

class OrderStatus {
  final dynamic id;
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
      : id = json['Id'] as dynamic,
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

class OrderBranchDetails {
  final dynamic id;
  final String? name;
  final dynamic latitude;
  final dynamic longitude;
  final String? phone;

  OrderBranchDetails({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.phone,
  });

  OrderBranchDetails.fromJson(Map<String, dynamic> json)
      : id = json['Id'] as dynamic,
        name = json['Name'] as String?,
        latitude = json['Latitude'] as dynamic,
        longitude = json['Longitude'] as dynamic,
        phone = json['Phone'] as String?;

  Map<String, dynamic> toJson() => {
    'Id' : id,
    'Name' : name,
    'Latitude' : latitude,
    'Longitude' : longitude,
    'Phone' : phone
  };
}

class CustomerAddress {
  final String? name;
  final dynamic latitude;
  final dynamic longitude;
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
        latitude = json['Latitude'] as dynamic,
        longitude = json['Longitude'] as dynamic,
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
  final dynamic iD;
  final dynamic quantity;
  final dynamic brandId;
  final String? brandName;
  final String? name;
  final String? url;
  final dynamic price;
  final dynamic offerPrice;
  final String? label;
  final dynamic totalPrice;
  final String? size;
  final dynamic totalPriceWithOptionItemsPrices;
  final dynamic noneOfferTotalPrice;
  final String? specialInstructions;
  final double? weight;
  final dynamic weightUnitId;
  final dynamic pricingTypes;
  final List<OrderItemOptions>? orderItemOptions;
  final List<ProductProperties>? productProperties;
  final String? receiverMobileNumber;
  final String? deliveryDate;
  final bool? isFree;

  OrderItems({
    this.iD,
    this.quantity,
    this.brandId,
    this.brandName,
    this.name,
    this.url,
    this.price,
    this.offerPrice,
    this.label,
    this.totalPrice,
    this.size,
    this.totalPriceWithOptionItemsPrices,
    this.noneOfferTotalPrice,
    this.specialInstructions,
    this.weight,
    this.weightUnitId,
    this.pricingTypes,
    this.orderItemOptions,
    this.productProperties,
    this.receiverMobileNumber,
    this.deliveryDate,
    this.isFree,
  });

  OrderItems.fromJson(Map<String, dynamic> json)
      : iD = json['ID'] as dynamic,
        quantity = json['Quantity'] as dynamic,
        brandId = json['BrandId'] as dynamic,
        brandName = json['BrandName'] as String?,
        name = json['Name'] as String?,
        url = json['Url'] as String?,
        price = json['Price'] as dynamic,
        offerPrice = json['OfferPrice'] as dynamic,
        label = json['Label'] as String?,
        totalPrice = json['TotalPrice'] as dynamic,
        size = json['Size'] as String?,
        totalPriceWithOptionItemsPrices = json['TotalPriceWithOptionItemsPrices'] as dynamic,
        noneOfferTotalPrice = json['NoneOfferTotalPrice'] as dynamic,
        specialInstructions = json['SpecialInstructions'] as String?,
        weight = json['Weight'] as double?,
        weightUnitId = json['WeightUnitId'] as dynamic,
        pricingTypes = json['PricingTypes'] as dynamic,
        orderItemOptions = (json['OrderItemOptions'] as List?)?.map((dynamic e) => OrderItemOptions.fromJson(e as Map<String,dynamic>)).toList(),
        productProperties = (json['ProductProperties'] as List?)?.map((dynamic e) => ProductProperties.fromJson(e as Map<String,dynamic>)).toList(),
        receiverMobileNumber = json['ReceiverMobileNumber'] as String?,
        deliveryDate = json['DeliveryDate'] as String?,
        isFree = json['IsFree'] as bool?;

  Map<String, dynamic> toJson() => {
    'ID' : iD,
    'Quantity' : quantity,
    'BrandId' : brandId,
    'BrandName' : brandName,
    'Name' : name,
    'Url' : url,
    'Price' : price,
    'OfferPrice' : offerPrice,
    'Label' : label,
    'TotalPrice' : totalPrice,
    'Size' : size,
    'TotalPriceWithOptionItemsPrices' : totalPriceWithOptionItemsPrices,
    'NoneOfferTotalPrice' : noneOfferTotalPrice,
    'SpecialInstructions' : specialInstructions,
    'Weight' : weight,
    'WeightUnitId' : weightUnitId,
    'PricingTypes' : pricingTypes,
    'OrderItemOptions' : orderItemOptions?.map((e) => e.toJson()).toList(),
    'ProductProperties' : productProperties?.map((e) => e.toJson()).toList(),
    'ReceiverMobileNumber' : receiverMobileNumber,
    'DeliveryDate' : deliveryDate,
    'IsFree' : isFree
  };
}

class OrderItemOptions {
  final dynamic iD;
  final dynamic quantity;
  final String? name;
  final dynamic unitPrice;
  final dynamic totalPrice;

  OrderItemOptions({
    this.iD,
    this.quantity,
    this.name,
    this.unitPrice,
    this.totalPrice,
  });

  OrderItemOptions.fromJson(Map<String, dynamic> json)
      : iD = json['ID'] as dynamic,
        quantity = json['Quantity'] as dynamic,
        name = json['Name'] as String?,
        unitPrice = json['UnitPrice'] as dynamic,
        totalPrice = json['TotalPrice'] as dynamic;

  Map<String, dynamic> toJson() => {
    'ID' : iD,
    'Quantity' : quantity,
    'Name' : name,
    'UnitPrice' : unitPrice,
    'TotalPrice' : totalPrice
  };
}

class ProductProperties {
  final String? name;
  final String? value;
  final dynamic type;
  final String? imageUrl;
  final dynamic id;

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
        type = json['Type'] as dynamic,
        imageUrl = json['ImageUrl'] as String?,
        id = json['Id'] as dynamic;

  Map<String, dynamic> toJson() => {
    'Name' : name,
    'Value' : value,
    'Type' : type,
    'ImageUrl' : imageUrl,
    'Id' : id
  };
}

class Errors {
  final dynamic errorCode;
  final String? errorMessage;

  Errors({
    this.errorCode,
    this.errorMessage,
  });

  Errors.fromJson(Map<String, dynamic> json)
      : errorCode = json['ErrorCode'] as dynamic,
        errorMessage = json['ErrorMessage'] as String?;

  Map<String, dynamic> toJson() => {
    'ErrorCode' : errorCode,
    'ErrorMessage' : errorMessage
  };
}

class GiftDetails {
  final String? giftReceiverMobile;
  final String? giftNote;

  GiftDetails({
    this.giftReceiverMobile,
    this.giftNote,
  });

  GiftDetails.fromJson(Map<String, dynamic> json)
      : giftReceiverMobile = json['GiftReceiverMobile'] as String?,
        giftNote = json['GiftNote'] as String?;

  Map<String, dynamic> toJson() => {
    'GiftReceiverMobile' : giftReceiverMobile,
    'GiftNote' : giftNote
  };
}