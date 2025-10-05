class ChooseUsModel {
  final String icon;
  final String title;
  final String? description;
  final int? id;
  final bool? isActive;

  ChooseUsModel({
    required this.icon,
    required this.title,
    this.description,
    this.id,
    this.isActive = true,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "icon": icon,
      "title": title,
      if (description != null) "description": description,
      if (id != null) "id": id,
      if (isActive != null) "is_active": isActive,
    };
  }

  // Create from JSON
  factory ChooseUsModel.fromJson(Map<String, dynamic> json) {
    return ChooseUsModel(
      icon: json["icon"] ?? json["image"] ?? "",
      title: json["title"] ?? json["name"] ?? "",
      description: json["description"] ?? json["subtitle"],
      id: json["id"],
      isActive: json["is_active"] ?? json["isActive"] ?? true,
    );
  }

  // Empty constructor
  factory ChooseUsModel.empty() {
    return ChooseUsModel(icon: "", title: "");
  }

  // Copy with method
  ChooseUsModel copyWith({
    String? icon,
    String? title,
    String? description,
    int? id,
    bool? isActive,
  }) {
    return ChooseUsModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
    );
  }

  // Check if empty
  bool get isEmpty => icon.isEmpty && title.isEmpty;

  // Check if not empty
  bool get isNotEmpty => icon.isNotEmpty || title.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChooseUsModel &&
        other.icon == icon &&
        other.title == title &&
        other.description == description &&
        other.id == id &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return icon.hashCode ^
        title.hashCode ^
        description.hashCode ^
        id.hashCode ^
        isActive.hashCode;
  }
}
