import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/validation.dart';

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

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      fullName: json["full_name"] as String?,
      userName: json["user_name"] as String?,
      email: json["email"] as String?,
      phone: json["phone"] as String?,
      imageUrl: json["image_url"] as String?,
      createdAt: Validation.convertToDateTime(json["created_at"]),
      updatedAt: Validation.convertToDateTime(json["updated_at"]),
    );
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


