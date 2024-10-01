// import 'package:ecomm_fake_app/views/product_details_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/cart_controller.dart';
// import '../controllers/product_controller.dart';
// import '../models/product_model.dart';
// import 'cart_view.dart';
//
// class ProductListView extends StatefulWidget {
//   @override
//   _ProductListViewState createState() => _ProductListViewState();
// }
//
// class _ProductListViewState extends State<ProductListView> {
//   final ProductController productController = Get.put(ProductController());
//   final CartController cartController = Get.put(CartController()); // Cart controller for managing cart items
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();
//   var filteredList = <ProductModel>[].obs;
//
//   @override
//   void initState() {
//     super.initState();
//     // Display all products initially
//     productController.productList.listen((products) {
//       filteredList.assignAll(products);
//     });
//     searchController.addListener(() {
//       filterProducts();
//     });
//   }
//
//   // Filter products based on search input
//   void filterProducts() {
//     var query = searchController.text.toLowerCase();
//     if (query.isEmpty) {
//       filteredList.assignAll(productController.productList); // Show all products
//     } else {
//       filteredList.assignAll(
//         productController.productList
//             .where((product) => product.title.toLowerCase().contains(query))
//             .toList(),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: isSearching
//             ? TextField(
//           controller: searchController,
//           decoration: InputDecoration(
//             hintText: 'Search products...',
//             border: InputBorder.none,
//             hintStyle: TextStyle(color: Colors.white),
//           ),
//           style: TextStyle(color: Colors.white),
//         )
//             : Text('Product List'),
//         actions: [
//           // Search icon
//           IconButton(
//             icon: Icon(isSearching ? Icons.close : Icons.search),
//             onPressed: () {
//               setState(() {
//                 isSearching = !isSearching;
//                 if (!isSearching) {
//                   searchController.clear(); // Reset search when search is closed
//                   filterProducts();
//                 }
//               });
//             },
//           ),
//           // Cart icon showing the number of items
//           IconButton(
//             icon: Stack(
//               children: [
//                 Icon(Icons.shopping_cart),
//                 Obx(() => cartController.cartItems.isNotEmpty
//                     ? Positioned(
//                   right: 0,
//                   child: CircleAvatar(
//                     radius: 8,
//                     backgroundColor: Colors.red,
//                     child: Text(
//                       cartController.cartItems.length.toString(),
//                       style: TextStyle(fontSize: 12, color: Colors.white),
//                     ),
//                   ),
//                 )
//                     : Container())
//               ],
//             ),
//             onPressed: () {
//               Get.to(() => CartView()); // Navigate to CartView
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (productController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (filteredList.isEmpty) {
//           return Center(child: Text('No products found'));
//         } else {
//           return ListView.builder(
//             itemCount: filteredList.length,
//             itemBuilder: (context, index) {
//               var product = filteredList[index];
//               return ListTile(
//                 leading: Image.network(
//                   product.image,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 ),
//                 title: Text(product.title),
//                 subtitle: Text('\$${product.price.toString()}'),
//                 trailing: ElevatedButton(
//                   onPressed: () {
//                     cartController.addToCart(product); // Add product to cart
//                     Get.snackbar('Added to Cart', '${product.title} added to cart');
//                   },
//                   child: Text('Add to Cart'),
//                 ),
//                 onTap: () {
//                   Get.to(() => ProductDetailsView(product: product)); // Navigate to Product Details
//                 },
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }



import 'package:ecomm_fake_app/utils/string_manager.dart';
import 'package:ecomm_fake_app/views/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
import 'cart_view.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  var filteredList = <ProductModel>[].obs;

  @override
  void initState() {
    super.initState();
    productController.productList.listen((products) {
      filteredList.assignAll(products);
    });
    searchController.addListener(() {
      filterProducts();
    });
  }


  void filterProducts() {
    var query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredList.assignAll(productController.productList); // Show all products
    } else {
      filteredList.assignAll(
        productController.productList
            .where((product) => product.title.toLowerCase().contains(query))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
              if (!isSearching) {
                searchController.clear(); // Reset search when search is closed
                filterProducts();
              }
            });
          },
        ) ,
        centerTitle: true,
        title: isSearching
            ? TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: GoogleFonts.montserrat(color: Colors.black),
          ),
          style: GoogleFonts.montserrat(color: Colors.black),
        )
            : Text(StringManager.homeTitle,style: GoogleFonts.montserrat(fontSize: 26,fontWeight: FontWeight.w500),),
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
              Get.to(() => CartView()); // Navigate to CartView
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (filteredList.isEmpty) {
          return Center(child: Text('No products found'));
        } else {
          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var product = filteredList[index];
              return Container(
                decoration: BoxDecoration(),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue,width: 1.0)
                    ),
                    child: Image.network(
                      product.image,
                      width: 50,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toString()}',style :GoogleFonts.montserrat(fontSize: 12)),
                  trailing: Obx(() {
                    int quantity = cartController.getQuantity(product);
                    if (quantity > 0) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              cartController.removeFromCart(product);
                            },
                          ),
                          Text(quantity.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cartController.addToCart(product);
                            },
                          ),
                        ],
                      );
                    } else {
                      return InkWell(
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
                      );
                    }
                  }),
                  onTap: () {
                    Get.to(() => ProductDetailsView(product: product)); // Navigate to Product Details
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}