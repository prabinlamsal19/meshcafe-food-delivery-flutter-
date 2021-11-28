import 'package:flutter/foundation.dart';

class Food {
  String? id;
  String? name;
  String? imagePath;
  String? description;
  String? category;
  String? price;
  String? discount;
  String? ratings;

  Food(
      {this.name,
      this.imagePath,
      this.description,
      this.category,
      this.price,
      this.discount,
      this.ratings});

//receiving data from the server
  factory Food.fromMap(map) {
    return Food(
        name: map['name'],
        imagePath: map['imagePath'],
        description: map['description'],
        category: map['category'],
        price: map['price'],
        discount: map['discount'],
        ratings: map['ratings']);
  }

  //sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePath': imagePath,
      'description': description,
      'category': category,
      'price': price,
      'discount': discount,
      'ratings': ratings
    };
  }
}
