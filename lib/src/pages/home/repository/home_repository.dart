import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/category_item_model.dart';
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
}
