import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackizer/common_widget/custom_snackbar.dart';
import 'package:trackizer/controllers/app_controller.dart';

import '../../../services/database_service.dart';
import '../../../utils/local_images.dart';

class AddSubScriptionController extends GetxController {
  // ------------------------------
  // Properties
  // ------------------------------

  final TextEditingController _txtDescription = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  final List _subArr = [
    {
      "name": "HBO GO",
      "icon": LocalImage.HBOLogo,
    },
    {
      "name": "Spotify",
      "icon": LocalImage.SpotifyLogo,
    },
    {
      "name": "YouTube Premium",
      "icon": LocalImage.YoutubeLogo,
    },
    {
      "name": "Microsoft OneDrive",
      "icon": LocalImage.OnedriveLogo,
    },
    {
      "name": "NetFlix",
      "icon": LocalImage.NetflixLogo,
    }
  ].obs;
  final RxDouble _amountVal = 20.000.obs;
  final RxInt _selectedIndex = 0.obs;
  final RxString _selectedImage = "".obs;

  // ------------------------------
  // Getters
  // ------------------------------

  TextEditingController get txtDescription => _txtDescription;
  TextEditingController get amountController => _amountController;

  double get amountVal => _amountVal.value;
  List get subArr => _subArr;

  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;

  String get selectedImage => _selectedImage.value;
  set selectedImage(String value) => _selectedImage.value = value;

  // ------------------------------
  // Public Methods
  // ------------------------------

  @override
  void onInit() {
    super.onInit();

    // Lắng nghe khi người dùng nhập
    // _amountController.addListener(() {
    //   final rawText = _amountController.text;
    //   final amount = _parseAmount(rawText);
    //   if (amount < 1000) {
    //     _amountController.text = '1000';
    //     _amountController.selection = TextSelection.fromPosition(
    //       TextPosition(offset: _amountController.text.length),
    //     );
    //   }
    // });

    // _amountController.addListener(() {
    //   String raw = _amountController.text;

    //   // Xóa mọi ký tự không phải số
    //   String numeric = raw.replaceAll(RegExp(r'[^\d]'), '');
    //   if (numeric.isEmpty) numeric = '0';

    //   int value = int.parse(numeric);
    //   if (value < 1000) value = 1000;

    //   final formatted = _formatMoney(value);

    //   // Cập nhật controller với text đã định dạng
    //   _amountController.value = TextEditingValue(
    //     text: formatted,
    //     selection: TextSelection.collapsed(offset: formatted.length),
    //   );
    // });

    setupMoneyFormatter();
  }

  void setupMoneyFormatter() {
    _amountController.text = _formatMoney(1000);

    _amountController.addListener(() {
      final oldText = _amountController.text;
      final oldSelection = _amountController.selection;

      // Loại bỏ mọi ký tự không phải số
      String numericText = oldText.replaceAll(RegExp(r'[^\d]'), '');

      if (numericText.isEmpty) return;

      // Parse lại số
      int value = int.tryParse(numericText) ?? 0;

      if (value < 1000) value = 1000;

      final formatted = _formatMoney(value);

      // Nếu không thay đổi gì thì thoát sớm
      if (formatted == oldText) return;

      // Tính số chữ số (digit) phía trước con trỏ cũ
      int digitBeforeCursor = 0;
      for (int i = 0; i < oldSelection.baseOffset && i < oldText.length; i++) {
        if (RegExp(r'\d').hasMatch(oldText[i])) digitBeforeCursor++;
      }

      // Tìm offset mới tương ứng digitBeforeCursor
      int newOffset = 0;
      int digitCount = 0;
      while (newOffset < formatted.length && digitCount < digitBeforeCursor) {
        if (RegExp(r'\d').hasMatch(formatted[newOffset])) {
          digitCount++;
        }
        newOffset++;
      }

      _amountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(
          offset: newOffset.clamp(
              0, formatted.length), // 👈 đảm bảo con trỏ không vượt quá độ dài
        ),
      );
      print("Formatted: '$formatted' | NewOffset: $newOffset");
    });
  }

  String _formatMoney(int value) {
    final chars = value.toString().split('').reversed.toList();
    final buffer = StringBuffer();
    for (int i = 0; i < chars.length; i++) {
      buffer.write(chars[i]);
      if ((i + 1) % 3 == 0 && i != chars.length - 1) {
        buffer.write('.');
      }
    }
    return buffer.toString().split('').reversed.join();
  }

  double parseAmount() {
    final raw = _amountController.text;
    final cleaned = raw.replaceAll('.', '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
    _selectedImage.value = _subArr[index]['icon'];
  }

  // void increaseAmount() {
  //   _amountVal.value += 0.1;
  //   _syncAmountToTextField();
  // }

  // void decreaseAmount() {
  //   _amountVal.value -= 0.1;
  //   if (_amountVal.value < 0) {
  //     _amountVal.value = 0;
  //   }
  //   _syncAmountToTextField();
  // }

  // void setAmount(double value) {
  //   _amountVal.value = value < 0 ? 0 : value;
  //   _syncAmountToTextField();
  // }

  Future<void> saveSubscription() async {
    // print(AppController().firebaseUser?.uid);
    print(_txtDescription.text);
    print(_amountController.text);

    // 'userId': userId,
    //     'name': subscriptionData['name'],
    //     'description': subscriptionData['description'],
    //     'reminder': subscriptionData['reminder'],
    //     'amount': subscriptionData['amount'],
    //     'createdAt': FieldValue.serverTimestamp(),

    try {
      // await _firestoreService.saveSubscription(
      //   AppController().localStorage.read('userId'),
      //   {
      //     'name': _subArr[selectedIndex]['name'],
      //     'description': _txtDescription.text,
      //     'reminder': '1 ngày',
      //     'amount': _amountController.text,
      //   },
      // );

      CustomSnackbar.showSuccessSnackbar('Thành công', 'Đã lưu đăng ký!');
    } catch (e) {
      CustomSnackbar.showErrorSnackbar('Lỗi', 'Không lưu được: $e');
    }
  }

  // ------------------------------
  // Private Methods
  // ------------------------------

  // void _syncAmountToTextField() {
  //   _amountController.text = _amountVal.value.toStringAsFixed(2);
  // }

  // ------------------------------
  // Lifecycle
  // ------------------------------

  @override
  void onClose() {
    _txtDescription.dispose();
    _amountController.dispose();
    super.onClose();
  }
}
