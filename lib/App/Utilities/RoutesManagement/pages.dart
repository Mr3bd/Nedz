import 'package:neds/App/Modules/Dashboard/binding/dashboard_binding.dart';
import 'package:neds/App/Modules/Dashboard/view/dashboard_view.dart';

import 'package:neds/App/Modules/SignIn/binding/signin_binding.dart';
import 'package:neds/App/Modules/SignIn/view/signin_view.dart';
import 'package:neds/App/Modules/Splash/binding/splash_binding.dart';
import 'package:neds/App/Modules/Splash/view/splash_view.dart';
import 'package:get/get.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.SIGN_IN,
        page: () => SignInView(),
        binding: SignInBinding()),
    GetPage(
        name: Routes.DASHBOARD,
        page: () => DashboardView(),
        binding: DashboardBinding()),
    // GetPage(
    //     name: Routes.LANGUAGE,
    //     page: () => LanguageView(),
    //     binding: LanguageBinding()),
  ];
}
