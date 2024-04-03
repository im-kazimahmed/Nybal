import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/local_data_helper.dart';
import '../widgets/theme_data.dart';
import 'auth_controller.dart';
import 'home_screen_controller.dart';

class NavigationController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isProfileView = false;

  RxBool isPotentialBtnHovered = false.obs;
  RxBool isNewMembersBtnHovered = false.obs;
  RxBool isOnlineHovered = false.obs;
  RxBool isSearchHovered = false.obs;
  RxString selectedPage = "".obs;

  RxInt previousIndex = RxInt(1);
  RxInt selectedIndex = RxInt(0);
  int selectedNavIndex = 1;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void onDrawerChange() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void isProfileViewf(bool val) {
    isProfileView = val;
    update();
  }

  void clearAllHover() {
    isNewMembersBtnHovered.value = false;
    isOnlineHovered.value = false;
    isPotentialBtnHovered.value = false;
    isSearchHovered.value = false;
  }

  void handleIndexChanged(int i) {
    selectedNavIndex = 1;
    selectedIndex.value = i;
    update();
  }

  void handleNavIndexChanged(int i) {
    if(i == 2) {
      Get.defaultDialog(
        title: "Logging out",
        onCancel: () => Get.back(),
        onConfirm: () => logout(),
        content: const Text("Are you sure you want to log out ?"),
        contentPadding: const EdgeInsets.all(30.0),
        cancelTextColor: Colors.black,
        confirmTextColor: Colors.white,
        buttonColor: AppColors.pinkButton,
        // confirm: Container(
        //   decoration: BoxDecoration(
        //     color: AppColors.pinkButton,
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        //   child: const Text("Yes"),
        // ),
        // cancel: InkWell(
        //   onTap: () {
        //
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: AppColors.pinkButton,
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        //     child: const Text("No"),
        //   ),
        // )
      );
    } else {
      isProfileViewf(false);
      selectedNavIndex = i;
    }
    update();
  }

  logout() {
    Get.back();
    selectedNavIndex = 2;
    update();
    Future.delayed(const Duration(seconds: 2), () {
      _authController.signOut();
      AuthController.authInstance.signOut();
      selectedNavIndex = 1;
      LocalDataHelper().saveIsSessionExpired(true);
      update();
    });
  }

}
