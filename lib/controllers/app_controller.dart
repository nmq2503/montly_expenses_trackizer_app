import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trackizer/models/user_data.dart';

class AppController extends GetxController {
  final RxString _userId = ''.obs;
  String get userId => _userId.value;
  set userId(String value) => _userId.value = value;

  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get firebaseUser => _firebaseUser.value;
  set firebaseUser(User? value) => _firebaseUser.value = value;

  final Rxn<UserData> _userData = Rxn<UserData>();
  UserData? get userData => _userData.value;
  set userData(UserData? value) => _userData.value = value;

  final GetStorage _localStorage = GetStorage();
  GetStorage get localStorage => _localStorage;

  void setUserData(User? fireBaseUser, UserData? userData) async {
    _firebaseUser.value = fireBaseUser;
    _userData.value = userData;
    _userId.value = fireBaseUser?.uid ?? '';

    if (userData != null) {
      _localStorage.write('userData', userData.toJson());
      if (_userId.value.isNotEmpty) {
        _localStorage.write('userId', _userId.value);
      }
    }
  }

  Future<void> clearData() async {
    _firebaseUser.value = null;
    _userData.value = null;
    _userId.value = '';
    _localStorage.remove('userData');
    _localStorage.remove('userId');
    await FirebaseAuth.instance.signOut();
  }

  @override
  void onInit() async {
    super.onInit();
    _firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());

    final storedUserMap = _localStorage.read('userData');
    if (storedUserMap != null) {
      _userData.value = UserData.fromJson(storedUserMap);
    }
  }
}
