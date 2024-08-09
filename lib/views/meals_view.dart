import 'package:flutter/material.dart';
import 'package:foodmeal/widgets/meal_item.dart';

import '../models/meals_model.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,  this.title, required this.meals,required this.onToggleFavourite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;


  @override
  Widget build(BuildContext context) {

    Widget content =Center(
      child: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nothing to show ..',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          Text(
            'Try something different...',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
          itemBuilder: (ctx, index) {
        return MealItem(meal: meals[index],onToggleFavourite: onToggleFavourite,);
      });
    }
    if(title==null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
