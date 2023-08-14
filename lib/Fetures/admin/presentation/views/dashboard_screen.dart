import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla_admin/Fetures/admin/presentation/views/widgets/dashboard_btn.dart';

import '../../../../Core/consts/app_strings.dart';
import '../../../../Core/consts/app_variables.dart';
import '../../../../Core/providers/theme_provider.dart';
import '../../../../Core/services/assets_manager.dart';
import '../../../../Core/widgets/title_text.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: dashboardAppBar(themeProvider),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: DynamicHeightGridView(
                  builder: (context, index) => DashboardButton(
                    image: getDashboardMenuList(context)[index].image,
                    subTitle: getDashboardMenuList(context)[index].subtitle,
                    onPressed: getDashboardMenuList(context)[index].onPressed,
                  ),
                  itemCount: 3,
                  crossAxisCount: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar dashboardAppBar(ThemeProvider themeProvider) {
    return AppBar(
      title: const TitlesTextWidget(label: AppStrings.dashboardScreenString),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(AssetsImages.shoppingCart),
      ),
      actions: [
        IconButton(
          onPressed: () {
            themeProvider.setDarkTheme(
                themeValue: !themeProvider.getIsDarkTheme);
          },
          icon: Icon(themeProvider.getIsDarkTheme
              ? Icons.light_mode
              : Icons.dark_mode),
        ),
      ],
    );
  }
}
