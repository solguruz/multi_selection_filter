import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/item_model.dart';
import '../style/app_text_style.dart';
import '../utils/size_util.dart';
import 'common/common_widgets.dart';

/// Multi Selection Filter is a very handy tool to showing multiple items
/// inside a dialog box. Users can select or unselect this items for a
/// specific purpose. This dialog box is also a fully customizable.

class MultiSelectionFilter extends StatefulWidget {
  const MultiSelectionFilter({
    super.key,
    required this.title,
    required this.textListToShow,
    required this.selectedList,
    required this.onCheckboxTap,
    required this.child,
    required this.accentColor,
    required this.checkboxTitleBG,
    required this.checkboxCheckColor,
    required this.checkboxTitleTextColor,
    required this.doneButtonBG,
    required this.doneButtonTextColor,
    this.showChips = true,
    this.onDoneButtonPressed,
    this.closeIconBG = Colors.black,
    this.closeIconColor = Colors.white,
    this.doneButtonText = AppConstants.done,
    this.searchHint = AppConstants.searchHint,
  });

  /// List of String for dialog item titles
  final List<String> textListToShow;

  /// List of bool for whether current item is selected or not
  final List<bool?> selectedList;

  /// Dialog box title
  final String title;

  /// Hint for search TextField
  final String searchHint;

  /// Creates a widget which will show this dialog box upon clicked.
  final Widget child;

  /// Title for done button in dialog
  final String doneButtonText;

  /// Whether to show a chips of selected items
  final bool showChips;

  ///Background color for close icon
  final Color closeIconBG;

  /// Tint color for close icon
  final Color closeIconColor;

  /// Accent color for dialog box UI
  final Color accentColor;

  /// Background color for checkbox title
  final Color checkboxTitleBG;

  /// Tint color for checkbox check icon
  final Color checkboxCheckColor;

  /// Text color for checkbox title
  final Color checkboxTitleTextColor;

  /// Background color for done button
  final Color doneButtonBG;

  /// Text color for done button
  final Color doneButtonTextColor;

  /// Get callback when filter applied
  final Function(
    String,
    int,
    bool,
  ) onCheckboxTap;
  final Function? onDoneButtonPressed;

  @override
  State<MultiSelectionFilter> createState() => _MultiSelectionFilterState();
}

class _MultiSelectionFilterState extends State<MultiSelectionFilter> {
  /// Search TextField text controller
  TextEditingController searchTextController = TextEditingController();

  /// Whether to show list items from search
  bool showingFromSearch = false;

  /// List of all items
  List<ItemModel> itemModels = [];

