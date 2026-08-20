import 'package:fluid_boutique/features/wishlist/domain/use_cases/add_to_wishlist_use_case.dart';
import 'package:fluid_boutique/features/wishlist/domain/use_cases/get_product_data_use_case.dart';
import 'package:fluid_boutique/features/wishlist/domain/use_cases/get_wishlist_use_case.dart';
import 'package:fluid_boutique/features/wishlist/domain/use_cases/remove_from_wishlist_use_case.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:fluid_boutique/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc({
    required this.getWishlistUseCase,
    required this.addToWishlistUseCase,
    required this.removeFromWishlistUseCase,
    required this.getProductDataUseCase,
  }) : super(WishlistInitialState()) {
    on<GetWishlistEvent>(_onGetWishlistEvent);
    on<AddToWishlistEvent>(_onAddToWishlistEvent);
    on<RemoveFromWishlistEvent>(_onRemoveFromWishlistEvent);
    on<GetProductDataEvent>(_onGetProductDataEvent);
  }
  final GetWishlistUseCase getWishlistUseCase;
  final AddToWishlistUseCase addToWishlistUseCase;
  final RemoveFromWishlistUseCase removeFromWishlistUseCase;
  final GetProductDataUseCase getProductDataUseCase;

  void _onGetWishlistEvent(
    GetWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoadingState());
    final wishlist = await getWishlistUseCase();
    wishlist.fold(
      (failure) => emit(WishlistErrorState(message: failure.message)),
      (wishlist) => emit(WishlistSuccessState(wishlist: wishlist)),
    );
  }

  Future<void> _onAddToWishlistEvent(
    AddToWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoadingState());

    final wishlist = await addToWishlistUseCase(product: event.product);
    wishlist.fold(
      (failure) => emit(WishlistErrorState(message: failure.message)),
      (_) => add(GetWishlistEvent()),
    );
  }

  Future<void> _onRemoveFromWishlistEvent(
    RemoveFromWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoadingState());
    final wishlist = await removeFromWishlistUseCase(
      productId: event.productID,
    );
    wishlist.fold(
      (failure) => emit(WishlistErrorState(message: failure.message)),
      (_) => add(GetWishlistEvent()),
    );
  }

  Future<void> _onGetProductDataEvent(
    GetProductDataEvent event,
    Emitter<WishlistState> emit,
  ) async {
    final product = await getProductDataUseCase(productId: event.productID);
    product.fold(
      (_) {},
      (product) => emit(GetProductDataSuccessState(productData: product)),
    );
  }
}
