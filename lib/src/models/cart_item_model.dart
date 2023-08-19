import 'package:green_grocer/src/models/product/product_item_model.dart';

class CartItemModel {
  ProductItemModel item;
  int quantity;

  CartItemModel({
    required this.item,
    required this.quantity,
  });

  double totalPrice() {
    return item.price * quantity;
  }
}
