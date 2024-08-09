import 'package:flutter/material.dart';
import 'package:foodmeal/models/meals_model.dart';
import 'package:foodmeal/views/categories_view.dart';
import 'package:foodmeal/views/meals_view.dart';

class TapScreen extends StatefulWidget {
  const TapScreen({super.key});

  @override
  State<TapScreen> createState() {
    return _TapScreenState();
  }
}

class _TapScreenState extends State<TapScreen> {

  final List<Meal> _favouriteMeals=[];
  void _showInfo(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  void _toggleMealsFavouriteStatus(Meal meal){
    final isExisting=_favouriteMeals.contains(meal);
    if(isExisting){
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfo("Meal is no longer favourite!");

      });

    }else{
      setState(() {
        _favouriteMeals.add(meal);
        _showInfo("meal marked as a favourite");

      });
    }
  }
  int _selectedPageindex=0;
  void _selectPage(int index){
    setState(() {
      _selectedPageindex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget activePage=  CategoriesScreen(onToggleFavourite: _toggleMealsFavouriteStatus,);
    var activePageTitle="Categories";
    if(_selectedPageindex==1){
       activePage= MealsScreen(title: "Favourites", meals: _favouriteMeals,onToggleFavourite: _toggleMealsFavouriteStatus,);
       activePageTitle="Your favourites";

    }
    return Scaffold(
      appBar: AppBar(
        title:  Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: _selectedPageindex,
        onTap: (index){
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(icon:Icon(Icons.set_meal) , label:'Categories' ),
          BottomNavigationBarItem(icon:Icon(Icons.star) , label:'Favorites' ),

        ],
      ),
    );
  }
}
