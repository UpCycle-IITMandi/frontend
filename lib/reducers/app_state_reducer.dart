import 'package:frontend/models/app_state.dart';
import 'package:frontend/reducers/cart_item_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    cartItems: cartItemsReducer(state.cartItems, action),
  );
}
