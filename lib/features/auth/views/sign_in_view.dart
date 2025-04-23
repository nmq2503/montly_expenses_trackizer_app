import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackizer/features/auth/controllers/sign_in_controller.dart';
import 'package:trackizer/routes/app_routes.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/primary_button.dart';
import '../../../common_widget/round_textfield.dart';
import '../../../common_widget/secondary_boutton.dart';
import '../../../utils/validation.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: media.height * 0.1,
                  child: Image.asset(
                    "assets/img/app_logo.png",
                    width: media.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 8,
                child: Center(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          RoundTextField(
                            title: "Email",
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validation.validateEmail,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RoundTextField(
                            title: "Mật khẩu",
                            controller: controller.passwordController,
                            obscureText: true,
                            titleAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.toggleRemember();
                                },
                                child: Obx(
                                  () => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        controller.isRemember
                                            ? Icons.check_box_rounded
                                            : Icons
                                                .check_box_outline_blank_rounded,
                                        size: 25,
                                        color: TColor.gray50,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Lưu tài khoản",
                                        style: TextStyle(
                                            color: TColor.gray50, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Quên mật khẩu?",
                                  style: TextStyle(
                                      color: TColor.gray50, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: PrimaryButton(
                        title: "Đăng nhập",
                        onPressed: () async {
                          controller.signIn();
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Bạn chưa có tài khoản?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: TColor.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 1,
                      child: SecondaryButton(
                        title: "Đăng ký",
                        onPressed: () {
                          Get.offNamed(AppRoutes.signUp);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
