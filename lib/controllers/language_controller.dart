import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/data_storage_service.dart';
import '../helpers/local_data_helper.dart';
import '../models/config_model.dart';

class LanguageController extends GetxController {
  final storage = Get.find<StorageService>();
  final RxString locale = Get.locale.toString().obs;
  RxList<Languages> languages = RxList([]);

  final Languages defaultLocale = Languages(
    id: 1,
    key: "en_US",
    name: "English",
    isEnabled: true,
  );

  // List<Languages> lang = LocalDataHelper().getConfigData().appConfig!.languages!;
  void updateLocale(String? key) {
    try {
      Languages language = languages.firstWhere((language) => language.key == key);
      final String languageCode = language.key!;
      // Update App
      Get.updateLocale(Locale(languageCode));
      // Update obs
      locale.value = Get.locale.toString();

      //Language code check and save
      // if(lang.isNotEmpty) {
      //   lang.asMap().forEach((index, value) {
      //     if (lang[index].key!.contains(languageCode)){
      //       LocalDataHelper().saveLanguageServer(languageCode);
      //       //print("=====EE====$languageCode");
      //     }
      //   });
      // }
      // else {
      languages.asMap().forEach((index, value) {
        if(languages[index].key == languageCode) {
          LocalDataHelper().saveLanguageServer(languageCode);
        }
      });
      // }
      // Update storage
      storage.write('languageCode', languageCode);
      // storage.write('countryCode', countryCode);
    } catch (e) {
      log("$e");
    }
  }

  // List<Languages> getAppLanguageList() {
  //    List<Languages> languageList = [];
  //    languages.map((lang) => languageList.add(lang));
  //   optionsLocales.forEach((k, v) => languageList.add(Languages(
  //       key: optionsLocales[k]['languageCode'],
  //       name: optionsLocales[k]['description'])));
  //   return languageList;
  // }
}