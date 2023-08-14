import 'package:flutter/cupertino.dart';
import 'package:salla_admin/Core/root_manager.dart';
import 'package:salla_admin/Core/services/assets_manager.dart';

import '../../Fetures/admin/data/models/dashboard_menu_model.dart';

List<DashboardMenuModel> getDashboardMenuList(context) {
  List<DashboardMenuModel> dashboardMenuList = [
    DashboardMenuModel(
      subtitle: 'Add a new product',
      image: AssetsImages.bagWish,
      onPressed: () {},
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
