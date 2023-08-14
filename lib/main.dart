import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Core/consts/theme_data.dart';
import 'Core/providers/theme_provider.dart';
import 'Core/root_manager.dart';
import 'Fetures/admin/presentation/controller/providers/product_provider.dart';
import 'Fetures/admin/presentation/views/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Salla ADMIN',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const DashboardScreen(),
          onGenerateRoute: Routes.getRoute,
          initialRoute: Routes.editOrUploadProductRoute,
        );
      }),
    );
  }
}
