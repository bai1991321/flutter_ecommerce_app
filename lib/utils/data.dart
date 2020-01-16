import 'package:flutter_ecommerce/model/Category.dart';
import 'package:flutter_ecommerce/model/product.dart';

class cart {
  Product _product;
  int _count;

  Product get product => _product;

  int get count => _count;

  cart(this._count, this._product);

  setCount(int count) {
    _count = count;
  }
}

class Data {
  static List<cart> cart_list = [];
  static List<Category> categories = [];

  static addCartList(Product pro, int count) {
    cart_list.add(new cart(count, pro));
  }

  static List<Product> products = [];

  static Category getCategoryFromName(name) {
    return categories.firstWhere(
        (c) => c.name.toLowerCase() == name.toString().toLowerCase());
  }
}
