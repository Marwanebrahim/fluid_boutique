import 'package:equatable/equatable.dart';

sealed class SearchEvent extends Equatable {}

class SearchProductsEvent extends SearchEvent {
  final String query;

  SearchProductsEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class ClearSearchHistoryEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class GetSearchHistoryEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}
