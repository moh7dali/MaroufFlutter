import 'package:flutter/foundation.dart';

class APIUrls {
  // main urls
  static const String production = 'https://maroufcoffee.lazordclub.com/Maroufcoffee.WebAPI/';
  static const String staging = 'https://staging.lazordclub.com/MaroufCoffee.WebAPI/';
  static const String baseUrl = staging;
  // static const String baseUrl = kDebugMode ? staging : production;
  static const String apiUrl = '${baseUrl}api/';

  //endPoints
  static const String verifyMobileNumber =
      '${apiUrl}Profile/VerifyMobileNumber';
  static const String checkValidationCode =
      '${apiUrl}Profile/CheckValidationCode?verificationCode=';
  static const String updateProfile = '${apiUrl}Profile/UpdateProfile';
  static const String referralCode = '${apiUrl}Profile/AddReferralCode';
  static const String refreshToken = '${apiUrl}Security/RefreshToken';
  static const String login = '${apiUrl}Security/Login';
  static const String deleteAccount = '${apiUrl}Profile/DeleteAccount';
  static const String getSingleCategory = '${apiUrl}Product/GetProductAllData';
  static const String dealWeek = '${apiUrl}Product/GetProductsByProperties';
  static const String productDetails =
      '${apiUrl}Product/GetProductDetailsWithRelatedProduct';
  static const String numberUnread =
      '${apiUrl}Notification/GetNumberofUnreadNotification';
  static const String getUserCode = '${apiUrl}Profile/GetUserCode';
  static const String getSliderItems = '${apiUrl}Product/GetSliderItems';
  static const String getBrand =
      '${apiUrl}Category/GetBrandCategories?brandId=1&pageNumber=1';
  static const String getBranches = '${apiUrl}Branch/GetBranches';
  static const String getSubCategory = '${apiUrl}Category/GetSubCategories';
  static const String getPaymentStatus =
      '${apiUrl}Payment/CheckOrderPaymentStatus';
  static const String logPaymentFailure = '${apiUrl}Payment/LogPaymentFailure';
  static const String getProductByCategory =
      '${apiUrl}Product/GetCategoryItemsByCity';
  static const String cancelOrderPayment =
      '${apiUrl}Payment/CancelOrderPayment';
  static const String getInviteUrl =
      '${apiUrl}Common/GetSystemResource?resourceGroup=2';
  static const String contactInfo = '${apiUrl}Common/GetContactInfo';
  static const String getUserCurrentPoints =
      '${apiUrl}Profile/GetUserLoyaltyData';
  static const String transferCustomerBalance =
      '${apiUrl}Profile/TransferCustomerBalance';
  static const String sendContactMessage = '${apiUrl}Common/SendContactMessage';
  static const String reOrder = '${apiUrl}Order/GetReorderDetails';
  static const String profileData = '${apiUrl}Profile/GetProfileData';
  static const String getUserAddresses = '${apiUrl}Order/GetUserAddresses';
  static const String addNewAddress = '${apiUrl}Order/AddNewCustomerAddress';
  static const String getCities = '${apiUrl}Common/GetCitiesByCountryId';
  static const String addAddress = '${apiUrl}Order/AddNewCustomerAddress';
  static const String updateAddress = '${apiUrl}Order/UpdateCustomerAddress';
  static const String deleteAddress = '${apiUrl}Order/DeleteCustomerAddress';
  static const String rewardGift = '${apiUrl}Reward/RedeemReward';
  static const String getNotification =
      '${apiUrl}Notification/GetUserNotifications';
  static const String readNotification =
      '${apiUrl}Notification/UpdateSubscriberNotificationStatus?notificationIds=';
  static const String getMyRewards = '${apiUrl}Reward/GetRewards';
  static const String checkPromo = '${apiUrl}Order/CheckPromotionCode';
  static const String getApplicationVersion =
      '${apiUrl}Common/GetApplicationVersion';
  static const String orderSetup = '${apiUrl}Order/GetOrderSetupData';
  static const String getUserLoyalty = '${apiUrl}Profile/GetUserLoyaltyData';
  static const String getUserBalanceHistory =
      '${apiUrl}Profile/GetUserBalanceHistory';
  static const String getRedemptionRewards =
      '${apiUrl}Reward/GetRedemptionRewards';
  static const String addOrder = '${apiUrl}Order/AddOrder';
  static const String userOrders = '${apiUrl}Order/GetUserOrders';
  static const String orderDetails =
      '${apiUrl}Order/GetOrderWithItemOptionsDetails';
  static const String rateOrder = '${apiUrl}Order/RateOrder';
  static const String searchForProducts = '${apiUrl}Product/SearchForProduct';
  static const String tradeMarkFilters = '${apiUrl}Product/GetAllTrademarks?pageNumber=';
  static const String getClosestBranches = '${apiUrl}Branch/GetClosestBranches';
  static const String getBranchDetails = '${apiUrl}Branch/GetBranchDetails';
  static const String getBarcodeUserData =
      '${apiUrl}Profile/GetBarcodeUserData';
  static const String getAlsoPeopleAdded =
      '${apiUrl}Product/GetAlsoPeopleAddedItems';
  static const String getTradeMarkProducts =
      '${apiUrl}Product/GetTradeMarkProducts';
  static const String getDeliveryFee =
      '${apiUrl}Order/GetDeliveryFeesByAddress';
  static const String checkInBranch = '${apiUrl}Branch/CheckInUser?branchId=';
  static const String getAreas = '${apiUrl}Common/GetDeliveryAreas';
  static const String changeLanguage = '${apiUrl}Profile/UpdateLanguage';
  static const String getAdvertising = '${apiUrl}Campaign/GetAdvertizing';
  static const String getOffers = '${apiUrl}Brand/GetHomeDetails?merchantId=1&apiVersion=4';
  static const String getOffersInfo = '${apiUrl}Brand/GetClassificationsProducts';
  static const String orderAvailableTime =
      '${apiUrl}Order/GetOrderAvailableTimes?brandId=1';
  static const String rateVisit = '${apiUrl}Branch/RateUs';
  static const String readAllNotifications =
      '${apiUrl}Notification/ReadAllUserNotifications';
  static const String updateNotificationToken =
      '${apiUrl}Notification/UpdateNotificationToken?updateNotificationToken=';
}
