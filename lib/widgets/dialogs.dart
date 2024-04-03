import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/theme_data.dart';

class Dialogs {

  static void showAlertDialog(String title, String content) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: Text(content),
      title: title,
    );
  }

  static void showLoadingDialog() {
    Get.dialog(
      Center(
        child: Container(
          color: Colors.transparent,
          child: const SpinKitPumpingHeart(
            color: AppColors.pinkButton,
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showDefaultDialogue(
    {
      required String title,
      required String middleText,
      required Function() onConfirmation,
    }) {
    Get.defaultDialog(
      title: title,
      middleText: middleText,
      backgroundColor: AppColors.pinkButton,
      titleStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      middleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      radius: 30,
      onConfirm: onConfirmation,
      buttonColor: Colors.white,
      confirmTextColor: AppColors.pinkButton,
    );
  }


}


class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: const SpinKitPumpingHeart(
          color: AppColors.pinkButton,
        ),
      ),
    );
  }
}
