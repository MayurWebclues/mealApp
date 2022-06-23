import 'package:flutter/material.dart';
import 'package:meal_app/widget/category_item.dart';

import '../models/dummy_data.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: GridView(
          children: DUMMY_CATEGORIES
              .map((catData) => CategoryItem(
              id: catData.id, title: catData.title, color: catData.color))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
        ),
      )

    );
  }
}