  /// List of searched items
  List<ItemModel> searchedItemModels = [];

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => buildMultiSelectionDialog(),
      child: widget.child,
    );
  }

  /// Creates the Multi selection filter dialog
  buildMultiSelectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        createListAllElements();

        return StatefulBuilder(builder: (context, setState) {
          void onSearched(String value) {
            if (value.isNotEmpty) {
              createListSearchedValue(value);
              showingFromSearch = true;
            } else {
              showingFromSearch = false;
            }
            setState(() {});
          }

          SizeUtil().init(context);
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              children: [
                Text(
                  widget.title,
                  style: bodyMediumTextStyle(context),
                ),
                const Spacer(),
                buildRoundCloseButton(
                  iconColor: widget.closeIconColor,
                  iconBackgroundColor: widget.closeIconBG,
                  onCloseButtonTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        SizeUtil.setDynamicHeight(context: context, value: 0.8),
                  ),
                  child: Column(
                    children: [
                      /// Shows a Search box on top of dialog
                      buildDialogTopSearch(
                          searchTextController, context, onSearched),
                      verticalSpace(context, 0.02),

                      /// Main list of items with Text and Checkbox
                      buildDialogList(showingFromSearch, searchedItemModels,
                          itemModels, setState, onItemSelected),
                      verticalSpace(context, 0.02),

                      /// Shows a chips UI at the bottom
                      /// Will help to easily find which item are checked
                      /// Although it can be hide by making `showChips` to false
                      if (SizeUtil.bottom == 0 && widget.showChips)
                        buildDialogChips(
                            context, itemModels, setState, onItemSelected),
                      verticalSpace(
                          context,
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? 0.02
                              : 0),
                      if (MediaQuery.of(context).viewInsets.bottom == 0)

                        /// Creates an Apply filter button
                        customMaterialButton(
                          context: context,
                          backgroundColor: widget.doneButtonBG,
                          textColor: widget.doneButtonTextColor,
                          text: widget.doneButtonText,
                          onPressed: widget.onDoneButtonPressed ??
                              () => Navigator.of(context).pop(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  /// Creates a list for all items
  void createListAllElements() {
    /// Checks list items has corresponding bool items
    /// for particular item is either selected or unselected
    assert(widget.selectedList.length == widget.textListToShow.length);

    itemModels = [];
    for (var i = 0; i < widget.textListToShow.length; i++) {
      itemModels.add(ItemModel(
          i, widget.textListToShow[i], widget.selectedList[i] ?? false));
    }
  }

  /// Perform a search on dialog list
  void createListSearchedValue(String value) {
    searchedItemModels = [];
    for (var i = 0; i < widget.textListToShow.length; i++) {
      if (widget.textListToShow[i]
          .toLowerCase()
          .contains(value.toLowerCase())) {
        searchedItemModels.add(itemModels[i]);
      }
    }
  }

  /// Updates list when item is selected or unselected
  /// and also sends a callback for the same
  void onItemSelected(int id, bool isSelected) {
    int index = itemModels.indexWhere((model) => model.id == id);
    itemModels[index].isSelected = !itemModels[index].isSelected;
    widget.onCheckboxTap(itemModels[index].itemName, index, isSelected);
  }

  /// Creates the search bar
  TextField buildDialogTopSearch(TextEditingController searchTextController,
      BuildContext context, void Function(String value) onSearched) {
    return TextField(
      controller: searchTextController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      cursorColor: widget.accentColor,
      style: bodyLargeTextStyle(context),
      maxLength: TextField.noMaxLength,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        filled: true,
        hintText: widget.searchHint,
      ),
      onChanged: (v) => onSearched(v),
    );
  }

  /// Creates a list of dialog items
  Widget buildDialogList(
      bool showingFromSearch,
      List<ItemModel> searchedItemModels,
      List<ItemModel> itemModels,
      StateSetter setState,
      void Function(int id, bool isSelected) onItemSelected) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:
            showingFromSearch ? searchedItemModels.length : itemModels.length,
        itemBuilder: (context, index) {
          ItemModel itemModel =
              showingFromSearch ? searchedItemModels[index] : itemModels[index];
          return buildCheckboxWithTitle(
              context: context,
              title: itemModel.itemName,
              checkboxValue: itemModel.isSelected,
              backgroundColor: widget.checkboxTitleBG,
              shadowColor: widget.checkboxTitleBG.withOpacity(0.1),
              checkboxActiveColor: widget.accentColor,
              checkboxCheckColor: widget.checkboxCheckColor,
              textColor: widget.checkboxTitleTextColor,
              onCheckboxChanged: (isSelected) {
                setState(
                  () => onItemSelected(itemModel.id, isSelected),
                );
              },
              onTap: () {
                setState(
                  () => onItemSelected(itemModel.id, !itemModel.isSelected),
                );
              });
        },
      ),
    );
  }

  /// Creates a chips of selected items inside dialog box
  Widget buildDialogChips(
      BuildContext context,
      List<ItemModel> itemModels,
      StateSetter setState,
      void Function(int id, bool isSelected) onItemSelected) {
    return Container(
      height: MediaQuery.of(context).size.longestSide * 0.2,
      alignment: Alignment.center,
      child: itemModels.isNotEmpty
          ? SingleChildScrollView(
              child: buildSelectedListChip(
                context: context,
                chipBackgroundColor: widget.checkboxTitleBG,
                closeIconColor: widget.accentColor,
                textColor: widget.checkboxTitleTextColor,
                checkedListForChip:
                    itemModels.where((element) => element.isSelected).toList(),
                onChipDeleted: (selectedModel) {
                  setState(
                    () {
                      onItemSelected(selectedModel.id,
                          !itemModels[selectedModel.id].isSelected);
                    },
                  );
                },
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
