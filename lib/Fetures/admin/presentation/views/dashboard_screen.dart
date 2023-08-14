import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Core/consts/app_strings.dart';
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
      appBar: AppBar(
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
      ),
      body: const Center(
        child: TitlesTextWidget(label: AppStrings.dashboardScreenString),
      ),
    );
  }
}
