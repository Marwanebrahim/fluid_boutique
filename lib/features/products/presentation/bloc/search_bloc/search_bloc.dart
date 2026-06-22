import 'package:fluid_boutique/features/products/domain/use_cases/add_search_history_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/clear_search_history_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/get_search_history_use_case.dart';
import 'package:fluid_boutique/features/products/domain/use_cases/search_product_use_case.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/search_bloc/search_event.dart';
import 'package:fluid_boutique/features/products/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductUseCase searchProductUseCase;
  final GetSearchHistoryUseCase getSearchHistoryUseCase;
  final AddSearchHistoryUseCase addSearchHistoryUseCase;
  final ClearSearchHistoryUseCase clearSearchHistoryUseCase;
  SearchBloc({
    required this.searchProductUseCase,
    required this.getSearchHistoryUseCase,
    required this.addSearchHistoryUseCase,
    required this.clearSearchHistoryUseCase,
  }) : super(SearchIncialState()) {
    on<SearchProductsEvent>(
      _searchProductsEvent,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
    on<GetSearchHistoryEvent>(_getSearchHistoryEvent);
    on<ClearSearchHistoryEvent>(_clearSearchHistoryEvent);
  }

  Future<void> _searchProductsEvent(
    SearchProductsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    final searchResult = await searchProductUseCase(query: event.query);
    if (searchResult.isLeft()) {
      searchResult.fold(
        (failure) => emit(SearchErrorState(message: failure.message)),
        (_) {},
      );
      return;
    }
    final products = searchResult.getOrElse(() => []);
  final searchHistoryResult =  await addSearchHistoryUseCase(event.query);
    if (searchHistoryResult.isLeft()) {
      searchHistoryResult.fold(
        (failure) => emit(SearchErrorState(message: failure.message)),
        (_) {},
      );
      return;
    }
    if (products.isEmpty) {
      emit(SearchEmptyState());
    } else {
      emit(SearchSuccessState(products: products));
    }
  }

  void _getSearchHistoryEvent(
    GetSearchHistoryEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchHistoryLoadingState());
    final result = await getSearchHistoryUseCase();
    result.fold(
      (failure) => emit(SearchHistoryErrorState(message: failure.message)),
      (searchHistory) => searchHistory.isEmpty
          ? emit(SearchHistortyEmptyState())
          : emit(SearchHistorySuccessState(searchHistory: searchHistory)),
    );
  }

  void _clearSearchHistoryEvent(
    ClearSearchHistoryEvent event,
    Emitter<SearchState> emit,
  ) async {
    final result = await clearSearchHistoryUseCase();
    result.fold(
      (failure) => emit(SearchHistoryErrorState(message: failure.message)),
      (_) => emit(SearchHistortyEmptyState()),
    );
  }
}
