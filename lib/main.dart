import 'package:flutter/material.dart';
import 'package:queue_ease/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:queue_ease/src/utils/theme/theme.dart';

void main() {

  // Todo: Init Local Storage
  // Todo: Await Splash
  // Todo: Initialize Database
  // Todo: Initialize Authentication

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: QEAppTheme.lightTheme,
      darkTheme: QEAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
