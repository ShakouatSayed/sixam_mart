import 'dart:convert';

class ModuleModel{
  final int id;
  final String moduleName;
  final String moduleType;
  final String thumbnail;
  final int storesCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? themeId;
  final String? description;

  ModuleModel({
   required this.id,
   required this.moduleName,
    required this.moduleType,
    required this.thumbnail,
    required this.storesCount,
    required this.createdAt,
    required this.updatedAt,
    this.themeId,
    this.description,
});

  factory ModuleModel.fromJson(Map<String, dynamic> json){
    return ModuleModel(
      id: json["id"] ?? 0,
      moduleName: json["module_name"] ?? "",
      moduleType: json["module_type"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      storesCount: json["stores_count"] ?? 0,
      createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json["update_at"] ?? DateTime.now().toString()),
      themeId: json["theme_id"],
      description: json["description"],
    );
  }

  // To JSON

Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "module_name" : moduleName,
      "module_type" : moduleType,
      "thumbnail" : thumbnail,
      "stores_count" : storesCount,
      "created_at" : createdAt.toIso8601String(),
      "update_at" : updatedAt.toIso8601String(),
      "theme_id" : themeId,
      "description" : description,
    };
}
}