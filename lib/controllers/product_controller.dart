import 'package:ecomm_fake_app/utils/api_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(ApiManager.products));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        productList.value = jsonData.map((item) => ProductModel.fromJson(item)).toList();
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }
}