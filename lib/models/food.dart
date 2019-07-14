import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';




@JsonSerializable(nullable: false)
class FoodList {
  final List<Food> foods;

  FoodList({@required this.foods});

  factory FoodList.fromJson(Map<String, dynamic> json) =>
      _$FoodListFromJson(json);

  Map<String, dynamic> toJson() => _$FoodListToJson(this);
}

@JsonSerializable(nullable: false)
class Food {
  final String image;
  final int background;
  final int foreground;
  final String name;
  final double starRating;
  final String desc;
  final double price;
  FoodType foodType;

  Food({
    this.image,
    this.background,
    this.foreground,
    this.name,
    this.starRating,
    this.desc,
    this.price,
    this.foodType,
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

enum FoodType {
  Pizza,
  Rolls,
  Burgers,
  Sandwiches,
}

FoodList pizzaList = FoodList(foods: [
  Food(
    foodType: FoodType.Pizza,
    image: "assets/pizza.png",
    starRating: 4.5,
    name: "Buffalo Blue Cheese Chicken",
    desc:
    "Mozzarella Cheeze, Buffalo blue sauce, and your choice of grilled chicken or crispy chicken fingers",
    background: Color(0xfff2ca80).value,
    foreground: Colors.black.value,
    price: 13.00,
  ),
  Food(
    foodType: FoodType.Pizza,
    image: "assets/sweet_and_tangy.png",
    starRating: 4.5,
    name: "Sweet & Tangy Chicken",
    desc:
    "Mozzarella Cheeze, Buffalo blue sauce, and your choice of grilled chicken or crispy chicken fingers",
    background: Color(0xffd82a12).value,
    foreground: Colors.white.value,
    price: 12.99,
  ),
  Food(
    foodType: FoodType.Pizza,
    image: "assets/jamaican_jerk_veg.png",
    starRating: 4.5,
    name: "Jamaican \nJerk Veg",
    desc:
    "Mozzarella Cheeze, Buffalo blue sauce, and your choice of grilled chicken or crispy chicken fingers",
    background: Color(0xff4fc420).value,
    foreground: Colors.black.value,
    price: 12.99,
  ),
  Food(
    foodType: FoodType.Pizza,
    image: "assets/aussie_barbeque_veg.png",
    starRating: 4.5,
    name: "Aussie Barbeque Veg",
    desc:
    "Mozzarella Cheeze, Buffalo blue sauce, and your choice of grilled chicken or crispy chicken fingers",
    background: Color(0xff5d2512).value,
    foreground: Colors.white.value,
    price: 12.99,
  ),
  Food(
    foodType: FoodType.Pizza,
    image: "assets/indi_tandoori_paneer.png",
    starRating: 4.5,
    name: "Indi Tandoori Paneer",
    desc:
    "Mozzarella Cheeze, Buffalo blue sauce, and your choice of grilled chicken or crispy chicken fingers",
    background: Color(0xffdddbd8).value,
    foreground: Colors.black.value,
    price: 12.99,
  ),
  Food(
    foodType: FoodType.Pizza,
    image: "assets/african_peri_peri.png",
    starRating: 4.5,
    name: "African Saucy\nPeri Peri",
    desc:
    "Mozzarella Cheeze, Buffalo blue sauce, and your choice of grilled chicken or crispy chicken fingers",
    background: Color(0xffd54b1c).value,
    foreground: Colors.white.value,
    price: 12.99,
  ),
]);