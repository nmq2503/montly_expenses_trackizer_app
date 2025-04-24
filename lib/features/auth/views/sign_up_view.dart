import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackizer/routes/app_routes.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/primary_button.dart';
import '../../../common_widget/round_textfield.dart';
import '../../../common_widget/secondary_boutton.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Obx(
            () {
              return controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Column(
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
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Form(
                                key: controller.formSignUpKey,
                                child: Column(
                                  children: [
                                    RoundTextField(
                                      title: "Tên đầy đủ",
                                      controller: controller.fullNameController,
                                      keyboardType: TextInputType.name,
                                    ),
                                    const SizedBox(height: 15),
                                    RoundTextField(
                                      title: "Tên người dùng",
                                      controller: controller.userNameController,
                                      keyboardType: TextInputType.name,
                                    ),
                                    const SizedBox(height: 15),
                                    RoundTextField(
                                      title: "Email",
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 15),
                                    RoundTextField(
                                      title: "Mật khẩu",
                                      controller: controller.passwordController,
                                      obscureText: true,
                                      onChanged: (value) {
                                        controller
                                            .updatePasswordStrength(value);
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    RoundTextField(
                                      title: "Nhập lại mật khẩu",
                                      controller:
                                          controller.confirmPasswordController,
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 15),
                                    Obx(
                                      () => Row(
                                        children: List.generate(
                                          4,
                                          (index) {
                                            Color barColor;
                                            if (controller.passwordStrength >
                                                index) {
                                              if (controller.passwordStrength <=
                                                  2) {
                                                barColor = Colors.red;
                                              } else if (controller
                                                      .passwordStrength ==
                                                  3) {
                                                barColor = Colors.orange;
                                              } else {
                                                barColor = Colors.green;
                                              }
                                            } else {
                                              barColor = TColor.gray70;
                                            }

                                            return Expanded(
                                              child: Container(
                                                height: 5,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                decoration: BoxDecoration(
                                                  color: barColor,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        controller.updateLablePassword(),
                                        style: TextStyle(
                                          color: TColor.gray50,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
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
                              Obx(
                                () => Expanded(
                                  flex: 1,
                                  child: PrimaryButton(
                                    title: "Đăng ký",
                                    isEnabled: controller.enableButton,
                                    onPressed: () {
                                      if (controller.formSignUpKey.currentState!
                                          .validate()) {
                                        controller.signUp();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Bạn đã có tài khoản?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: TColor.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                flex: 1,
                                child: SecondaryButton(
                                  title: "Đăng nhập",
                                  onPressed: () {
                                    Get.offNamed(AppRoutes.signIn);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
