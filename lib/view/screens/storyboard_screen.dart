import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:Marouf/utils/constant/assets_constant.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/view/widgets/walkthrough_widget.dart';

import 'signin_screen.dart';

class StoryBoardScreen extends StatelessWidget {
  final List<OnbordingData> list = [
    OnbordingData(
      image: AssetImage(AssetsConstant.firstStory),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'firstStTxt'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.secondStory),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard2_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.thirdStory),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard3_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.fourthStory),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard4_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.fifthStory),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard5_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
  ];
  final List<OnbordingData> listIOS = [
    OnbordingData(
      image: AssetImage(AssetsConstant.firstStoryIOS),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'firstStTxt'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.secondStoryIOS),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard2_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.thirdStoryIOS),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard3_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.fourthStoryIOS),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard4_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
    OnbordingData(
      image: AssetImage(AssetsConstant.fifthStoryIOS),
      fit: BoxFit.contain,
      imageWidth: 300,
      descText: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'storyBoard5_st'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      descPadding: EdgeInsets.symmetric(horizontal: 22.0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      onbordingDataList: Platform.isIOS?listIOS: list,
      colors: [],
      pageRoute: SigninScreen(),
      lastButton: CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      nextButton: CircleAvatar(
        backgroundColor: AppTheme.colorPrimaryDark,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      skipButton: Text(
        "skip".tr,
        style: TextStyle(
          color: Colors.purple,
        ),
      ),
      selectedDotColor: AppTheme.colorPrimaryDark,
      unSelectdDotColor: Colors.grey,
    );
  }
}
