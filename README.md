# Multi Selection Filter for Flutter

![Multi_selection_filter package poster](https://github-production-user-asset-6210df.s3.amazonaws.com/116786961/277310593-ce9f8f58-c264-4097-b1ea-f43144bac29c.png "Multi_selection_filter")

**Multi Selection Filter** is a versatile Flutter package that allows you to present a list of items within a dialog box, giving users the ability to select or unselect items for various purposes. This dialog box is highly customizable to suit your needs.

##  Features

 -   Compatibility with Flutter 3.13
 -   Checkbox list for easy item selection
 -   Comprehensive customization options
 -   Built-in search functionality for quick item retrieval within the dialog
 -   Option to display removable chips for added user convenience

</br>
 <img width="447" alt="Screenshot" src="https://github.com/solguruz/multi_selection_filter/assets/116786961/37aca9f0-ff6c-4f05-b033-759eda7a0733"> <img width="447" alt="Design" src="https://github.com/solguruz/multi_selection_filter/assets/116786961/1d9d0dc8-bf73-4712-afad-0ae98b6b6be3">

## Installation

Add the `multi_selection_filter` dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  multi_selection_filter: ^0.0.3

```

## Usage

 1. Create a Map with items and their initial selection status:

```dart
 Map<String, bool> foodItems = {};

  @override
  void initState() {
    super.initState();
    foodItems.putIfAbsent("Aloo Gobi", () => false);
    foodItems.putIfAbsent("Margherita Pizza", () => false);
    foodItems.putIfAbsent("Hot and Sour Soup", () => false);
    foodItems.putIfAbsent("Bruschetta", () => false);
    foodItems.putIfAbsent("Mapo Tofu", () => false);
  }
```

2. Show the dialog using the list created above:

```dart
 MultiSelectionFilter(
        title: "Select your favorite Food",
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
```
