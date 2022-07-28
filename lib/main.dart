import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neds/App/Modules/Splash/binding/splash_binding.dart';
import 'package:neds/App/Modules/Splash/view/splash_view.dart';
import 'package:neds/App/Services/settings_service.dart';
import 'package:neds/App/Services/translation_service.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';
import 'package:neds/App/Utilities/RoutesManagement/pages.dart';

GetStorage? localBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Icon(
              Icons.error,
              color: AppColors.red,
            ),
            const SizedBox(height: 20),
            Text(
              details.exception.toString(),
              style: Get.textTheme.headline5,
              maxLines: 5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  };
  await Get.putAsync(() => SettingsService().init());

  SplashBinding().dependencies();

  await GetStorage.init();
  localBox = GetStorage();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      showPerformanceOverlay: false,
      title: 'title'.tr,
      home: SplashView(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      getPages: AppPages.routes,
      translations: TranslationService(),
      locale: TranslationService().getLocale(),
      fallbackLocale: TranslationService.fallbackLocale,
      theme: Get.find<SettingsService>().getLightTheme(),
    );
  }
}
