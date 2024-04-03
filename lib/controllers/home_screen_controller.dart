import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/faq_model.dart';
import '../repository/repository.dart';


class HomeScreenController extends GetxController implements GetxService {
  PageController pageController = PageController();
  var faqsList = <FaqModel>[].obs;
  RxBool isMenuOpen = RxBool(false);
  var current = 1.obs;
  bool isVisible = true;
  var index = 2;
  bool isFavourite = false;
  // Rx<HomeDataModel> homeDataModel = HomeDataModel().obs;
  var isLoadingFromServer = false.obs;

  // Future<HomeDataModel> getHomeScreenData() async {
  //   HomeDataModel? data = LocalDataHelper().getHomeData();
  //   if (data != null) {
  //     homeDataModel.value = data;
  //   }
  //   await Repository().getHomeScreenData().then(
  //     (homeData) {
  //       homeDataModel.value = homeData;
  //       LocalDataHelper().saveHomeContent(homeData);
  //     },
  //   );
  //   return homeDataModel.value;
  // }
  //
  // Future<HomeDataModel> getHomeDataFromServer() async {
  //   isLoadingFromServer(true);
  //   return await Repository().getHomeScreenData().then(
  //     (homeData) {
  //       homeDataModel.value = homeData;
  //       LocalDataHelper().saveHomeContent(homeData);
  //       isLoadingFromServer(false);
  //       return homeDataModel.value;
  //     },
  //   );
  // }
  Future<List<FaqModel>?> fetchFaqList() async {
    isLoadingFromServer(true);
    try {
      var data = await Repository().getFaqsList();
      if(data != null) {
        faqsList.value = data;
        isLoadingFromServer(false);
        return faqsList;
      } else {
        isLoadingFromServer(false);
        return null;
      }
    } catch (e) {
      log("Exception: Failed to fetch faq lists $e");
      return null;
    } finally {
      update();
    }
  }

  removeTrailingZeros(String n) {
    return n.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }

  @override
  void onInit() {
    super.onInit();
    // getHomeScreenData();
  }

  isVisibleUpdate(bool value) {
    isVisible = value;
    update();
  }

  currentUpdate(int value) {
    current.value = value;
    update();
  }

  isFavouriteUpdate() {
    isFavourite = !isFavourite;
    update();
  }

  onOpenMenuOrClose() {
    isMenuOpen.value = !isMenuOpen.value;
  }
}
