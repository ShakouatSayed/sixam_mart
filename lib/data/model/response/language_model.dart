import 'package:flutter/cupertino.dart';

class LanguageModel {
  final String imageUrl;
  final String languageName;
  final String countryCode;
  final String languageCode;
  final bool? isActive;
  final int? id;
  final String? nativeName;
  final String? direction; // "ltr" or "rtl"

  LanguageModel({
    required this.imageUrl,
    required this.languageName,
    required this.countryCode,
    required this.languageCode,
    this.isActive = true,
    this.id,
    this.nativeName,
    this.direction = "ltr",
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "image_url": imageUrl,
      "language_name": languageName,
      "country_code": countryCode,
      "language_code": languageCode,
      if (isActive != null) "is_active": isActive,
      if (id != null) "id": id,
      if (nativeName != null) "native_name": nativeName,
      if (direction != null) "direction": direction,
    };
  }

  // Create from JSON
  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      imageUrl: json["image_url"] ?? json["imageUrl"] ?? json["flag"] ?? "",
      languageName:
          json["language_name"] ?? json["languageName"] ?? json["name"] ?? "",
      countryCode: json["country_code"] ?? json["countryCode"] ?? "us",
      languageCode: json["language_code"] ?? json["languageCode"] ?? "en",
      isActive: json["is_active"] ?? json["isActive"] ?? true,
      id: json["id"],
      nativeName: json["native_name"] ?? json["nativeName"],
      direction: json["direction"] ?? "ltr",
    );
  }

  // Empty constructor
  factory LanguageModel.empty() {
    return LanguageModel(
      imageUrl: "",
      languageName: "",
      countryCode: "us",
      languageCode: "en",
    );
  }

  // Copy with method
  LanguageModel copyWith({
    String? imageUrl,
    String? languageName,
    String? countryCode,
    String? languageCode,
    bool? isActive,
    int? id,
    String? nativeName,
    String? direction,
  }) {
    return LanguageModel(
      imageUrl: imageUrl ?? this.imageUrl,
      languageName: languageName ?? this.languageCode,
      countryCode: countryCode ?? this.countryCode,
      languageCode: languageCode ?? this.languageCode,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      nativeName: nativeName ?? this.nativeName,
      direction: direction ?? this.direction,
    );
  }

  // Check if empty
  bool get isEmpty =>
      imageUrl.isEmpty &&
      languageName.isEmpty &&
      countryCode.isEmpty &&
      languageCode.isEmpty;

  // Check if not empty
  bool get isNotEmpty => !isEmpty;

  // Get local String (e.g., "en_US")
  String get local {
    return "${languageCode}_$countryCode";
  }

  // Get local object for Flutter
  Locale get flutterLocal {
    return Locale(languageCode, countryCode);
  }

  // Check if this is RTL language
  bool get isRTL {
    return direction == "rtl";
  }

  // Get display name (shows native name if available)
  String get displayName {
    return nativeName ?? languageName;
  }

  @override
  String toString() {
    return "LanguageModel("
        "imageUrl: $imageUrl, "
        "languageName: $languageName, "
        "countryCode: $countryCode, "
        "languageCode: $languageCode, "
        "isActive: $isActive, "
        "id : $id, "
        "nativeName: $nativeName, "
        "direction: $direction)";
  }

  @override
  bool operator == (Object other){
    if(identical(this, other)) return true;
    return other is LanguageModel &&
    other.imageUrl == imageUrl &&
    other.languageName == languageName &&
    other.countryCode == countryCode &&
    other.languageCode == languageCode &&
    other.isActive == isActive &&
    other.id == id&&
    other.nativeName == nativeName &&
    other.direction == direction;
  }

  @override
  int get hashCode{
    return imageUrl.hashCode ^
    languageName.hashCode ^
    countryCode.hashCode ^
    languageCode.hashCode ^
    isActive.hashCode^
    id.hashCode^
    nativeName.hashCode ^
    direction.hashCode;
  }
}
