import 'package:fluid_boutique/features/products/domain/use_cases/get_all_categories_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_all_products_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_event.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/product_bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.getAllCategoriesUseCase,
    required this.getAllProductsUseCase,
    required this.getProductsByCategoryUseCase,
  }) : super(ProductInitialState()) {
    on<GetAllCategoriesEvent>(_onGetAllCategoriesEvent);
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategoryEvent);
    on<GetSpecificProductEvent>(_onGetSpecificProductEvent);
    on<GetSpecialProductsByCategory>(_onGetSpecialProductsByCategory);
  }
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  Future<void> _onGetAllCategoriesEvent(
    GetAllCategoriesEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(CategoryLoadingState());
    final result = await getAllCategoriesUseCase();
    result.fold(
      (failure) => emit(CategoryErrorState(message: failure.message)),
      (categories) => emit(CategorySuccessState(categories: categories)),
    );
  }

  void _onGetAllProductsEvent(
    GetAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final result = await getAllProductsUseCase();
    result.fold(
      (failure) => emit(ProductErrorState(message: failure.message)),
      (products) => emit(ProductSuccessState(products: products)),
    );
  }

  void _onGetProductsByCategoryEvent(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final result = await getProductsByCategoryUseCase(event.category);
    result.fold(
      (failure) => emit(ProductErrorState(message: failure.message)),
      (products) => emit(ProductSuccessState(products: products)),
    );
  }

  void _onGetSpecificProductEvent(
    GetSpecificProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(SpecificProductLoadingState());
    final result = await getProductsByCategoryUseCase(event.productCategory);
    result.fold(
      (failure) => emit(SpecificProductErrorState(message: failure.message)),
      (products) => emit(SpecificProductSuccessState(products: products)),
    );
  }

  void _onGetSpecialProductsByCategory(
    GetSpecialProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(SpecificCategoryProductLoadingState());
    final result = await getProductsByCategoryUseCase(event.productCategory);
    result.fold(
      (failure) =>
          emit(SpecificCategoryProductErrorState(message: failure.message)),
      (products) =>
          emit(SpecificCategoryProductSuccessState(products: products)),
    );
  }
}
