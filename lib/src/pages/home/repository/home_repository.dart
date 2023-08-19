import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/category/category_item_model.dart';
import 'package:green_grocer/src/models/product/product_item_model.dart';
import 'package:green_grocer/src/models/search_product/search_product_model.dart';
import 'package:green_grocer/src/pages/home/result/home_result.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryItemModel>> getCategoryList() async {
    final result = await _httpManager.restRequest(
      url: EndPoint.categoryList,
      method: HttpMethods.post,
    );

    if (result['status'] == 200) {
      final List<CategoryItemModel> items = [];
      for (var item in result['result']) {
        items.add(CategoryItemModel.fromJson(item));
      }

      return HomeResult<CategoryItemModel>.success(items);
    } else {
      String errorMessage = result['error'];
      return HomeResult.error(errorMessage);
    }
  }

  Future<HomeResult<ProductItemModel>> getProductList(
      {required SearchProductModel body}) async {
    // print('product repository: ${body.toJson()}');
    final result = await _httpManager.restRequest(
      url: EndPoint.productList,
      method: HttpMethods.post,
      body: body.toJson(),
    );

    if (result['status'] == 200) {
      final List<ProductItemModel> products = [];
      for (var product in result['result']) {
        products.add(ProductItemModel.fromJson(product));
      }
      return HomeResult<ProductItemModel>.success(products);
    } else {
      String errorMessage = result['error'];
      return HomeResult.error(errorMessage);
    }
  }
}
