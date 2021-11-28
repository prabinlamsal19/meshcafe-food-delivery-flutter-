import 'package:flutter/material.dart';
import 'package:meshcafe_app/src/admin/pages/add_food_item.dart';
//Pages
import '../pages/homepage.dart';
import '../pages/order_page.dart';
import '../pages/profile_page.dart';
import '../pages/explore_page.dart';
import 'package:meshcafe_app/src/pages/signup_page.dart';

class MainScreen extends StatefulWidget {
  // final FoodModel foodModel;
  // MainScreen({this.foodModel});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  late List<Widget?> pages;
  Widget? currentPage;

  HomePage? homePage;
  OrderPage? orderPage;
  ExplorePage? explorePage;
  ProfilePage? profilePage;
  SignUpPage? signupPage;
  AddFoodItem? addFoodItemPage;

  @override
  void initState() {
    // TODO: implement initState

    //call the fetch method on food
    // widget.foodModel.fetchFoods();

    super.initState();
    homePage = HomePage(); //creating an instance of the homepage...
    orderPage = OrderPage();
    explorePage = ExplorePage();
    profilePage = ProfilePage();
    signupPage = SignUpPage();
    addFoodItemPage = AddFoodItem();

    pages = [homePage, explorePage, orderPage, profilePage, addFoodItemPage];
    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: "Add Food Item"),
        ],
      ),
      body: currentPage,
    );
  }
}
