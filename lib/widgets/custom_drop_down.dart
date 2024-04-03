import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> options;
  final Color backgroundColor;
  final Color selectedValueColor;
  final Function onOptionChange;
  final String selectedText;
  const CustomDropDown({
    super.key,
    required this.backgroundColor,
    required this.options,
    required this.onOptionChange,
    required this.selectedValueColor,
    required this.selectedText,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        onOptionChange(value);
      },
      itemBuilder: (BuildContext context) {
        return options.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                choice,
                style: const TextStyle(color: Colors.black), // Customize text color
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        color: backgroundColor, // Set the background color
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.arrow_downward,
              color: Color(0xffCC1262), // Customize arrow color
            ),
            Text(
              selectedText,
              style: TextStyle(color: selectedValueColor), // Customize text color
            ),
          ],
        ),
      ),
    );
  }
}
