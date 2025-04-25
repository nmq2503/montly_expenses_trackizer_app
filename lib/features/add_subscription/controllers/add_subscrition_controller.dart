import 'package:get/get.dart';

class AddSubScriptionController extends GetxController {
  // Add your controller logic here
  // For example, you can define variables and methods to handle subscription data
  var subscriptionName = ''.obs;
  var subscriptionPrice = 0.0.obs;

  void setSubscriptionName(String name) {
    subscriptionName.value = name;
  }

  void setSubscriptionPrice(double price) {
    subscriptionPrice.value = price;
  }

  void submitSubscription() {
    // Logic to submit the subscription data
    print('Subscription Name: ${subscriptionName.value}');
    print('Subscription Price: ${subscriptionPrice.value}');
  }
}