import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AppController extends GetxController {

  final Rxn<User> _firebaseUser = Rxn<User>();
  final GetStorage _localStorage = GetStorage();
  GetStorage get localStorage => _localStorage;

  void setUser(User? user) {
    _firebaseUser.value = user;
  }

  Future<void> clearData() async {
    _firebaseUser.value = null;
    await FirebaseAuth.instance.signOut();
  }

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();
    _firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  User? get currentUser => _firebaseUser.value;
}
