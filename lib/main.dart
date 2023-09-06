import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'Core/consts/app_strings.dart';
import 'Core/consts/theme_data.dart';
import 'Core/providers/theme_provider.dart';
import 'Core/root_manager.dart';
import 'Fetures/admin/presentation/controller/providers/product_provider.dart';
import 'Fetures/admin/presentation/views/dashboard_screen.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            home: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: const Center(
                child: SpinKitPouringHourGlass(
                  color: Colors.orangeAccent,
                  size: 50,
                ),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            home: Scaffold(
              body: Center(
                child: SelectableText(
                    "An Error has been occured ${snapshot.error}"),
              ),
            ),
          );
        }
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
              initialRoute: Routes.dashboardRoute,
            );
          }),
        );
      },
    );
  }
}
