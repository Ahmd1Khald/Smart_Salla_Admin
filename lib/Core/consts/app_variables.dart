import 'package:flutter/material.dart';
import 'package:salla_admin/Core/root_manager.dart';
import 'package:salla_admin/Core/services/assets_manager.dart';

import '../../Fetures/admin/data/models/dashboard_menu_model.dart';

class AppVariables {
  static List<DashboardMenuModel> getDashboardMenuList(context) {
    List<DashboardMenuModel> dashboardMenuList = [
      DashboardMenuModel(
        subtitle: 'Add a new product',
        image: AssetsImages.bagWish,
        onPressed: () {
          Navigator.pushNamed(context, Routes.editOrUploadProductRoute);
        },
      ),
      DashboardMenuModel(
        subtitle: 'Inspect all products',
        image: AssetsImages.shoppingCart,
        onPressed: () {
          Navigator.pushNamed(context, Routes.allProductRoute);
        },
      ),
      DashboardMenuModel(
        subtitle: 'View Orders',
        image: AssetsImages.orderBag,
        onPressed: () {
          Navigator.pushNamed(context, Routes.viewOrdersRoute);
        },
      ),
    ];
    return dashboardMenuList;
  }

  static List<String> categoriesList = [
    'Phones',
    'Clothes',
    'Shoes',
    'Laptops',
    'Books',
    'Electronics',
    'Cosmetics',
    'Watches',
  ];

  static List<DropdownMenuItem<String>>? get categoriesDropDownList {
    List<DropdownMenuItem<String>>? menuItems =
        List<DropdownMenuItem<String>>.generate(
      categoriesList.length,
      (index) => DropdownMenuItem(
        value: categoriesList[index],
        child: Text(
          categoriesList[index],
        ),
      ),
    );
    return menuItems;
  }
}
