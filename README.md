
#  [Multi_selection_filter](https://pub.dev/packages/multi_selection_filter)

A package that will help you to create multi selection filter dialog in Flutter.

![Multi_selection_filter package poster](https://github.com/solguruz/multi_selection_filter/assets/116786961/4c37b351-b632-40c7-970b-1cc9f609f5e2 "Multi_selection_filter")

##  Features

- Flutter 3.10 compatible
- Checkbox list for selection
- Search functionality within the dialog
- You can also display Chips for easily remove items from list

## How to Use

```yaml
# add this line to your dependencies
multi_selection_filter: ^0.0.2
```

```dart
      MultiSelectionFilter(
        title: 'Select Food',
        textListToShow: foodItems.map((foodItem) => foodItem.foodName).toList(),
        selectedList: foodItems.map((foodItem) => foodItem.isSelected).toList(),
        okButtonText: 'Ok',
        accentColor: Colors.blue,
        checkboxTitleBG: Colors.black87,
        checkboxCheckColor: Colors.white,
        checkboxTitleTextColor: Colors.white,
        doneButtonBG: Colors.blue,
        doneButtonTextColor: Colors.white,
        onOkPress: () {
          Navigator.pop(context);
        },
        onCheckboxTap: (name, index, isChecked) {
          setState(() {
            foodItems[index].isSelected = isChecked;
          });
        },
        child: const Icon(
          Icons.filter_list,
          size: 32,
        ),
      ),
```
