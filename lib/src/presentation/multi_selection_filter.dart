import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/item_model.dart';
import '../style/app_text_style.dart';
import '../utils/size_util.dart';
import 'common/common_widgets.dart';

class MultiSelectionFilter extends StatefulWidget {
  const MultiSelectionFilter({
    super.key,
    required this.title,
    required this.textListToShow,
    required this.selectedList,
    required this.onOkPress,
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
    this.okButtonText = AppConstants.ok,
    this.doneButtonText = AppConstants.done,
    this.searchHint = AppConstants.searchHint,
  });
  final List<String> textListToShow;
  final List<bool?> selectedList;
  final String title;
  final String searchHint;
  final String okButtonText;
  final Widget child;
  final Function onOkPress;
  final String doneButtonText;
  final bool showChips;
  final Color closeIconBG,
      closeIconColor,
      accentColor,
      checkboxTitleBG,
      checkboxCheckColor,
      checkboxTitleTextColor,
      doneButtonBG,
      doneButtonTextColor;
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.selectedList.length != widget.textListToShow.length
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Item selected list must be same length as Title list'),
              ),
            )
          : buildMultiSelectionDialog(),
      child: widget.child,
    );
  }

  buildMultiSelectionDialog() {
    TextEditingController searchTextController = TextEditingController();
    bool showingFromSearch = false;
    List<ItemModel> itemModels = [];
    List<ItemModel> searchedItemModels = [];
    void createListAllElements() {
      itemModels = [];
      for (var i = 0; i < widget.textListToShow.length; i++) {
        itemModels.add(ItemModel(
            i, widget.textListToShow[i], widget.selectedList[i] ?? false));
      }
    }

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

    void onItemSelected(int id, bool isSelected) {
      int index = itemModels.indexWhere((model) => model.id == id);
      itemModels[index].isSelected = !itemModels[index].isSelected;
      widget.onCheckboxTap(itemModels[index].itemName, index, isSelected);
    }

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
                      buildDialogTopSearch(
                          searchTextController, context, onSearched),
                      verticalSpace(context, 0.02),
                      buildDialogList(showingFromSearch, searchedItemModels,
                          itemModels, setState, onItemSelected),
                      verticalSpace(context, 0.02),
                      if (SizeUtil.bottom == 0 && widget.showChips)
                        buildDialogChips(
                            context, itemModels, setState, onItemSelected),
                      verticalSpace(
                          context,
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? 0.02
                              : 0),
                      if (MediaQuery.of(context).viewInsets.bottom == 0)
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
