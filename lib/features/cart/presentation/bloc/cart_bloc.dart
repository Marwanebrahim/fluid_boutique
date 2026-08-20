import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/get_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_event.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required this.addToCartUseCase,
    required this.getCartUseCase,
    required this.removeFromCartUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitialState()) {
    on<AddToCartEvent>(_addToCartEvent);
    on<GetCartEvent>(_getCartEvent);
    on<RemoveFromCartEvent>(_removeFromCartEvent);
    on<ClearCartEvent>(_clearCartEvent);
    on<UpdateCartQuantityEvent>(_updateCartQuantityEvent);
  }
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final ClearCartUseCase clearCartUseCase;

  Future<void> _addToCartEvent(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await addToCartUseCase(product: event.product);
    result.fold(
      (failure) => emit(CartErrorState(message: failure.message)),
      (_) => add(GetCartEvent()),
    );
  }

  Future<void> _getCartEvent(
    GetCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await getCartUseCase();
    result.fold(
      (failure) => emit(CartErrorState(message: failure.message)),
      (product) => emit(
        product.isEmpty
            ? CartEmptyState()
            : CartSuccessState(cartItems: product),
      ),
    );
  }

  Future<void> _removeFromCartEvent(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await removeFromCartUseCase(product: event.product);
    result.fold(
      (failure) => emit(CartErrorState(message: failure.message)),
      (_) => add(GetCartEvent()),
    );
  }

  Future<void> _clearCartEvent(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await clearCartUseCase();
    result.fold(
      (failure) => emit(CartErrorState(message: failure.message)),
      (_) => emit(CartEmptyState()),
    );
  }

  Future<void> _updateCartQuantityEvent(
    UpdateCartQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await addToCartUseCase(product: event.product);
    result.fold(
      (failure) => emit(CartErrorState(message: failure.message)),
      (_) => add(
        AddToCartEvent(
          product: CartEntity(
            id: event.product.id,
            title: event.product.title,
            thumbnail: event.product.thumbnail,
            price: event.product.price,
            discountPercentage: event.product.discountPercentage,
            stock: event.product.stock,
            color: event.product.color,
            size: event.product.size,
            quantity: event.quantity,
          ),
        ),
      ),
    );
  }
}
