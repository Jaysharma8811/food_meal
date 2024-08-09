import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:foodmeal/views/meal_detail_view.dart';
import 'package:foodmeal/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meals_model.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.onToggleFavourite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavourite;
  String get complexityText{
    return meal.complexity.name[0].toUpperCase()+meal.complexity.name.substring(1);
  }
  String get affordabilityText{
    return meal.affordability.name[0].toUpperCase()+meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealDetailScreen(meal: meal,onToggleFavourite: onToggleFavourite,)));

        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width:double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(icon: Icons.schedule, lable: "${meal.duration} mins"),
                        const SizedBox(width: 12,),
                        MealItemTrait(icon: Icons.work, lable: complexityText),
                        const SizedBox(width: 12,),
                        MealItemTrait(icon: Icons.attach_money, lable: affordabilityText),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
