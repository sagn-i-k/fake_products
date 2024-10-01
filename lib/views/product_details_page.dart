import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import 'cart_view.dart';


class ProductDetailsView extends StatelessWidget {
  final ProductModel product;
  final CartController cartController = Get.find();

  ProductDetailsView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                Obx(() => cartController.cartItems.isNotEmpty
                    ? Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartController.cartItems.length.toString(),
                      style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
                    ),
                  ),
                )
                    : Container())
              ],
            ),
            onPressed: () {
              Get.to(() => CartView());
            },
          ),
        ],
      ),
      body:   Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.5),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.title,
              style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: GoogleFonts.montserrat(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(product.description,style: GoogleFonts.montserrat(fontSize: 12),),
            Spacer(),
            Obx(() {
              int quantity = cartController.getQuantity(product);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  quantity > 0
                      ? Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cartController.removeFromCart(product);
                        },
                      ),
                      Text(quantity.toString(),
                          style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartController.addToCart(product);
                        },
                      ),
                    ],
                  )
                      : InkWell(
              onTap: (){
              cartController.addToCart(product);
              Get.snackbar('Added to Cart', '${product.title} added to cart');
              },
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
              decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4.5)
              ),
              child: Text("Add to Cart",style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.white),),
              ),
              ),
                  SizedBox(width: 16),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}