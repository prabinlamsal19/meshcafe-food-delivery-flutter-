//this will be the main root widget of the application

import 'package:flutter/material.dart';
import 'package:meshcafe_app/src/scoped-model/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/main_screen.dart';

class App extends StatelessWidget {
  // final FoodModel foodModel = FoodModel();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meshcafe",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: MainScreen(
          // foodModel: foodModel,
          ),
    );
  }
}
