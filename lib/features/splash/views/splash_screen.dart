import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trackizer/features/splash/controllers/splash_controller.dart';
import 'package:trackizer/routes/app_routes.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/primary_button.dart';
import '../../../common_widget/secondary_boutton.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Obx(
            () => AnimatedOpacity(
              opacity: controller.opacity.value,
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              child: Image.asset(
                "assets/img/welcome_screen.png",
                width: media.width,
                height: media.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Obx(
                () => controller.opacity.value == 1.0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/img/app_logo.png",
                            width: media.width * 0.5,
                            fit: BoxFit.contain,
                          ),
                          const Spacer(),
                          Text(
                            "Welcome to Trackizer",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: TColor.white, fontSize: 14),
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            title: "Get started",
                            onPressed: () {
                              Get.toNamed(AppRoutes.socialLogin);
                            },
                          ),
                          const SizedBox(height: 15),
                          SecondaryButton(
                            title: "I have an account",
                            onPressed: () async {
                              Future.delayed(const Duration(milliseconds: 500), () {
                                Get.toNamed(AppRoutes.signIn);
                              });
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
