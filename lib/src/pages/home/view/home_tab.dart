import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
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
  @override
  void initState() {
    super.initState();
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
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                backgroundColor: CustomColors.customContrastColor,
                label: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: SizedBox(
                  height: 35,
                  child: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Conteúdo
      body: Column(
        children: [
          // Campo de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
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
                                        category: controller.categories[index],
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
                          );
                        },
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
