import 'package:get/get.dart';
import 'package:green_grocer/src/models/category/category_item_model.dart';
import 'package:green_grocer/src/models/product/product_item_model.dart';
import 'package:green_grocer/src/models/search_product/search_product_model.dart';
import 'package:green_grocer/src/pages/home/repository/home_repository.dart';
import 'package:green_grocer/src/pages/home/result/home_result.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  // Variables
  bool isCategoryFetching = false;
  bool isProductFetching = true;
  List<CategoryItemModel> categories = [];
  CategoryItemModel? currentCategory;
  List<ProductItemModel> get products => currentCategory?.items ?? [];

  // Instances
  final homeRepository = HomeRepository();
  final UtilsServices utilsServices = UtilsServices();

  // Methods
  @override
  void onInit() {
    super.onInit();
    getCategoryList();
  }

  void selectCategory({required CategoryItemModel category}) {
    // print('Selected Category $category');
    currentCategory = category;
    update();

    if (currentCategory!.items.isNotEmpty) return;
    getProductList();
  }

  void setLoading({required bool isLoading, required bool isProduct}) {
    if (isProduct) {
      isProductFetching = isLoading;
    } else {
      isCategoryFetching = isLoading;
    }
    update();
  }

  Future<void> getCategoryList() async {
    setLoading(isLoading: true, isProduct: false);

    HomeResult<CategoryItemModel> result =
        await homeRepository.getCategoryList();

    setLoading(isLoading: false, isProduct: false);

    result.when(
      success: (data) {
        // this.categories = categories;
        categories.assignAll(data);
        update();

        if (categories.isEmpty) return;

        selectCategory(category: categories.first);
      },
      error: (message) {
        print(message);
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> getProductList() async {
    setLoading(isLoading: true, isProduct: true);

    // print('currentCategory $currentCategory');
    final SearchProductModel body =
        SearchProductModel(categoryId: currentCategory!.id!);

    HomeResult<ProductItemModel> result =
        await homeRepository.getProductList(body: body);

    setLoading(isLoading: false, isProduct: true);

    result.when(
      success: (data) {
        // print('data $data');
        currentCategory!.items = data;
        update();
      },
      error: (message) {
        print(message);
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
