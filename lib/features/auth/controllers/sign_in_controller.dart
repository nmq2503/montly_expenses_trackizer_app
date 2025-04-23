import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trackizer/routes/app_routes.dart';

import '../../../common_widget/custom_snackbar.dart';
import '../../../controllers/app_controller.dart';
import '../../../services/database_service.dart';
import '../../../utils/validation.dart';

class SignInController extends GetxController {
  final TextEditingController _txtEmail = TextEditingController();
  TextEditingController get emailController => _txtEmail;

  final TextEditingController _txtPassword = TextEditingController();
  TextEditingController get passwordController => _txtPassword;

  final RxBool _isRemember = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String get email => _txtEmail.text.trim();
  set email(String value) => _txtEmail.text = value;

  String get password => _txtPassword.text.trim();
  set password(String value) => _txtPassword.text = value;

  bool get isRemember => _isRemember.value;
  set isRemember(bool value) => _isRemember.value = value;

  final GetStorage _storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() {
    super.onInit();

    // if (kDebugMode) {
    //   _txtEmail.text = 'test@gmail.com';
    //   _txtPassword.text = 'Test@1234';
    // }

    if (_storage.read('isRemember') != null &&
        _storage.read('isRemember') == true) {
      isRemember = _storage.read('isRemember');
      if (_storage.read('email') != null) {
        _txtEmail.text = _storage.read('email');
      }
      if (_storage.read('password') != null) {
        _txtPassword.text = _storage.read('password');
      }
    }
  }

  void toggleRemember() {
    isRemember = !isRemember;
  }

  void signIn() async {
    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.showErrorSnackbar(
        "Lỗi",
        "Vui lòng nhập email và mật khẩu",
      );
      return;
    }

    final String? validateEmail = Validation.validateEmail(email);
    final String? validatePassword = Validation.validatePassword(password);

    if (validateEmail != null) {
      CustomSnackbar.showErrorSnackbar(
        "Lỗi",
        validateEmail,
      );
      return;
    }

    if (validatePassword != null) {
      CustomSnackbar.showErrorSnackbar(
        "Lỗi",
        validatePassword,
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      DocumentSnapshot userData = await _firestoreService.getUserData(userId);

      if (userData.exists) {
        CustomSnackbar.showSuccessSnackbar(
          "Đăng nhập thành công",
          "Chào mừng ${userData['userName']}!",
        );

        final appController = Get.find<AppController>();
        appController.setUser(userCredential.user);

        if (isRemember) {
          _storage.write('isRemember', true);
          _storage.write('email', email);
          _storage.write('password', password);
        } else {
          _storage.remove('isRemember');
          _storage.remove('email');
          _storage.remove('password');
        }

        Get.offAllNamed(AppRoutes.mainTab);
      } else {
        CustomSnackbar.showErrorSnackbar(
          "Lỗi",
          "Tài khoản không tồn tại",
        );
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        CustomSnackbar.showErrorSnackbar(
          "Lỗi",
          "Email hoặc mật khẩu không hợp lệ",
        );
      }
      debugPrint('FirebaseAuthException in signIn(): $e');
    } catch (e) {
      CustomSnackbar.showErrorSnackbar(
        "Lỗi",
        "Đăng nhập thất bại",
      );
    }
  }

  @override
  void onClose() {
    _txtEmail.dispose();
    _txtPassword.dispose();
    super.onClose();
  }
}
