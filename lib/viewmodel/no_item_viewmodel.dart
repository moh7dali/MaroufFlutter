import 'package:get/get.dart';

class NoItemViewModel extends GetxController{

  bool isNoItemAnimate=false;

  @override
  void onInit() {

    isNoItemAnimate=false;
    update();
    Future.delayed(const Duration(milliseconds: 100), () {
      isNoItemAnimate=true;
      update();
    },);
    update();
    super.onInit();
  }

}