import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multi_selection_filter/multi_selection_filter.dart';

import 'constants/app_constants.dart';
import 'helper/helper.dart';
import 'models/food_item_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<FoodItemModel> foodItems = [];

  @override
  void initState() {
    initFoodItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItemModel> selectedFoodItems =
        foodItems.where((foodItem) => foodItem.isSelected).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildFilterWidget(),
          const SizedBox(height: 20),
          Expanded(
            child: selectedFoodItems.isNotEmpty
                ? _buildSelectedFoodChip(selectedFoodItems)
                : _buildNoFoodSelected(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: MultiSelectionFilter(
        title: AppConstants.titleSelectFood,
        textListToShow: foodItems.map((foodItem) => foodItem.foodName).toList(),
        selectedList: foodItems.map((foodItem) => foodItem.isSelected).toList(),
        okButtonText: AppConstants.ok,
        accentColor: randomColors[4],
        checkboxTitleBG: Colors.black87,
        checkboxCheckColor: Colors.white,
        checkboxTitleTextColor: Colors.white,
        doneButtonBG: randomColors[4],
        doneButtonTextColor: Colors.white,
        onOkPress: () {
          Navigator.pop(context);
        },
        onCheckboxTap: (name, index, isChecked) {
          setState(() {
            foodItems[index].isSelected = isChecked;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            color: randomColors[6],
            elevation: 4,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppConstants.filterFoodItems),
                  SizedBox(width: 16),
                  Icon(
                    Icons.fastfood_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedFoodChip(List<FoodItemModel> selectedFoodItems) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 12,
        children: List<Widget>.generate(selectedFoodItems.length, (int index) {
          return Chip(
            onDeleted: () => setState(() {
              selectedFoodItems[index].isSelected = false;
            }),
            labelPadding: const EdgeInsets.only(right: 5),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: selectedFoodItems[index].labelColor,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            label: Text(
              selectedFoodItems[index].foodName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            deleteIcon: const Icon(
              Icons.close,
              size: 20,
              color: Colors.white,
            ),
            backgroundColor: selectedFoodItems[index].labelColor,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNoFoodSelected(BuildContext context) {
    return Center(
        child: Text(
      AppConstants.selectFoodItem,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: Colors.black54),
    ));
  }

  void initFoodItems() {
    foodItems.add(FoodItemModel('Aloo Gobi', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Vada Pav', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Margherita Pizza', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Palak Paneer', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Bruschetta', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Mapo Tofu', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Chow Mein', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Sweet Potato Fries', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('French Fried', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Hot and Sour Soup', false,
        randomColors[Random().nextInt(randomColors.length)]));
    foodItems.add(FoodItemModel('Caprese salad', false,
        randomColors[Random().nextInt(randomColors.length)]));
  }
}
