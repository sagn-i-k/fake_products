import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cart_controller.dart';


class CartView extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty'));
        } else {
          return ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              var product = cartController.cartItems.keys.toList()[index];
              var quantity = cartController.cartItems[product];

              return ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.title),
                subtitle: Text('\$${product.price.toString()}',style:GoogleFonts.montserrat(fontSize: 12)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        cartController.removeFromCart(product);
                      },
                    ),
                    Text(quantity.toString()), // Show product count
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cartController.addToCart(product);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return SizedBox();
        } else {
          double totalPrice = cartController.cartItems.entries
              .map((e) => e.key.price * e.value)
              .reduce((sum, item) => sum + item);

          return Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Checkout', 'Proceeding to Checkout');
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}