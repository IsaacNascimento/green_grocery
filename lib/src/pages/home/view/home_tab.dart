import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/pages/base/controller/navigation_controller.dart';
import 'package:green_grocer/src/pages/cart/controller/cart_controller.dart';
import 'package:green_grocer/src/pages/home/controller/home_controller.dart';
import 'package:green_grocer/src/pages/home/view/components/category_tile.dart';
import 'package:green_grocer/src/pages/home/view/components/item_tile.dart';
import 'package:green_grocer/src/pages/widgets/app_name_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final searchFieldController = TextEditingController();
  final _navigationController = Get.find<NavigationController>();

  final GlobalKey<CartIconKey> _globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        actions: [
          Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: GetBuilder<CartController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      _navigationController
                          .navigatePageView(NavigationTabas.cart);
                    },
                    child: Badge(
                      backgroundColor: CustomColors.customContrastColor,
                      label: Text(
                        controller.cartItems.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      child: SizedBox(
                        height: 35,
                        child: AddToCartIcon(
                          key: _globalKeyCartItems,
                          icon: Icon(
                            Icons.shopping_cart,
                            color: CustomColors.customSwatchColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
        ],
      ),

      // Conteúdo
      body: AddToCartAnimation(
        gkCart: _globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCartAnimation) {
          runAddToCartAnimation = addToCartAnimation;
        },
        child: Column(
          children: [
            // Campo de pesquisa
            GetBuilder<HomeController>(
              builder: (controller) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: searchFieldController,
                    onChanged: (value) {
                      if (value.length > 2) {
                        controller.searchTitle.value = value;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: searchFieldController.text.isNotEmpty &&
                              controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchFieldController.clear();
                                controller.searchTitle.value = "";

                                // Quando removido o valor do campo, deve-se voltar para a primeira categoria;
                                controller.searchProductModel.categoryId =
                                    controller.categories.elementAt(1).id;
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: CustomColors.customContrastColor,
                                size: 21,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Pesquise aqui...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.customContrastColor,
                        size: 21,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Categorias
            GetBuilder<HomeController>(
              builder: (controller) {
                return controller.isCategoryFetching
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.only(left: 25),
                        child: SizedBox(
                          height: 40,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return CategoryTile(
                                  onPressed: () {
                                    setState(
                                      () {
                                        controller.selectCategory(
                                          category:
                                              controller.categories[index],
                                        );
                                      },
                                    );
                                  },
                                  category: controller.categories[index].title!,
                                  isSelected: controller.categories[index] ==
                                      controller.currentCategory);
                            },
                            separatorBuilder: (_, index) =>
                                const SizedBox(width: 10),
                            itemCount: controller.categories.length,
                          ),
                        ),
                      );
              },
            ),

            // Grid
            GetBuilder<HomeController>(
              builder: (controller) {
                return controller.isProductFetching
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Visibility(
                          visible: (controller.currentCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 40,
                                color: CustomColors.customSwatchColor,
                              ),
                              const Text("Não há itens para apresentar")
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 9 / 11.5),
                            itemCount: controller.products.length,
                            itemBuilder: (_, index) {
                              bool isLastItem =
                                  (index + 1) == controller.products.length;
                              bool isLastPage = controller.isLastPage;
                              if (isLastItem && !isLastPage) {
                                controller.loadMoreProducts();
                              }

                              return ItemTile(
                                item: controller.products[index],
                                cartAnimationMethod: itemSelectedCartAnimations,
                              );
                            },
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
