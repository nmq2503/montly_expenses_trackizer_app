import '../utils/validation.dart';

class Supcription {
  String? name;
  String? imageUrl;
  String? description;
  String? price;
  int? duration;
  String? status;
  DateTime? duaDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Supcription({
    this.name,
    this.imageUrl,
    this.description,
    this.price,
    this.duration,
    this.status,
    this.duaDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Supcription.fromJson(Map<String, dynamic> json) {
    return Supcription(
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      duration: json['duration'] as int?,
      status: json['status'] as String?,
      duaDate: Validation.convertToDateTime(json["dua_date"]),
      createdAt: Validation.convertToDateTime(json["created_at"]),
      updatedAt: Validation.convertToDateTime(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': imageUrl,
      'description': description,
      'price': price,
      'duration': duration,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}