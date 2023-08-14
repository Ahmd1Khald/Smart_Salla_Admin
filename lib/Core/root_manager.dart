import 'package:flutter/material.dart';
import 'package:salla_admin/Fetures/admin/presentation/views/dashboard_screen.dart';

import 'consts/app_strings.dart';

class Routes {
  static const String splashRoute = "/";

  static const String dashboardRoute = "/dashboard";

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
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
