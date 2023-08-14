import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Core/consts/app_strings.dart';
import '../../../../Core/services/assets_manager.dart';
import '../../../../Core/widgets/product_widget.dart';
import '../../../../Core/widgets/title_text.dart';
import '../../data/models/product_model.dart';
import '../controller/providers/product_provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;

    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: TitlesTextWidget(
                label: passedCategory ?? AppStrings.searchString),
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(AssetsImages.shoppingCart),
            ),
          ),
          body: productList.isEmpty
              ? const Center(
                  child: TitlesTextWidget(label: AppStrings.noProductString),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        controller: searchTextController,
                        decoration: InputDecoration(
                          hintText: AppStrings.searchString,
                          filled: true,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // setState(() {
                              searchTextController.clear();
                              FocusScope.of(context).unfocus();
                              // });
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   productListSearch = productProvider.searchQuery(
                          //       searchText: searchTextController.text);
                          // });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            productListSearch = productProvider.searchQuery(
                                searchText: searchTextController.text,
                                passedList: productList);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      if (searchTextController.text.isNotEmpty &&
                          productListSearch.isEmpty) ...[
                        const Center(
                            child: TitlesTextWidget(
                          label: AppStrings.noResultString,
                          fontSize: 40,
                        ))
                      ],
                      Expanded(
                        child: DynamicHeightGridView(
                          itemCount: searchTextController.text.isNotEmpty
                              ? productListSearch.length
                              : productList.length,
                          builder: ((context, index) {
                            return ProductWidget(
                              productId: searchTextController.text.isNotEmpty
                                  ? productListSearch[index].productId
                                  : productList[index].productId,
                            );
                          }),
                          crossAxisCount: 2,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
