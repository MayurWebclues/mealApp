import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screen/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final String id ;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  //final Function removeItem;

  MealItem.name(this.id,this.title, this.imageUrl, this.duration, this.complexity,
      this.affordability);//this.removeItem

  String get getComplexity{
    switch(complexity){
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default :return 'Unknown';
    }
  }
  String get getAffordability{
    switch(affordability){
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      default :return 'Unknown';
    }
  }
  void selectMeal(BuildContext ctx) {
       Navigator.of(ctx).pushNamed(MealDetailsScreen.routeName,arguments:{'id': id,'title': title}).then((value) => {
         if(value!=null){
           //removeItem(value)
         }
       });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectMeal(context);
      } ,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(imageUrl,
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    fit: BoxFit.cover),
              ),
              Positioned(
                right: 5,
                bottom: 45,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.black45),
                  child: Text(
                    textAlign: TextAlign.end,
                    title,
                    style: TextStyle(
                        fontSize: 24,
                        overflow: TextOverflow.fade,
                        color: Colors.white),
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children:  [
                  Icon(Icons.schedule),
                  SizedBox(width: 6),
                  Text('$duration min')
                ],),
                Row(children:  [
                  Icon(Icons.work),
                  SizedBox(width: 6),
                  Text(getComplexity)
                ],),
                Row(children:  [
                  Icon(Icons.attach_money),
                  SizedBox(width: 6),
                  Text(getAffordability)
                ],)
              ],
            ),
          )
        ]),
      ),
    );
  }
}
