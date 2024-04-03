import 'package:flutter/material.dart';

class NxIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double? iconSize;
  final Color? bgColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? width;
  final double? height;

  const NxIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.bgColor,
    this.padding,
    this.iconSize,
    this.borderRadius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius ?? 0,
            ),
          ),
        ),
        child: Icon(
          icon,
          size: iconSize ?? 24,
          color: iconColor ?? Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
