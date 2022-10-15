import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/app_state.dart';

List<CartItem> cartItemsReducer(
    List<CartItem> items, MyAction<CartItem, CartActions> action) {
  if (action.type == CartActions.AddItemAction) {
    return [...items, action.value];
  }
  return items;
}
