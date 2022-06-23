import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widget/meal_item.dart';
class FavoriteScreen extends StatelessWidget {
  static var routeName='/favorite-meal';
   final List<Meal> favoriteMeals;
  const FavoriteScreen(this.favoriteMeals,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(favoriteMeals.isEmpty){
      return Center(child:  Text("No favorates has added yet.!"),);
    }
    else{
        return ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem.name(
                  favoriteMeals[index].id,
                  favoriteMeals[index].title,
                 favoriteMeals[index].imageUrl,
                 favoriteMeals[index].duration,
                  favoriteMeals[index].complexity,
                  favoriteMeals[index].affordability,
                 );
            },
            itemCount: favoriteMeals.length);
    }

  }
}
