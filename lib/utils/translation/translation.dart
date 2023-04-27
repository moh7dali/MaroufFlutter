import 'package:Marouf/utils/translation/ar.dart';
import 'package:Marouf/utils/translation/en.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'ar': ar,
  };
}
