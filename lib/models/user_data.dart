import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? fullName;
  String? userName;
  String? email;
  String? phone;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.fullName,
    this.userName,
    this.email,
    this.phone,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    fullName = json["full_name"];
    userName = json["user_name"];
    email = json["email"];
    phone = json["phone"];
    imageUrl = json["image_url"];
    createdAt = _convertToDateTime(json["created_at"]);
    updatedAt = _convertToDateTime(json["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "user_name": userName,
      "email": email,
      "phone": phone,
      "image_url": imageUrl,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}

// Hàm hỗ trợ để chuyển Timestamp hoặc String thành DateTime
DateTime? _convertToDateTime(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}
