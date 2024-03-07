import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:queue_ease/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:queue_ease/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:queue_ease/src/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: QEAppTheme.lightTheme,
      darkTheme: QEAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ProfileScreen(),
    );
  }
}
