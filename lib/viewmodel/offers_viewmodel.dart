import 'dart:convert';
import 'dart:developer';

import 'package:Marouf/models/offers_model.dart';
import 'package:get/get.dart';

import '../http/api_urls.dart';
import '../http/http_client.dart';

class OffersViewModel extends GetxController{
  OffersModel? offerModels;
  List<ClassificationsProduct>? classificationsProduct;
  bool isLoad=true;
  @override
  void onInit() {
    getOffers();
    super.onInit();
  }
  Future getOffers()async{
    await HttpClientApp().request(
      method: 'GET',
      url: APIUrls.getOffers,
      body: {},
      files: {},
    ).then((response) async {
      offerModels=OffersModel.fromJson(json.decode(response));
      classificationsProduct=OffersModel.fromJson(json.decode(response)).classificationsProduct;
    });
    isLoad=false;
    update();
  }
}