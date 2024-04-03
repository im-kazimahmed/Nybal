import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/theme_data.dart';

class Logout_page extends StatelessWidget {
  const Logout_page({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: mainClr,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            radius: 20,
            color: Colors.red,
          ),
          SizedBox(height: 30),
          Text("Logging out ...")
        ],
      ),
    );
  }
}
