import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/app_state.dart';

List<CartItem> cartItemsReducer(
    List<CartItem> items, MyAction<CartItem?, CartActions> action) {
  if (action.type == CartActions.AddItemAction) {
    final index = items.indexWhere((element) =>
        element.product.productId == action.value!.product.productId);
    if (index == -1) {
      return [...items, action.value!];
    } else {
      items[index] = CartItem(items[index].product, items[index].quantity + 1);
      return items;
    }
  } else if (action.type == CartActions.EditCartAction) {
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
    }).toList();
    return result.whereType<CartItem>().toList(); // <3
  } else if (action.type == CartActions.ClearCartAction) {
    return List<CartItem>.empty();
  } else {
    return items;
  }
}
