import 'package:get/get.dart';
import 'package:green_grocer/src/models/category/category_item_model.dart';
import 'package:green_grocer/src/models/product/product_item_model.dart';
import 'package:green_grocer/src/models/search_product/search_product_model.dart';
import 'package:green_grocer/src/pages/home/repository/home_repository.dart';
import 'package:green_grocer/src/pages/home/result/home_result.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  // Global Variables
  bool isCategoryFetching = false;
  bool isProductFetching = true;
  List<CategoryItemModel> categories = [];
  CategoryItemModel? currentCategory;
  List<ProductItemModel> get products => currentCategory?.items ?? [];

  SearchProductModel searchProductModel = SearchProductModel();
  RxString searchTitle = ''.obs;

  bool get isLastPage {
    // Quantidade de Items for menor que Items por Página = Última página
    if (currentCategory!.items.length < searchProductModel.itemsPerPage) {
      return true;
    }

    // A Quantidade de páginas x Quantidade de Items por página é menor que a quantidade de Itens?
    return searchProductModel.page! * searchProductModel.itemsPerPage >
        products.length;
  }

  // Private Instances
  final _homeRepository = HomeRepository();
  final UtilsServices _utilsServices = UtilsServices();

  // Methods
  @override
  void onInit() {
    super.onInit();

    debounce(
      searchTitle,
      (callback) {
        getProductByTitle();
      },
      time: const Duration(
        milliseconds: 450,
      ),
    );

    getCategoryList();
  }

  void selectCategory({required CategoryItemModel category}) {
    // print('Selected Category $category');
    // Resetar a paginação para 0, quando trocar para uma nova categoria.
    searchProductModel.page = 0;
    currentCategory = category;
    searchProductModel.categoryId = category.id;
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
        await _homeRepository.getCategoryList();

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
        // ignore: avoid_print
        print(message);
        _utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  // int rodou = 0;

  Future<void> getProductList({bool canLoad = true}) async {
    searchProductModel.title = null;
    // print("Rodou getProductList ${rodou = rodou + 1}x");
    if (canLoad) setLoading(isLoading: true, isProduct: true);

    if (searchTitle.value.isNotEmpty) {
      searchProductModel.title = searchTitle.value;

      if (currentCategory!.id == "todos") {
        searchProductModel.categoryId = null;
      }
    }

    // print('currentCategory $currentCategory');
    HomeResult<ProductItemModel> result =
        await _homeRepository.getProductList(body: searchProductModel);

    // print("result $result");

    setLoading(isLoading: false, isProduct: true);

    result.when(
      success: (data) {
        // print('data $data');
        currentCategory!.items.addAll(data);
        update();
      },
      error: (message) {
        // ignore: avoid_print
        print(message);
        _utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  void loadMoreProducts() {
    searchProductModel.page = searchProductModel.page! + 1;

    getProductList(canLoad: false);
  }

  void getProductByTitle() {
    // Apagar todos os produtos das categorias
    for (CategoryItemModel category in categories) {
      category.items.clear();
      searchProductModel.page = 0;
    }

    if (searchTitle.value.isEmpty) {
      categories.removeAt(0);
    } else {
      CategoryItemModel? checkCategories =
          categories.firstWhereOrNull((element) => element.id == "todos");

      if (checkCategories == null) {
        // Criar uma nova Categoria com Todos
        final allProductsCategory = CategoryItemModel(
          title: "Todos",
          id: "todos",
          items: [],
        );
        searchProductModel.page = 0;
        categories.insert(0, allProductsCategory);
      } else {
        checkCategories.items.clear();
        searchProductModel.page = 0;
      }
    }

    currentCategory = categories.first;

    update();

    getProductList();
  }
}
