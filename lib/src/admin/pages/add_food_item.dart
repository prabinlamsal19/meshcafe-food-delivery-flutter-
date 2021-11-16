import 'package:flutter/material.dart';
import 'package:meshcafe_app/src/models/category_model.dart';
import 'package:meshcafe_app/src/models/food_model.dart';
import 'package:meshcafe_app/src/widgets/button.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFoodItem extends StatefulWidget {
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

String title;
String category;
String description;
String price;
String discount;

GlobalKey<FormState> _foodItemFormKey = GlobalKey();

class _AddFoodItemState extends State<AddFoodItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 16),
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Form(
            key: _foodItemFormKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("noimage.png")),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black, offset: Offset(0, 0.5)),
                      ]),
                ),
                _buildTextFormField("Food Title"),
                _buildTextFormField("Category"),
                _buildTextFormField("Description", maxLine: 5),
                _buildTextFormField("Price"),
                _buildTextFormField("Discount"),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                    onTap: () {
                      if (_foodItemFormKey.currentState.validate()) {
                        _foodItemFormKey.currentState.save();

                        final Food food = Food(
                            name: title,
                            category: category,
                            description: description,
                            price: double.parse(price),
                            discount: double.parse(discount));
                      }
                    },
                    child: Button("Add to the menu")),
              ],
            ),
          )),
    );
  }
}

Widget _buildTextFormField(String hint, {int maxLine = 1}) {
  return TextFormField(
      decoration: InputDecoration(hintText: hint),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        var errorMsg;
        if (value.isEmpty && hint != "Discount") {
          errorMsg = "The $hint) is required";
        }

        return errorMsg;
      },
      onChanged: (String value) {
        if (hint == "Food Title") {
          title = "$value";
        }

        if (hint == "Category") {
          category = value;
        }
        ;
        if (hint == "Food Title") {
          description = value;
        }

        if (hint == "Food Title") {
          price = value;
        }

        if (hint == "Food Title") {
          discount = value;
        }
      });
}
