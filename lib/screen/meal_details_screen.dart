import 'package:flutter/material.dart';
import 'package:meal_app/models/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = "/meal-details";
  final Function favoriteMeal ;
  final Function isFavorite ;
  const MealDetailsScreen(this.favoriteMeal,this.isFavorite, {Key? key}) : super(key: key);

  Widget buildSectionsTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: ThemeData.light().textTheme.bodyText1,
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black87)),
      padding: EdgeInsets.all(4),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    final title = argument['title'];
    final mealID = argument['id'];
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealID);
    return Scaffold(
      appBar: AppBar(title: Text(title.toString())),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InteractiveViewer(panEnabled:true ,
              constrained: true,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buildSectionsTitle(context, "Ingredient"),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  color: Theme.of(context).cardColor,
                  child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(selectedMeal.ingredients[index],
                          textAlign: TextAlign.center)),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionsTitle(context, "Steps"),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    Column(children: [
                  ListTile(
                    leading: CircleAvatar(child: Text('#${index + 1}')),
                    title: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(selectedMeal.steps[index],
                            textAlign: TextAlign.center)),
                    trailing: const Icon(Icons.no_food_rounded,
                        color: Colors.redAccent),
                  ),
                  Divider()
                ]),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          favoriteMeal(mealID);
        },
          //Navigator.of(context).pop(mealID);
        backgroundColor: Colors.yellow,
        child:  Icon(isFavorite(mealID) ?Icons.star:  Icons.star_border),
      ),
    );
  }
}
