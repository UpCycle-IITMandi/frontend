import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/app_state.dart';

List<CartItem> cartItemsReducer(List<CartItem> items, MyAction action) {
  if (action.type == CartActions.addItemAction) {
    final index = items.indexWhere((element) =>
        element.product.productId == action.value!.product.productId);
    if (index == -1) {
      return [...items, action.value!];
    } else {
      items[index] = CartItem(items[index].product, items[index].quantity + 1);
      return items;
    }
  } else if (action.type == CartActions.editCartAction) {
    var result = items.map((item) {
      if (item.product.productId == action.value!.product.productId) {
        if (action.value!.quantity > 0) {
          return action.value;
        } else {
          return null;
        }
      } else {
        return item;
      }
    });
    return result.whereType<CartItem>().toList(); // <3
  } else if (action.type == CartActions.clearCartAction) {
    return List<CartItem>.empty();
  } else {
    return items;
  }
}
