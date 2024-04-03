import 'dart:developer';

import 'package:get/get.dart';
import '../models/faq_model.dart';
import '../repository/repository.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = RxBool(false);

  onThemeModeChange() {
    isDarkMode.value = !isDarkMode.value;
    update();
  }
}