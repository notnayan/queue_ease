import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:queue_ease/src/features/authentication/screens/splash/splash_screen.dart';
import 'package:queue_ease/src/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: 'test_public_key_7d90d07da0a048d7aa311d3e13fd3c65',
      enabledDebugging: true,
      builder: (context, navKey) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: QEAppTheme.lightTheme,
            darkTheme: QEAppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: const SplashScreen(),
            navigatorKey: navKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ]);
      },
    );
  }
}
