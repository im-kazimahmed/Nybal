import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool checkBoxValue;
  final Function onChangedFunction;
  final Color backgroundColor;
  final Color activeColor;

  const CustomSwitch({
    Key? key,
    required this.checkBoxValue,
    required this.onChangedFunction,
    required this.backgroundColor,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: (d)=> onChangedFunction(d),
      value: checkBoxValue,
      activeColor: activeColor,
      activeTrackColor: backgroundColor,
      inactiveTrackColor: backgroundColor,
    );
  }
}
