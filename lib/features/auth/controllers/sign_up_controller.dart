import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackizer/common_widget/custom_snackbar.dart';
import 'package:trackizer/models/user_data.dart';
import 'package:trackizer/routes/app_routes.dart';

import '../../../services/database_service.dart';
import '../../../utils/validation.dart';

class SignUpController extends GetxController {
  late GlobalKey<FormState> formSignUpKey;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _enableButton = false.obs;
  bool get enableButton => _enableButton.value;
  set enableButton(bool value) => _enableButton.value = value;

  final RxInt _passwordStrength = 0.obs;
  int get passwordStrength => _passwordStrength.value;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _txtFullName = TextEditingController();
  TextEditingController get fullNameController => _txtFullName;

  final TextEditingController _txtUserName = TextEditingController();
  TextEditingController get userNameController => _txtUserName;

  final TextEditingController _txtEmail = TextEditingController();
  TextEditingController get emailController => _txtEmail;

  final TextEditingController _txtPassword = TextEditingController();
  TextEditingController get passwordController => _txtPassword;

  final TextEditingController _txtConfirmPassword = TextEditingController();
  TextEditingController get confirmPasswordController => _txtConfirmPassword;

  String get email => _txtEmail.text.trim();
  set email(String value) => _txtEmail.text = value;

  String get password => _txtPassword.text.trim();
  set password(String value) => _txtPassword.text = value;

  @override
  void onInit() {
    super.onInit();
    formSignUpKey = GlobalKey<FormState>();

    _txtFullName.addListener(checkFormFilled);
    _txtUserName.addListener(checkFormFilled);
    _txtEmail.addListener(checkFormFilled);
    _txtPassword.addListener(checkFormFilled);
    _txtConfirmPassword.addListener(checkFormFilled);
  }

  void updatePasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    _passwordStrength.value = strength;
  }

  String updateLablePassword() {
    if (passwordController.text.isEmpty) {
      return "Mật khẩu cần có ít nhất 8 ký tự, bao gồm chữ cái viết hoa,\nsố và ký tự đặc biệt";
    } else if (_passwordStrength.value == 0) {
      return "Mật khẩu yếu";
    } else if (_passwordStrength.value == 1) {
      return "Mật khẩu trung bình";
    } else if (_passwordStrength.value == 2) {
      return "Mật khẩu mạnh";
    } else {
      return "Mật khẩu rất mạnh";
    }
  }

  void checkFormFilled() {
    final isAllFilled = _txtFullName.text.trim().isNotEmpty &&
        _txtUserName.text.trim().isNotEmpty &&
        _txtEmail.text.trim().isNotEmpty &&
        _txtPassword.text.trim().isNotEmpty &&
        _txtConfirmPassword.text.trim().isNotEmpty;

    _enableButton.value = isAllFilled;
  }

  Future<void> signUp() async {
    if (formSignUpKey.currentState!.validate()) {
      final fullName = fullNameController.text.trim();
      final userName = userNameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      if (fullName.isEmpty ||
          userName.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        CustomSnackbar.showErrorSnackbar(
            'Lỗi', 'Vui lòng điền đầy đủ thông tin');
        return;
      }

      if (fullName.length < 3) {
        CustomSnackbar.showErrorSnackbar(
            'Lỗi', 'Tên đầy đủ phải có ít nhất 3 ký tự');
        return;
      }

      if (userName.length < 3) {
        CustomSnackbar.showErrorSnackbar(
            'Lỗi', 'Tên người dùng phải có ít nhất 3 ký tự');
        return;
      }

      final emailValidation = Validation.validateEmail(email);
      if (emailValidation != null) {
        CustomSnackbar.showErrorSnackbar("Lỗi", emailValidation);
        return;
      }

      final passwordValidation = Validation.validatePassword(password);
      if (passwordValidation != null) {
        CustomSnackbar.showErrorSnackbar("Lỗi", passwordValidation);
        return;
      }

      if (password != confirmPassword) {
        CustomSnackbar.showErrorSnackbar(
          "Lỗi",
          "Mật khẩu và xác nhận mật khẩu không khớp",
        );
        return;
      }

      try {
        _isLoading.value = true;
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String userId = userCredential.user!.uid;

        Map<String, dynamic> userData = {
          "full_name": fullName,
          "user_name": userName,
          "email": email,
          "phone": "",
          "image_url": "",
          "created_at": FieldValue.serverTimestamp(),
          "updated_at": FieldValue.serverTimestamp(),
        };

        await _firestoreService.addUserData(userId, userData);

        Future.delayed(const Duration(seconds: 1), () {
          CustomSnackbar.showSuccessSnackbar(
              "Thành công", "Đăng ký tài khoản thành công");
          Get.offNamed(AppRoutes.signIn);
        });
      } catch (e) {
        CustomSnackbar.showErrorSnackbar(
            "Lỗi", "Đã xảy ra lỗi khi đăng ký tài khoản");
        debugPrint("Error sign in: $e");
        return;
      } finally {
        _isLoading.value = false;
        formSignUpKey.currentState!.reset();
        clearControllers();
      }
    }
  }

  void clearControllers() {
    _txtFullName.clear();
    _txtUserName.clear();
    _txtEmail.clear();
    _txtPassword.clear();
    _txtConfirmPassword.clear();
  }

  @override
  void onClose() {
    _txtFullName.removeListener(checkFormFilled);
    _txtUserName.removeListener(checkFormFilled);
    _txtEmail.removeListener(checkFormFilled);
    _txtPassword.removeListener(checkFormFilled);
    _txtConfirmPassword.removeListener(checkFormFilled);

    _txtFullName.dispose();
    _txtUserName.dispose();
    _txtEmail.dispose();
    _txtPassword.dispose();
    _txtConfirmPassword.dispose();
    super.onClose();
  }
}
