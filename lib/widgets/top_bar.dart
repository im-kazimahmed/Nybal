import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                final navController = Get.find<NavigationController>();
                navController.handleNavIndexChanged(23);
              },
              child: SizedBox(
                height: Get.height / 15,
                width: Get.height / 15,
                child: const Image(
                  image: AssetImage("assets/images/iconMain.png"),
                ),
              ),
            ),
            InkWell(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: SizedBox(
                height: Get.height / 15,
                width: Get.height / 15,
                child:
                const Image(image: AssetImage("assets/images/menu.png")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
