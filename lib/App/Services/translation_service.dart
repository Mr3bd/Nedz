import 'dart:ui';
import 'package:neds/App/Utilities/Lang/ar.dart';
import 'package:neds/App/Utilities/Lang/en.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TranslationService extends Translations {
  GetStorage localStorage = GetStorage();

  static final locale = const Locale('en', 'US');

  static final fallbackLocale = const Locale('en', 'US');

  static final langs = [
    'ar_SA',
    'en_US',
  ];

  static final locales = [
    const Locale('ar', 'SA'),
    const Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'ar_SA': ar,
        'en_US': en,
      };

  void changeLocale(String lang) async {
    if (lang == langs[0]) {
      Get.updateLocale(locales[0]);
      await localStorage.write('language', 'ar_SA');
    } else {
      Get.updateLocale(locales[1]);
      await localStorage.write('language', 'en_US');
    }
  }

  Locale getLocale() {
    String? currentLocale = localStorage.read('language');
    if (currentLocale == null || currentLocale == 'en_US') return locales[1];

    return locales[0];
  }

  bool isLocaleArabic() {
    return Get.locale == const Locale('ar', 'SA');
  }
}
