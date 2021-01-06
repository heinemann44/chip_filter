import 'package:chip_filter/chip_filter_item.dart';
import 'package:flutter/material.dart';

typedef isSelectedChip<T> = bool Function(List<T> selectedValues, T value);

class ChipFilter<T> extends StatefulWidget {
  final String title;
  final List<T> selectedItems;
  final List<ChipItem<T>> items;
  final isSelectedChip isSelected;
  final double spacingChip;

  const ChipFilter({
    Key key,
    this.title,
    this.selectedItems,
    this.items,
    this.isSelected,
    this.spacingChip = 8.0,
  })  : assert(items != null),
        assert(selectedItems != null),
        super(key: key);

  @override
  _ChipFilterState createState() => _ChipFilterState();
}

class _ChipFilterState extends State<ChipFilter> {
  double get _spacingChip => this.widget.spacingChip;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: this._spacingChip,
      runSpacing: this._spacingChip,
      children: this._buildItems(),
    );
  }

  List<Widget> _buildItems() {
    return this.widget.items.map((item) {
      bool isSelected =
          this.widget.isSelected(this.widget.selectedItems, item.value);

      if (item.buildWidget != null) {
        return item.buildWidget(item, isSelected);
      }

      return ChipFilterItem(
        text: item.text,
        value: item.value,
        onTap: () {
          setState(() => item.onTap(item.value, isSelected));
        },
        chipDecoration: this._getChipDecoration(item, isSelected),
        textChipDecoration: this._getTextChipDecoration(item, isSelected),
      );
    }).toList();
  }

  Decoration _getChipDecoration(ChipItem item, bool isSelected) {
    Decoration defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
          color: isSelected ? Colors.white : Colors.black, width: 1.0),
      color: isSelected ? Colors.black : Colors.white,
    );

    if (item.copyDecoration != null) {
      return item.copyDecoration(defaultDecoration, isSelected);
    } else {
      return defaultDecoration;
    }
  }

  TextStyle _getTextChipDecoration(ChipItem item, bool isSelected) {
    TextStyle defaultDecoration = TextStyle(
      fontSize: 16.0,
      color: isSelected ? Colors.white : Colors.black,
    );

    if (item.copyTextDecoration != null) {
      return item.copyTextDecoration(defaultDecoration, isSelected);
    } else {
      return defaultDecoration;
    }
  }
}
