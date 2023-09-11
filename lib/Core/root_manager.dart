import 'package:flutter/material.dart';
import 'package:salla_admin/Fetures/admin/presentation/views/dashboard_screen.dart';
import 'package:salla_admin/Fetures/admin/presentation/views/inner_screens/orders/orders_screen.dart';
import 'package:salla_admin/Fetures/admin/presentation/views/search_screen.dart';
import 'package:salla_admin/splash/splash_screen.dart';

import '../Fetures/admin/presentation/views/inner_screens/edit_upload_product_form.dart';
import 'consts/app_strings.dart';

class Routes {
  static const String splashRoute = "/";

  static const String dashboardRoute = "/dashboard";

  static const String allProductRoute = "/allProduct";

  static const String viewOrdersRoute = "/viewOrders";
  static const String editOrUploadProductRoute = "/EditOrUploadProduct";

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case Routes.allProductRoute:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case Routes.viewOrdersRoute:
        return MaterialPageRoute(builder: (_) => const OrdersScreenFree());
      case Routes.editOrUploadProductRoute:
        return MaterialPageRoute(
            builder: (_) => const EditOrUploadProductScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRoute),
              ),
              body: const Center(child: Text(AppStrings.noRoute)),
            ));
  }
}
