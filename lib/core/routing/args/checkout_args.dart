import 'package:fluid_boutique/features/cart/domain/entity/cart_entity.dart';
import 'package:fluid_boutique/features/cart/presentation/bloc/cart_bloc.dart';

class CheckoutArgs {
  final List<CartEntity> cartItems;
  final CartBloc cartBloc;

  CheckoutArgs({required this.cartItems, required this.cartBloc});
}
