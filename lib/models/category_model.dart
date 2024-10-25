class CategoryModel {
  final int id;
  final String name;

  CategoryModel(this.id, this.name);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name
      } => CategoryModel(id, name),
      _ => throw const FormatException("Failed to load Class")
    };
  }
}