import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Marouf/models/cart_model.dart';
import 'package:Marouf/models/home_model.dart';
import 'package:Marouf/utils/constant/shared_preferences_constant.dart';
import 'package:Marouf/utils/device_info.dart';
import 'package:Marouf/utils/gms_hms_service.dart';
import 'package:Marouf/utils/one_signal_config.dart';
import 'package:Marouf/utils/theme/app_theme.dart';
import 'package:Marouf/utils/translation/translation.dart';
import 'package:Marouf/view/screens/main_screen.dart';
import 'package:Marouf/view/screens/referral_screen.dart';
import 'package:Marouf/view/screens/splash_screen.dart';
import 'package:Marouf/view/widgets/animated_shake_widget.dart';

import 'view/screens/connection_failed_screen.dart';

bool fromNotification = false;
String appLanguage = 'ar';
String LauncherAppLanguage = 'ar';
String accessToken = '';
String _token = '';
String currentRout = '';
bool isHmsAvailable = false;
bool isGmsAvailable = false;
ValueNotifier<List<RootCategories>> categoriesStack = ValueNotifier([]);
ValueNotifier<List<List<RootCategories>>> brandsCategoriesStack =
    ValueNotifier([]);
ValueNotifier<List<CartItem>> cartList = ValueNotifier([]);
final cartKey = GlobalKey<ShakeWidgetState>();
String stoppingOrderMessage = '';
bool canOrder = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();

  print('SessionTokenSessionToken: ${prefs.getKeys()}');
  OneSignalConfig().getOneSignalConfig();
  if (Platform.isIOS) {
    checkIOSUserDefault();
  } else {
     checkAndroidPreferences();
  }
  DeviceInfo deviceInfo = DeviceInfo();
  String s = Get.deviceLocale!.languageCode;
  appLanguage = prefs.getString(SharedPreferencesKey.appLang) ?? s;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          AppTheme.colorPrimaryDark, //or set color with: Color(0xFF0000FF)
    ));
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, ch) {
          return GetMaterialApp(
            title: 'appName'.tr,
            debugShowCheckedModeBanner: false,
            locale: Locale(appLanguage),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            fallbackLocale: Locale(appLanguage),
            theme: AppTheme.lightTheme,
            translations: Translation(),
            home: const SplashScreen(),
            routes: {
              '/main': (context) => MainScreen(),
              '/referral': (context) => const ReferralScreen(),
              '/noInternet': (context) => const ConnectionFailedScreen(),
            },
          );
        },
      ),
    );
  }
}

Future checkHmsGms() async {
  if (Platform.isAndroid) {
    isHmsAvailable = await GoogleHuaweiService().isHMS();
    isGmsAvailable = await GoogleHuaweiService().isGMS();
    print('isHmsAvailable: $isHmsAvailable');
    print('isGmsAvailable: $isGmsAvailable');
  } else {
    isHmsAvailable = false;
    isGmsAvailable = true;
  }
}

checkIOSUserDefault() async {
  SharedPreferences.getInstance().then((value) async {
    print('SessionTokenSessionToken: ${value.containsKey(SharedPreferencesKey.sessionToken)}');
    const MethodChannel preefs =
    MethodChannel('com.mozaic.www.maroufcoffee/userDefault');
    bool hasKey = await preefs.invokeMethod('HasKeys');
    print('HasKeys : $hasKey');
    if (value.containsKey(SharedPreferencesKey.sessionToken)) {

      try {

        if (hasKey) {
          String? sessionToken = await preefs.invokeMethod('SessionToken');
          print('SessionToken : $sessionToken');
          String? accessToken = await preefs.invokeMethod('Authorization');
          print('Authorization : $accessToken');
          String? mobile = await preefs.invokeMethod('MobileNumber');
          print('MobileNumber : $mobile');
          bool? isCompleted = await preefs.invokeMethod('IsCompleted');
          print('IsCompleted : $isCompleted');
          bool? hasReferral = await preefs.invokeMethod('HasReferral');
          print('HasReferral : $hasReferral');
          if (sessionToken != null) {
            value.setString(SharedPreferencesKey.sessionToken, sessionToken);
            value.setString(SharedPreferencesKey.mobileNumber, mobile!);
            value.setString(SharedPreferencesKey.accessToken, accessToken!);
            value.setBool(SharedPreferencesKey.hasReferral, hasReferral!);
            value.setBool(SharedPreferencesKey.isComplete, isCompleted!);
            value.setBool(
                SharedPreferencesKey.isSuccessLogin, sessionToken.isNotEmpty);
          }
        }
      } on PlatformException {
        print('Failed to get _isHmsAvailable.');
      }
    }
  });
}


Future checkAndroidPreferences() async {
  SharedPreferences.getInstance().then((value) async {
    const MethodChannel preefs =
    MethodChannel('com.mozaic.www.maroufcoffee/sharedPreference');
    if(!value.containsKey(SharedPreferencesKey.sessionToken)){
      try {
        bool hasKey = await preefs.invokeMethod('HasKeys');
        print( 'HasKeys : $hasKey');
        if(hasKey){
          String sessionToken = await preefs.invokeMethod('SessionToken');
          print('SessionToken : $sessionToken');
          String accessToken = await preefs.invokeMethod('Authorization');
          print(
              'Authorization : ${accessToken.toString().replaceAll('bearer ', '')}');
          String mobile = await preefs.invokeMethod('MobileNumber');
          print('MobileNumber : $mobile');
          bool isCompleted = await preefs.invokeMethod('IsCompleted');
          print('IsCompleted : $isCompleted');
          bool hasReferral = await preefs.invokeMethod('HasReferral');
          print('HasReferral : $hasReferral');
          value.setString(SharedPreferencesKey.sessionToken, sessionToken);
          value.setString(SharedPreferencesKey.mobileNumber, mobile);
          value.setString(SharedPreferencesKey.accessToken,
              accessToken.toString().replaceAll('bearer ', ''));
          value.setBool(SharedPreferencesKey.hasReferral, hasReferral);
          value.setBool(SharedPreferencesKey.isComplete, isCompleted);
          value.setBool(
              SharedPreferencesKey.isSuccessLogin, sessionToken.isNotEmpty);
        }
      } on PlatformException {
        print('Failed to get _isHmsAvailable.');

      }
    }
  });
}
openLocationSetting() async {
  if (Platform.isIOS) {
    const MethodChannel preefs =
    MethodChannel('com.mozaic.www.maroufcoffee/openLocationSetting');
    try {
      await preefs.invokeMethod('openLocationSetting');
    } on PlatformException {
      print('Failed to openLocationSetting.');
    }
  } else {
    //
    Geolocator.getCurrentPosition().then((value) async {
      if (!await Geolocator.isLocationServiceEnabled()) {
        Geolocator.openLocationSettings();
      }
    });
  }
}

