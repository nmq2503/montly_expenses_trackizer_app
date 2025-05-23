import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackizer/features/auth/bindings/sign_in_binding.dart';
import 'package:trackizer/features/auth/bindings/sign_up_binding.dart';
import 'package:trackizer/features/auth/views/sign_in_view.dart';
import 'package:trackizer/features/auth/views/sign_up_view.dart';
import 'package:trackizer/features/auth/views/social_login.dart';
import 'package:trackizer/features/settings/views/settings_view.dart';
import 'package:trackizer/features/splash/views/splash_screen.dart';

import '../features/main_tab/main_tab_view.dart';
import '../features/settings/bindings/settings_view_binding.dart';
import '../features/splash/splash_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      curve: Curves.easeInOut,
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInView(),
      // transition: Transition.fadeIn, 
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 400),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpView(),
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 400),
      binding: SignUpBinding(),

    ),
    GetPage(
      name: AppRoutes.socialLogin,
      page: () => const SocialLoginView(),
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: AppRoutes.mainTab,
      page: () => const MainTabView(),
      // transition: Transition.fadeIn,
      curve: Curves.easeInOut,
    ),
    GetPage(
      name: AppRoutes.settingsView,
      page: () => const SettingsView(),
      // transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      binding: SettingsViewBinding(),
    ),
  ];
}