import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nybal/widgets/theme_data.dart';

class NxFilledButton extends StatelessWidget {
  const NxFilledButton({
    Key? key,
    this.bgColor,
    this.borderRadius,
    required this.label,
    this.prefix,
    this.suffix,
    this.labelColor,
    this.onTap,
    this.padding,
    this.fontSize,
    this.width,
    this.height,
    this.labelStyle,
  }) : super(key: key);

  final Color? bgColor;
  final double? borderRadius;
  final String label;
  final Color? labelColor;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 56.r,
        padding: padding,
        constraints: BoxConstraints(maxWidth: Get.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
          color: bgColor ?? AppColors.pinkButton,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) prefix!,
            if (prefix != null) SizedBox(width: 4.r),
            Text(
              label,
              // style: labelStyle ??
              //     AppStyles.style16Bold.copyWith(
              //       color: labelColor ?? ColorValues.whiteColor,
              //       fontSize: fontSize ?? 16.r,
              //     ),
            ),
            if (suffix != null) SizedBox(width: 4.r),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}
