import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Marouf/models/slider_model.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import '../../models/home_model.dart';
import '../../utils/constant/assets_constant.dart';
import '../../utils/navigation.dart';
import '../screens/categry_products_screen.dart';
import '../screens/product_screen.dart';

class SliderAdsWidget extends StatefulWidget {
  const SliderAdsWidget(this.isLoading, {Key? key, required this.slides})
      : super(key: key);
  final bool isLoading;
  final List<HomeSliders> slides;

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<SliderAdsWidget> {
  int _current = 0;
  bool isStart = false;
  final CarouselController _controller = CarouselController();

  List<Widget> imageSliders() {
    return widget.slides
        .map((item) => GestureDetector(
      onTap: () {
        log(item.toJson().toString());
        if (item.productItemId != null && item.hasProduct!) {
          Get.bottomSheet(
              FractionallySizedBox(
                heightFactor: .955,
                child: ProductScreen(item.productItemId!),
              ),
              isScrollControlled: true,
              backgroundColor: Colors.white,
              barrierColor: AppTheme.colorAccent);
        } else if (item.categoryId != null) {
          List<RootCategories> brandCategories = [
            RootCategories(
              id: item.categoryId,
            )
          ];
          bool? hasSubCategories = item.hasSubCategory;
          NavigationApp.to(
            CategoryProductsScreen(
                tag: 'subCategory#${item.categoryId}',
                hasSubCategories: hasSubCategories,
                brandCategories: brandCategories,
                productModuleId: item.categoryId,
                productModuleType: 23,
                selectedCategory: RootCategories(
                  id: item.categoryId,
                )),
          );
          // Get.toNamed(item.url);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                item.imageUrl!,
              ),
              fit: BoxFit.cover,
            )),
        child: Image.network(
          item.imageUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return Image.asset(
              AssetsConstant.loading,
              fit: BoxFit.cover,
              width: Get.height,
            );
          },
          width: Get.width,
        ),
      ),
    ))
        .toList();
  }

  List<Widget> loadings() {
    return [
      Image.asset(
        AssetsConstant.loading,
        fit: BoxFit.cover,
        width: Get.height,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .25,
      child: Column(children: [
        Expanded(
          child: CarouselSlider(

            items: widget.isLoading ? loadings() : imageSliders(),
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                padEnds: true,
                viewportFraction: 1,
                height: 400,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                    isStart = true;
                  });
                  Future.delayed(Duration(milliseconds: 100), () {
                    setState(() {
                      isStart = false;
                    });
                  });
                }),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.slides.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _current == entry.key ? 40.0 : 15,
                height: 6.0,
                margin:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppTheme.colorPrimaryTrans),
                child: _current == entry.key
                    ? Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppTheme.colorPrimary,
                      ),
                      height: 6.0,
                      width: isStart ? 15 : 40.0,
                    ),
                  ],
                )
                    : Container(),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
