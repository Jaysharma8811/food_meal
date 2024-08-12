import 'package:flutter/material.dart';
import 'package:foodmeal/data/avilable_categories.dart';
import 'package:foodmeal/models/meals_model.dart';
import 'package:foodmeal/views/categories_view.dart';
import 'package:foodmeal/views/filter_view.dart';
import 'package:foodmeal/views/meals_view.dart';
import 'package:foodmeal/widgets/main_drawer.dart';

const kInitialFilters={
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegetarian:false,
  Filter.vegan:false
};

class TapScreen extends StatefulWidget {
  const TapScreen({super.key});

  @override
  State<TapScreen> createState() {
    return _TapScreenState();
  }
}

class _TapScreenState extends State<TapScreen> {
  final List<Meal> _favouriteMeals = [];
  Map<Filter,bool> _selectedFilters=kInitialFilters;

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealsFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfo("Meal is no longer favourite!");
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfo("meal marked as a favourite");
      });
    }
  }

  int _selectedPageindex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageindex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {

     final result = await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) =>  FilterScreen(currentFilters: _selectedFilters,),
        ),
      );
     setState(() {
       _selectedFilters=result??kInitialFilters;

     });
    }
  }

  @override
  Widget build(BuildContext context) {

    final availableMeals=dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      onToggleFavourite: _toggleMealsFavouriteStatus,
    );
    var activePageTitle = "Categories";
    if (_selectedPageindex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealsFavouriteStatus,
      );
      activePageTitle = "Your favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageindex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
