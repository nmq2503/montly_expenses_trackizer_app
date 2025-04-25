import 'package:get/get.dart';

import 'controllers/add_subscrition_controller.dart';

class AddSubScriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSubScriptionController>(
      () => AddSubScriptionController(),
    );
  }
}
