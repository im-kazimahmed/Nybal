import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/config_model.dart';
import 'package:nybal/models/country_model.dart';
import 'package:nybal/models/user_model.dart';
import 'package:nybal/routes/routes.dart';
import 'package:nybal/utils/encryption.dart';
import '../helpers/local_data_helper.dart';
import '../repository/repository.dart';
import '../utils/app_tags.dart';
import 'auth_controller.dart';
import 'language_controller.dart';

class SplashController extends GetxController {
  var isLoading = true.obs;
  final AuthController authController = Get.find<AuthController>();
  final UserController userController = Get.find<UserController>();
  final SettingController settingController = Get.find<SettingController>();
  final LanguageController langController = Get.find<LanguageController>();

  @override
  void onInit() async {
    super.onInit();
    handleConfigData();
    userController.getAllUsers();
    navigate();
  }

  Future<ConfigModel> handleConfigData() async {
    isLoading(true);
    return Repository().getConfigData().then((configModel) {
      LocalDataHelper().saveConfigData(configModel).then((value) {
        settingController.appConfig = configModel.appConfig;
        if(configModel.appConfig?.languages != null) {
          langController.languages.value = configModel.appConfig!.languages!;
        }
        if(configModel.appConfig?.discountOnSubscription != null) {
          settingController.discountOnSubscription.value = configModel.appConfig!.discountOnSubscription.toString();
        }
        if(configModel.appConfig?.discountOnSpotlight != null) {
          settingController.discountOnSpotlight.value = configModel.appConfig!.discountOnSpotlight.toString();
        }
        if(configModel.appConfig?.googleIosKey != null) {
          authController.googleConsoleIosApiKey.value = EncryptData.decrypt(configModel.appConfig!.googleIosKey.toString());
        }
        if(configModel.appConfig?.googleWebKey != null) {
          authController.googleConsoleWebApiKey.value = EncryptData.decrypt(configModel.appConfig!.googleWebKey.toString());
        }
        if(configModel.appConfig?.googleAndroidKey != null) {
          authController.googleConsoleAndroidApiKey.value = EncryptData.decrypt(configModel.appConfig!.googleAndroidKey.toString());
        }
        if(configModel.appConfig?.emailVerificationSystem != null) {
          authController.enableEmailVerification.value = configModel.appConfig!.emailVerificationSystem!;
        }
        if(configModel.appConfig?.educations != null) {
          settingController.educationsList.value = configModel.appConfig!.educations!;
        }

        isLoading(false);
      });
      return configModel;
    });
  }

  Future<void> navigate() async {
    Timer(
      const Duration(seconds: 1),() {
        if(LocalDataHelper().getUserToken() != null && LocalDataHelper().getUserAllData() != null) {
          UserModel userData = LocalDataHelper().getUserAllData()!;
          List<CountryModel>? countries = LocalDataHelper().getAllCountries();
          log("got user data after restart ${userData.user?.toJson()}");
          print("user token ${LocalDataHelper().getUserToken()}");
          userController.userData = userData;
          authController.chatSocketLogin(
            name: "${userData.user?.firstName} ${userData.user?.lastName}",
            id: "${userData.user?.id}",
            profilePic: "${userData.user?.profilePic}",
          );
          userController.getAllUsers();
          settingController.getCountriesList();
          userController.getAllUserConversations();
          if(countries != null){
            settingController.countriesList.value = countries;
          }
          Get.offAllNamed(Routes.dashboardScreen);
        } else if(LocalDataHelper().getUserAllData() != null
            && LocalDataHelper().getIsSessionExpired() == null
            && LocalDataHelper().getUserToken() == null) {
          Get.offAllNamed(Routes.dashboardScreenWoLogin);
          Get.defaultDialog(
            title: AppTags.sessionExpired.tr,
            middleText: AppTags.sessionExpiredPleaseLoginAgain.tr,
            backgroundColor: AppColors.pinkButton,
            titleStyle: const TextStyle(color: Colors.white),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            middleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            radius: 30,
            onConfirm: () {
              LocalDataHelper().saveIsSessionExpired(true);
              Get.back();
            },
            buttonColor: Colors.white,
            confirmTextColor: AppColors.pinkButton,
          );
        } else {
          Get.offAllNamed(Routes.dashboardScreenWoLogin);
        }
        // Get.offAll(() =>  LocalDataHelper().getUserToken() != null ? home_Page(): const WelcomeScreen());
      },
    );
  }
}
