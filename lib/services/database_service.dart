import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> addUserData(String userId, Map<String, dynamic> userData) async {
    try {
      await _db.collection('Users').doc(userId).set(userData);
      // print("User data added successfully");
      return true;
    } catch (e) {
      // print("Error saving user data to Firestore: $e");
      return false;
    }
  }

  // Hàm lấy thông tin người dùng từ Firestore
  Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot = await _db.collection('Users').doc(userId).get();
      return snapshot;
    } catch (e) {
      print("Error getting user data: $e");
      rethrow;
    }
  }

  // Hàm cập nhật thông tin người dùng
  Future<void> updateUserData(String userId, Map<String, dynamic> userData) async {
    try {
      await _db.collection('users').doc(userId).update(userData);
      print("User data updated successfully");
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  // Hàm xóa người dùng
  Future<void> deleteUserData(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
      print("User data deleted successfully");
    } catch (e) {
      print("Error deleting user data: $e");
    }
  }

  // Hàm lưu subscription
  Future<void> saveSubscription(String userId, Map<String, dynamic> subscriptionData) async {
    try {
      await _db.collection('subscriptions').add({
        'name': subscriptionData['name'],
        'description': subscriptionData['description'],
        'reminder': subscriptionData['reminder'],
        'amount': subscriptionData['amount'],
        'duaDateAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(), 
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print("Subscription saved successfully");
    } catch (e) {
      print("Error saving subscription: $e");
    }
  }
}
