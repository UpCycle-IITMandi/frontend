import 'package:frontend/models/app_state.dart';
import 'package:frontend/reducers/cart_item_reducer.dart';
import 'package:frontend/reducers/vendor_reducer.dart';

AppState appReducer(AppState state, action) => AppState(
      vendorId: vendorReducer(state.vendorId, action),
      cartItems: cartItemsReducer(state.cartItems, action),
    );
