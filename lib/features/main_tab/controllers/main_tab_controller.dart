import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class MainTabController extends GetxController {
  final PersistentTabController _persistentTabController =
      PersistentTabController(initialIndex: 0);
  PersistentTabController get persistentTabController =>
      _persistentTabController;

  final RxBool isSwitchingTab = false.obs;

  DateTime lastTap = DateTime.now();

  void onTabSelected(int index) {
    final now = DateTime.now();
    if (now.difference(lastTap) < const Duration(milliseconds: 500)) {
      return; // chặn click quá nhanh
    }
    lastTap = now;
    _persistentTabController.index = index;
  }

  void changeTabIndex(int index) async {
    if (isSwitchingTab.value) return;

    isSwitchingTab.value = true;
    _persistentTabController.index = index;

    await Future.delayed(const Duration(milliseconds: 600));
    isSwitchingTab.value = false;
  }
}
