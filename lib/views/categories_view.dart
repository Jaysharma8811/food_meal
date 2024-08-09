

import 'package:flutter/material.dart';
import 'package:foodmeal/views/meals_view.dart';

import 'package:foodmeal/widgets/categories_grid_item.dart';

import '../data/avilable_categories.dart';
import '../models/category_model.dart';
import '../models/meals_model.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({super.key,required this.onToggleFavourite});

  final void Function(Meal meal) onToggleFavourite;




  void _selectCategory(BuildContext context, Category category){
    
     final filterlist = dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MealsScreen(title: category.title, meals:filterlist, onToggleFavourite: onToggleFavourite, )));

  }

  @override
  Widget build(BuildContext context) {
  return GridView(
    padding: const EdgeInsets.all(24),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,

    ),
    children:  [
      for(final category in availableCategories)
        CategoryGridItem(category: category,selectCategory: (){
          _selectCategory(context,category);

        },)

    ],
  );
  }

}