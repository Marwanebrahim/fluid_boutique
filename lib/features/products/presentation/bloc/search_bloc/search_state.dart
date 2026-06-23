import 'package:equatable/equatable.dart';
import 'package:fluid_boutique/features/products/domain/entity/product_entity.dart';

sealed class SearchState extends Equatable {}

class SearchIncialState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class SearchSuccessState extends SearchState {
  final List<ProductEntity> products;
  SearchSuccessState({required this.products});
  @override
  List<Object?> get props => [products];
}

class SearchEmptyState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchHistorySuccessState extends SearchState {
  final List<String> searchHistory;
  SearchHistorySuccessState({required this.searchHistory});
  @override
  List<Object?> get props => [searchHistory];
}

class SearchHistoryErrorState extends SearchState {
  final String message;
  SearchHistoryErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class SearchHistoryLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchHistoryEmptyState extends SearchState {
  @override
  List<Object?> get props => [];
}
