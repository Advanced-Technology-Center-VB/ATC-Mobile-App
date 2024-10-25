import 'package:atc_mobile_app/models/category_model.dart';

class ClassModel {
  int id;
  String name;
  String description;
  String about;
  String prerequisites;
  String category;

  ClassModel({required this.id, required this.name, this.description = "", this.about = "", this.prerequisites = "", this.category = ""});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'description': String description,
        'about': String about,
        'prerequisites': String prerequisites,
        'category' : String category
      } => ClassModel(id: id, name: name, description: description, about: about, prerequisites: prerequisites, category: category),
      _ => throw const FormatException("Failed to load Class")
    };
  }

  factory ClassModel.fromJsonSimple(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name
      } => ClassModel(id: id, name: name),
      _ => throw const FormatException("Failed to load Class")
    };
  }
}