

import 'package:flutter/material.dart';
import 'package:meal_app/models/dummy_data.dart';
import 'package:meal_app/widget/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  /*final String CateryID;
  final String CatTitle;
   CategoryMealsScreen(this.CateryID, this.CatTitle) ;*/

  static const routeName = "/category-meal";
  List<Meal> availableMeals;
  CategoryMealsScreen(this. availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title = "";
  String id = "";
  late List<Meal> categoryMeals;
  var isDataloaded = false;
  void removeItem(String mealID) {
    setState((){
      categoryMeals.removeWhere((element) => element.id == mealID);
      if(categoryMeals.length<1){
        Navigator.of(context).pop();
      }
    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!isDataloaded){
      final routeArgs =
      ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
      title = routeArgs["title"].toString();
      id = routeArgs["id"].toString();
      categoryMeals = widget.availableMeals.where((element) {
        return element.categories.contains(id);
      }).toList();
      isDataloaded=true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(title.toString())),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem.name(
                categoryMeals[index].id,
                categoryMeals[index].title,
                categoryMeals[index].imageUrl,
                categoryMeals[index].duration,
                categoryMeals[index].complexity,
                categoryMeals[index].affordability,
                );
          },
          itemCount: categoryMeals.length),
    );
  }
}
