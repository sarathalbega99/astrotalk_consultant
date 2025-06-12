import 'package:flutter/material.dart';

import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init our secureStorage
  AppHiveUtils.initializeHive();
  // create secureStorageBox
  AppHiveBox.appBox = await AppHiveUtils.createSecureHiveBox(
    boxName: AppHiveBoxNames.hIVEaPPbOX,
  );
  runApp(const MyApp());
}

AppNavigator? appNavigator = AppNavigator();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appNavigator!.generateRoute,
    );
  }
}