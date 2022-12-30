import 'package:frontend/actions/actions.dart';
import 'package:frontend/models/app_state.dart';

String? vendorReducer(String? vendorId, MyAction action) {
  if (action.type == VendorActions.editVendorAction) {
    return action.value;
  } else {
    return vendorId;
  }
}
