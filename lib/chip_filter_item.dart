import 'package:flutter/material.dart';

typedef copyChipItemDecoration = Decoration Function(Decoration decoration, bool isSelected);
typedef copyTextChipItemDecoration = TextStyle Function(TextStyle decoration, bool isSelected);
typedef buildChipItem<H> = Widget Function(ChipItem<H> item, bool isSelected);

class ChipItem<O> {
  final String text;
  final O value;
  final onTapChipFilter<O> onTap;
  final copyChipItemDecoration copyDecoration;
  final copyTextChipItemDecoration copyTextDecoration;
  final buildChipItem<O> buildWidget;

  ChipItem({
    this.text,
    this.value,
    this.onTap,
    this.copyDecoration,
    this.copyTextDecoration,
    this.buildWidget,
  });
}

typedef onTapChipFilter<V> = Function(V value, bool isSelected);

class ChipFilterItem<T> extends StatelessWidget {
  final String text;
  final T value;
  final Function onTap;
  final Decoration chipDecoration;
  final TextStyle textChipDecoration;

  ChipFilterItem({
    Key key,
    this.text,
    this.value,
    this.onTap,
    this.chipDecoration,
    this.textChipDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (this.onTap != null) {
          this.onTap();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: this.chipDecoration,
        child: Text(
          this.text ?? '',
          style: this.textChipDecoration,
        ),
      ),
    );
  }
}
