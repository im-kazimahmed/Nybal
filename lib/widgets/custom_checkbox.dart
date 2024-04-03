import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? textSize;
  final bool checkBoxValue;
  final Function onChangedFunction;
  final Color activeColor;
  final Color borderColor;
  final bool flipPosition;
  final MainAxisAlignment alignment;
  const CustomCheckBox({
    super.key,
    this.text,
    this.textColor,
    this.textSize,
    required this.checkBoxValue,
    required this.onChangedFunction,
    required this.activeColor,
    required this.borderColor,
    required this.flipPosition,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return flipPosition ? Row(
      mainAxisAlignment: alignment,
      children: [
        if(text != null)
          Text(
            text ?? "",
            style: TextStyle(
              color: textColor,
              overflow: TextOverflow.clip,
              fontSize: textSize,
            ),
          ),
        Checkbox(
          activeColor: activeColor,
          side: BorderSide(color: borderColor),
          value: checkBoxValue,
          onChanged: (value) {
            onChangedFunction(value);
          },
        ),
      ],
    ):Row(
      mainAxisAlignment: alignment,
      children: [
        Checkbox(
          activeColor: activeColor,
          side: BorderSide(color: borderColor),
          value: checkBoxValue,
          onChanged: (value) {
            onChangedFunction(value);
          },
        ),
        if(text != null)
          FittedBox(
            child: Text(
              text.toString(),
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
      ],
    );
  }
}
