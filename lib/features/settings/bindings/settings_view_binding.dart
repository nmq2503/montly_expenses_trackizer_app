import 'package:get/get.dart';
import 'package:trackizer/features/settings/controllers/settings_view_controller.dart';

class SettingsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsViewController>(() => SettingsViewController());
  }
}
