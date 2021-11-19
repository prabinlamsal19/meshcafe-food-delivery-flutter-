import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:meshcafe_app/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App()); //runapp is in material.dart
}
