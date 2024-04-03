import 'package:flutter/material.dart';

class CustomModelDropDown<T> extends StatelessWidget {
  final List<T> options;
  final Color backgroundColor;
  final Color selectedValueColor;
  final Color? arrowColor;
  final IconData arrowIcon;
  final bool isArrowOnLeft;
  final Function(T) onOptionChange;
  final String Function(T) optionLabel;
  final T selectedValue;

  const CustomModelDropDown({
    Key? key,
    required this.backgroundColor,
    required this.options,
    required this.onOptionChange,
    required this.selectedValueColor,
    this.arrowColor,
    required this.arrowIcon,
    required this.isArrowOnLeft,
    required this.optionLabel,
    required this.selectedValue,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: (T value) {
        onOptionChange(value);
      },
      itemBuilder: (BuildContext context) {
        return options.map((T choice) {
          return PopupMenuItem<T>(
            value: choice,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                optionLabel(choice),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(isArrowOnLeft)
              Icon(
                arrowIcon,
                color: arrowColor
              ),
            Text(
              optionLabel(selectedValue),
              style: TextStyle(color: selectedValueColor),
            ),
            if(!isArrowOnLeft)
              Icon(
                arrowIcon,
                // Icons.keyboard_arrow_down,
                color: arrowColor,
                // Color(0xffCC1262)
              ),
          ],
        ),
      ),
    );
  }
}
