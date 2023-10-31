# Multi Selection Filter for Flutter

![Multi_selection_filter package poster](https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/select_multi_filter_main.png)

**Multi Selection Filter** is a versatile Flutter package that allows you to present a list of items within a dialog box, giving users the ability to select or unselect items for various purposes. This dialog box is highly customizable to suit your needs.

##  Features

-   Compatibility with Flutter 3.13
-   Checkbox list for easy item selection
-   Comprehensive customization options
-   Built-in search functionality for quick item retrieval within the dialog
-   Option to display removable chips for added user convenience

</br>
<p align="center">
<img alt="Screenshot" src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/multi_select_filter_1.png" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
<img alt="Screenshot" src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/multi_select_filter_2.png"  width="45%">
</p>

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
        accentColor: const Color(0xFF01b4e4),
        checkboxTitleBG: Colors.black87,
        checkboxCheckColor: Colors.white,
        checkboxTitleTextColor: Colors.white,
        doneButtonBG: const Color(0xFF01b4e4),
        doneButtonTextColor: Colors.white,
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

## 🚀 About Us

Engineering Quality Solutions by employing technologies with Passion and Love | Web and Mobile App Development Company in India and Canada.

## 🔗 Links

<div align="left">

<a href="https://solguruz.com/" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/solguruz.svg" alt="Solguruz" style="margin-bottom: 5px;" />
</a>

<a href="https://www.facebook.com/SolGuruzHQ" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/facebook.svg" alt="Solguruz on Facebook" style="margin-bottom: 5px;" />
</a>

<a href="https://www.linkedin.com/company/solguruz/" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/linkedin.svg" alt="Solguruz on Linkedin" style="margin-bottom: 5px;" />
</a>

<a href="https://www.instagram.com/solguruz/" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/instagram.svg" alt="Solguruz on Instagram" style="margin-bottom: 5px;" />
</a>

<a href="https://twitter.com/SolGuruz" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/twitter.svg" alt="Solguruz on Twitter" style="margin-bottom: 5px;" />
</a>

<a href="https://www.behance.net/solguruz" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/behance.svg" alt="Solguruz on Behance" style="margin-bottom: 5px;" />
</a>

<a href="https://dribbble.com/SolGuruz" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/dribbble.svg" alt="Solguruz on Dribble" style="margin-bottom: 5px;" />
</a>

<a href="https://solguruz.com/hire-flutter-developers/" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/hire_flutter_developer.svg" alt="Hire Flutter Developers" style="margin-bottom: 5px;" />
</a>

<a href="https://solguruz.com/services/flutter-app-development" target="_blank">
    <img src="https://raw.githubusercontent.com/solguruz/multi_selection_filter/main/.github/explore_our_flutter_service.svg" alt="Flutter App Development" style="margin-bottom: 5px;" />
</a>

</div>

## License

```text
MIT License

Copyright (c) 2023 SolGuruz LLP

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
