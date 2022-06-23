import 'package:flutter/material.dart';
import 'package:meal_app/screen/category_screen.dart';
import 'package:meal_app/screen/favorite_screen.dart';
import 'package:meal_app/widget/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
   final List<Meal> favoriteMeal;
   TabsScreen(this.favoriteMeal,{Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
   late List<Map<String, Object>> pages;

  int _selectedPageIndex = 0;

  @override
  initState(){
    pages = [
      {'page': CategoryScreen(), 'title': "Category"},
      {'page': FavoriteScreen(widget.favoriteMeal), 'title': "Your Favorite"}
    ];
   super.initState() ;
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  const MainDrawer(),
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex]['title'].toString()),
      ),
      body: pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColorLight,
        unselectedItemColor: Theme.of(context).cardColor,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite')
        ],
      ),
    );
  }
}
