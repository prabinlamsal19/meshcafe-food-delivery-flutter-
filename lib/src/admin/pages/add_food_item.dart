import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshcafe_app/src/data/food_data.dart';
// import 'package:meshcafe_app/src/models/category_model.dart';
import 'package:meshcafe_app/src/models/food_model.dart';
import 'package:meshcafe_app/src/widgets/button.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
//pages
import 'FirebaseApi.dart';

class AddFoodItem extends StatefulWidget {
  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

//editing controllers
final TextEditingController foodTitleController = new TextEditingController();
final TextEditingController categoryController = new TextEditingController();
final TextEditingController descriptionController = new TextEditingController();
final TextEditingController priceController = new TextEditingController();
final TextEditingController discountController = new TextEditingController();

String? title;
String? category;
String? description;
late String price;
late String discount;

GlobalKey<FormState> _foodItemFormKey = GlobalKey();

class _AddFoodItemState extends State<AddFoodItem> {
  File? image;
  bool loading = false;
  Future PickFoodImage() async {
    try {
      final imagefile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagefile == null) return;
      final imageTemporary = File(imagefile.path);
      //final imagePermanent = await saveImagePermanently(image.path); //only name is permanent.. its temporary.
      // SaveImage(imageTemporary);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 2.0,
                        context: context,
                        builder: (context) => Wrap(children: [
                              Column(
                                children: [
                                  ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text("Gallery"),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pop(ImageSource.gallery);
                                        PickFoodImage();
                                      })
                                ],
                              ),
                            ]));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: (image == null
                              ? AssetImage("assets/supper_1.jpeg")
                              : FileImage(image!)) as ImageProvider<Object>,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black, offset: Offset(0, 0.5)),
                        ]),
                  ),
                ),
                _titleFormField("Food Title"),
                _categoryFormField("Category"),
                _descriptionFormField("Description"),
                _priceFormField("Price"),
                _discountFormField("Discount"),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                    onTap: () {
                      if (_foodItemFormKey.currentState!.validate()) {
                        _foodItemFormKey.currentState!.save();
                        postFirestore();

                        // final Food food = Food(
                        //     name: title,
                        //     category: category,
                        //     description: description,
                        //     price: double.parse(price),
                        //     discount: double.parse(discount));

                      }
                    },
                    child: Button("Add to the menu")),
              ],
            ),
          )),
    );
  }

  Widget _titleFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      controller: foodTitleController,
      decoration: InputDecoration(hintText: hint),
      maxLines: maxLine,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        var errorMsg;
        if (value!.isEmpty) {
          errorMsg = "The $hint is required";
        }
        return errorMsg;
      },
    );
  }

  Widget _categoryFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      controller: categoryController,
      decoration: InputDecoration(hintText: hint),
      maxLines: maxLine,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        var errorMsg;
        if (value!.isEmpty) {
          errorMsg = "The $hint is required";
        }
        return errorMsg;
      },
    );
  }

  Widget _descriptionFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      controller: descriptionController,
      decoration: InputDecoration(hintText: hint),
      maxLines: maxLine,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        var errorMsg;
        if (value!.isEmpty) {
          errorMsg = "The $hint is required";
        }
        return errorMsg;
      },
    );
  }

  Widget _priceFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      controller: priceController,
      decoration: InputDecoration(hintText: hint),
      maxLines: maxLine,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        var errorMsg;
        if (value!.isEmpty) {
          errorMsg = "The $hint is required";
        }
        return errorMsg;
      },
    );
  }

  Widget _discountFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      controller: discountController,
      decoration: InputDecoration(hintText: hint),
      maxLines: maxLine,
      keyboardType: TextInputType.text,
    );
  }

//firestore addition
//after import is done, now comes initialization
// ignore: dead_code
  String? finalUrl;
  postFirestore() async {
    FirebaseApi? a;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Food food = Food();
    //putting the data
    food.name = foodTitleController.text;
    food.category = categoryController.text;
  food.imagePath = "waiting...";
    food.description = descriptionController.text;
    food.price = priceController.text;
    food.discount = discountController.text;
    food.ratings = "five stars"; // get the average ratings from database..
    await uploadFile();
    await firestore
        .collection('food')
        .doc(foodTitleController.text)
        .set(food.toMap());
  }

//right now we have a file? image that stores the File(imagefile.path)
// File? image stores the path of the image on the phone
// on the blog, we have _image containing the path of the file
//the container also displays the image file ..

//for uploading image to firebase,

//create a reference to the firestore document that will sotre the url
  Future uploadFile() async {
    if (image == null) return;
    final fileName = basename(image!.path);
    final destination = 'files/$fileName';
    FirebaseApi().uploadFile(destination, image!);
    await FirebaseFirestore.instance
        .collection('food')
        .doc(foodTitleController.text)
        .( 
          'imagePath': {FirebaseApi().returnUrl()}; // start
        );
  }
    // DocumentReference sightingRef =
    //     FirebaseFirestore.instance.collection("food").doc();
  }
}
