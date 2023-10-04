import 'package:flutter/material.dart';
import 'package:multi_selection_filter/multi_selection_filter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Favorite Foods",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  Map<String, bool> foodItems = {};

  @override
  void initState() {
    foodItems.putIfAbsent("Aloo Gobi", () => false);
    foodItems.putIfAbsent("Margherita Pizza", () => false);
    foodItems.putIfAbsent("Hot and Sour Soup", () => false);
    foodItems.putIfAbsent("Bruschetta", () => false);
    foodItems.putIfAbsent("Mapo Tofu", () => false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Multi Selection Filter"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildFilterWidget(),
          const SizedBox(height: 20),
          Expanded(
            child: foodItems.values.contains(true)
                ? _buildSelectedFoodChip()
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
        title: "Select Food",
        textListToShow: foodItems.keys.toList(),
        selectedList: foodItems.values.toList(),
        okButtonText: "Ok",
        accentColor: const Color(0xFF01b4e4),
        checkboxTitleBG: Colors.black87,
        checkboxCheckColor: Colors.white,
        checkboxTitleTextColor: Colors.white,
        doneButtonBG: const Color(0xFF01b4e4),
        doneButtonTextColor: Colors.white,
        onOkPress: () => Navigator.pop(context),
        onCheckboxTap: (key, index, isChecked) {
          setState(() {
            foodItems[key] = isChecked;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            color: Colors.blueGrey.shade700,
            elevation: 4,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Filter Food items",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 16),
                  Icon(
                    Icons.fastfood_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedFoodChip() {
    var selectedFoodItems = foodItems.entries.where((element) => element.value);
    return ListView.builder(
      itemCount: selectedFoodItems.length,
      itemBuilder: (context, index) {
        return Chip(
          onDeleted: () => setState(() {
            foodItems[selectedFoodItems.toList()[index].key] = false;
          }),
          backgroundColor: const Color(0xFFFDCB47),
          labelPadding: const EdgeInsets.only(right: 5),
          label: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              selectedFoodItems.toList()[index].key,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          deleteIcon: const Icon(
            Icons.close,
            size: 20,
            color: Colors.black,
          ),
        );
      },
    );
  }

  Widget _buildNoFoodSelected(BuildContext context) {
    return Center(
        child: Text(
      "Please select Food item",
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: Colors.black54),
    ));
  }
}
