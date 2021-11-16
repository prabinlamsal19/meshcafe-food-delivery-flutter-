// import 'package:scoped_model/scoped_model.dart';
// import '../models/food_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class FoodModel extends Model {
//   List<Food> _foods = [];

//   List<Food> get foods {
//     return List.from(_foods);
//   }

//   void addFood(Food food) async{
//     // _foods.add(food);
//     final Map<String,dynamic> foodData= { 
//       "title": food.name,
//       "discription": food.description,
//       "category":food.category,
//       "price": food.price,
//       "discount": food.discount,
//     }
//     final http.Response response =await http.post("https://foodapp-aef2e-default-rtdb.firebaseio.com/foods.json ",
//     body: json.encode(foodData));
//   }
//   print(response);
  
//   }

  
