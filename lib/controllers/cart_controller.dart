import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product_model.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartData();
  }


  void addToCart(ProductModel product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    saveCartData();
  }


  void removeFromCart(ProductModel product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
    } else {
      cartItems.remove(product);
    }
    saveCartData();
  }


  int getQuantity(ProductModel product) {
    return cartItems[product] ?? 0;
  }


  Future<void> saveCartData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartData = cartItems.entries.map((entry) {
      return jsonEncode({
        'product': entry.key.toJson(),
        'quantity': entry.value,
      });
    }).toList();
    await prefs.setStringList('cart', cartData);
  }


  Future<void> loadCartData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartData = prefs.getStringList('cart');
    if (cartData != null) {
      cartItems.clear();
      cartData.forEach((item) {
        var decoded = jsonDecode(item);
        var product = ProductModel.fromJson(decoded['product']);
        var quantity = decoded['quantity'];
        cartItems[product] = quantity;
      });
    }
  }
}