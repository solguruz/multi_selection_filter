import 'package:flutter/material.dart';

import '../../models/item_model.dart';
import '../../utils/size_util.dart';
import '../../style/app_text_style.dart';

/// Creates a horizontal dynamic blank space
Widget horizontalSpace(BuildContext context, double horizontalSpace) {
  return SizedBox(
    width: MediaQuery.of(context).size.shortestSide * horizontalSpace,
  );
}

/// Creates a vertical dynamic blank space
Widget verticalSpace(BuildContext context, double verticalSpace) {
  return SizedBox(
    height: MediaQuery.of(context).size.longestSide * verticalSpace,
  );
}

Widget buildSelectedListChip({
  required BuildContext context,
  required Color chipBackgroundColor,
  required Color closeIconColor,
  required Color textColor,
  required List<ItemModel> checkedListForChip,
  required Function onChipDeleted,
}) {
  List<Widget> chips = [];

  for (int i = 0; i < checkedListForChip.length; i++) {
    var value = checkedListForChip[i];
    Chip filterChip = Chip(
      elevation: 0,
      label: Text(value.itemName,
          style: bodyMediumTextStyle(context).copyWith(color: textColor)),
      shape: StadiumBorder(
        side: BorderSide(
          color: chipBackgroundColor,
        ),
      ),
      backgroundColor: chipBackgroundColor,
      deleteIcon: Icon(
        Icons.close,
        size: 20,
        color: closeIconColor,
      ),
      onDeleted: () {
        onChipDeleted(checkedListForChip[i]);
      },
    );

    chips.add(
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: filterChip,
      ),
    );
  }
  return Wrap(
    children: chips,
  );
}

Widget customMaterialButton({
  required context,
  required Color backgroundColor,
  required Color textColor,
  required text,
  required onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: MaterialButton(
      elevation: 5,
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtil.setLongestSide(context: context, value: 0.02),
      ),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: bodyMediumTextStyle(context).copyWith(color: textColor),
      ),
    ),
  );
}

Widget buildRoundCloseButton(
    {required Color iconColor,
    required Color iconBackgroundColor,
    required Function onCloseButtonTap}) {
  return Container(
    decoration:
        BoxDecoration(color: iconBackgroundColor, shape: BoxShape.circle),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCloseButtonTap(),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            Icons.close,
            color: iconColor,
            size: SizeUtil.sizeHeight(16),
          ),
        ),
      ),
    ),
  );
}

Widget buildCheckboxWithTitle({
  required BuildContext context,
  required String title,
  required bool checkboxValue,
  required Color backgroundColor,
  required Color shadowColor,
  required Color checkboxActiveColor,
  required Color checkboxCheckColor,
  required Color textColor,
  required Function onCheckboxChanged,
  required Function onTap,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: SizeUtil.sizeHeight(5),
    ),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(
        SizeUtil.sizeWidth(20),
      ),
      boxShadow: [
        BoxShadow(
          color: shadowColor,
          blurRadius: SizeUtil.sizeWidth(10),
          spreadRadius: SizeUtil.sizeWidth(5),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          SizeUtil.sizeWidth(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Row(
            children: [
              Checkbox(
                activeColor: checkboxActiveColor,
                checkColor: checkboxCheckColor,
                fillColor: MaterialStateProperty.all(checkboxActiveColor),
                value: checkboxValue,
                onChanged: (value) => onCheckboxChanged(value),
              ),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  style: titleMediumTextStyle(context).copyWith(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => onTap(),
      ),
    ),
  );
}
