import 'package:flutter/material.dart';
import 'package:meshcafe_app/src/widgets/home_top_info.dart';
import 'widgets/food_category.dart';
import 'widgets/search_field.dart';
import 'widgets/bought_foods.dart';
//data
import 'data/food_data.dart';
//model
import 'models/food_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> _foods = foods;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            children: <Widget>[
          HomeTopInfo(),
          SizedBox(
            height: 5.0,
          ),
          FoodCategory(),
          SizedBox(
            height: 7.0,
          ),
          SearchField(),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Frequently bought foods",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                GestureDetector(
                  onTap: () {},
                  child: Text("View All",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent)),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            children: _foods.map(_buildFoodItems).toList(),
          ),
        ]));
  }
}

Widget _buildFoodItems(Food food) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    child: BoughtFoods(
      id: food.id,
      name: food.name,
      imagePath: food.imagePath,
      category: food.category,
      discount: food.discount,
      price: food.price,
      ratings: food.ratings,
    ),
  );
}
