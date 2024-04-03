import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/user_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../helpers/local_data_helper.dart';
import '../models/config_model.dart';
import '../models/country_model.dart';
import '../models/religion_model.dart';
import '../repository/repository.dart';
import '../utils/app_tags.dart';
import '../utils/validators.dart';
import '../views/dashboards/dashboard.dart';
import 'navigation_controller.dart';

class DisableProfileController extends GetxController {
  final SettingController settingController = Get.find<SettingController>();
  final UserController userController = Get.find<UserController>();
  final NavigationController navController = Get.find<NavigationController>();
  RxInt currentStep = 1.obs;
  RxInt stepLength = 3.obs;
  RxBool complete = false.obs;

  // Step One
  RxBool startFromScratch = false.obs;
  RxBool silentMode = false.obs;
  RxBool takeSomeTime = false.obs;
  RxBool improvePrivacy = false.obs;
  RxBool deleteAccount = false.obs;

  // Step Two
  RxBool imNotSingleAnyMore = false.obs;
  RxBool pageNotWorkingProperly = false.obs;
  RxBool iDontLikeThePage = false.obs;
  RxBool iWantToStartFromScratch = false.obs;
  RxBool imLookingSomethingDifferent = false.obs;

  // Step three
  TextEditingController feedback = TextEditingController();

  @override
  void onInit() {
    // _promptPermissionSetting();
    super.onInit();
  }

  next() {
    if (currentStep.value <= stepLength.value) {
      goTo(currentStep.value + 1);
    }
  }

  back() {
    if (currentStep.value > 1) {
      goTo(currentStep.value - 1);
    }
  }

  goTo(int step) {
    // additionalFields?.isPartnerSpecsEnabled = true;
    // showShortToast("City is required");


    currentStep.value = step;
    if (currentStep.value > stepLength.value) {
      complete.value = true;
    }
    update();
  }

  ////// Step One
  onStartFromScratchChange(value){
    startFromScratch.value = value!;
    update();
  }
  onSilentModeChange(value){
    silentMode.value = value!;
    update();
  }
  onTakeSomeTimeChange(value){
    takeSomeTime.value = value!;
    update();
  }
  onImprovePrivacyChange(value){
    improvePrivacy.value = value!;
    update();
  }
  onDeleteAccountChange(value){
    deleteAccount.value = value!;
    update();
  }
  ///// End Step One


  //// Step Two
  onImNotSingleAnymoreChange(value){
    imNotSingleAnyMore.value = value!;
    update();
  }
  onPageNotWorkingChange(value){
    pageNotWorkingProperly.value = value!;
    update();
  }
  onIDontLikeThePageChange(value){
    iDontLikeThePage.value = value!;
    update();
  }
  onIWantToStartFromScratchChange(value){
    iWantToStartFromScratch.value = value!;
    update();
  }
  onLookingSomethingDifferentChange(value){
    imLookingSomethingDifferent.value = value!;
    update();
  }



// Future<bool?> wifeRegistration() async {
  //   UserDataModel? updatedUser = await Repository().wifeRegistration(
  //     firstName: firstNameController.text,
  //     lastName: lastNameController.text,
  //     userName: userNameController.text,
  //     email: emailController.text,
  //     gender: selectedGender.value == "Male" ? 1: 2,
  //     password: passwordController.text,
  //     wifeOf: "${userController.userData.user?.firstName ?? userController.userData.user?.username}"
  //   );
  //   if(updatedUser != null) {
  //     userController.userData.user = updatedUser;
  //     navController.selectedNavIndex = 1;
  //     navController.selectedIndex(0);
  //     Get.offAll(()=> DashBoardScreen());
  //     return true;
  //   } else {
  //     return null;
  //   }
  // }
}
