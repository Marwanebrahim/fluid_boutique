class CategoryModel {
  String slug;
  String name;
  String url;

  CategoryModel({required this.slug, required this.name, required this.url});

  factory CategoryModel.fromJson({required Map<String, dynamic> json}) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }
}
