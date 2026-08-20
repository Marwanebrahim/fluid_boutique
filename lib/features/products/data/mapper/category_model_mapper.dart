import 'package:fluid_boutique/features/products/data/model/category_model.dart';
import 'package:fluid_boutique/features/products/domain/entity/category_entity.dart';

extension CategoryModelMapper on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(slug: slug, name: name);
  }
}
