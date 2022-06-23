import 'package:flutter/material.dart';
import 'package:meal_app/models/dummy_data.dart';
import 'package:meal_app/screen/category_meals_screen.dart';
import 'package:meal_app/screen/filter_screen.dart';
import 'package:meal_app/screen/meal_details_screen.dart';
import 'package:meal_app/screen/tabscreen.dart';

import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactos": false,
    "vegan": false,
    "vegiterian": false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((element) {
          if(_filters['gluten']==true && !element.isGlutenFree){
            return false;
          }
          if(_filters['lactos']==true && !element.isLactoseFree){
            return false;
          }
          if(_filters['vegan']==true && !element.isVegan){
            return false;
          }
          if(_filters['vegiterian']==true && !element.isVegetarian){
            return false;
          }
          return true;
      } ).toList();
    });


  }

  bool isMealfavorite(String mealId){
      return _favoriteMeals.any((element) => element.id==mealId);
  }

  void favoriteMeals(String mealId){
     final existingMeal = _favoriteMeals.indexWhere((element) => element.id==mealId);
     if(existingMeal>=0){
       setState((){
         _favoriteMeals.removeAt(existingMeal);
       });
     }else {
       setState((){
         _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id==mealId));
       });
     }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.pink,
                accentColor: Colors.greenAccent,
                errorColor: Colors.red,
                backgroundColor: Colors.white38),
            fontFamily: 'Raleway',
            textTheme: ThemeData
                .light()
                .textTheme
                .copyWith(
              labelMedium:
              TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              bodyText1: const TextStyle(
                  fontSize: 20, fontFamily: 'RobotoCondensed'),
              bodyText2:
              TextStyle(fontSize: 14, fontFamily: 'RobotoCondensed'),
              headline1: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal),
            )),
        initialRoute: "/",
        routes: {
          '/': (ctx) => TabsScreen(_favoriteMeals),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(_availableMeals),
          MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(favoriteMeals,isMealfavorite),
          FilterScreen.routeName: (ctx) => FilterScreen(_filters,setFilter),
        });
  }
}
