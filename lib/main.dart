import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:queue_ease/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Todo: Init Local Storage
  await Hive.initFlutter(); // Initializes Hive for Flutter
  await Hive.openBox("localData"); // Opens the Hive box for local data
  await Hive.openBox("userData"); // Opens the Hive box for user data
  var box = Hive.box('userData'); // Gets the Hive box for local data
  if (box.get("isFirstTime") == null) {
    box.put("isFirstTime",true); 
  }
  // Todo: Await Splash
  // Todo: Initialize Database
  // Todo: Initialize Authentication
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}
