import 'package:get/get.dart';
import 'package:green_grocer/src/models/category_item_model.dart';
import 'package:green_grocer/src/pages/home/repository/home_repository.dart';
import 'package:green_grocer/src/pages/home/result/home_result.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  // Variables
  bool isFetching = false;
  List<CategoryItemModel> categories = [];
  CategoryItemModel? currentCategory;

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
    currentCategory = category;
    update();
  }

  void setLoading({required bool isLoading}) {
    isFetching = isLoading;
    update();
  }

  Future<void> getCategoryList() async {
    setLoading(isLoading: true);

    HomeResult<CategoryItemModel> result =
        await homeRepository.getCategoryList();

    setLoading(isLoading: false);

    result.when(
      success: (data) {
        // this.categories = categories;
        categories.assignAll(data);

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
}
