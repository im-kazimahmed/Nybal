import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/language_controller.dart';
import '../../helpers/data.dart';
import '../../Widgets/theme_data.dart';
import '../../widgets/top_bar.dart';

class SearchMembers extends StatelessWidget {
  SearchMembers({super.key});
  var dropDownValue;
  double _currentValue = 25;
  RangeValues _currentRange = const RangeValues(20, 40);
  final LanguageController langController = Get.find<LanguageController>();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          if(ResponsiveWidget.isSmallScreen(context))
            const TopBar(),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 20.w,
              ),
              child: Column(
                children: [
                  Text(
                    AppTags.search.tr,
                    style: const TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.2, 0.2),
                          blurRadius: 0.2,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(0.2, 0.2),
                          blurRadius: 1.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                      fontSize: 18,
                      fontFamily: "myFontLight",
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF574667),
                    ),
                  ),
                  const SizedBox(height: 02),
                  Expanded(
                    child: Text(
                      AppTags.searchForMembersOfYourChoice.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "myFontLight",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFC0B4CC),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(()=>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.isTrue ?
                  ThemeData.dark().scaffoldBackgroundColor: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeController.isDarkMode.isTrue ?
                              ThemeData.dark().scaffoldBackgroundColor: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppTags.quickSearch.tr,
                                  style: TextStyle(
                                    shadows: const <Shadow>[
                                      Shadow(
                                        offset: Offset(0.2, 0.2),
                                        blurRadius: 0.2,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      Shadow(
                                        offset: Offset(0.2, 0.2),
                                        blurRadius: 1.0,
                                        color: Color.fromARGB(125, 0, 0, 255),
                                      ),
                                    ],
                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 18,
                                    fontFamily: "myFontLight",
                                    fontWeight: FontWeight.w600,
                                    color: themeController.isDarkMode.isTrue ?
                                    Colors.white: const Color(0xFF574667),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeController.isDarkMode.isTrue ?
                              ThemeData.dark().scaffoldBackgroundColor: const Color(0xffF4F4F4),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppTags.searchByUsername.tr,
                                  style: TextStyle(
                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 18,
                                    fontFamily: "myFontLight",
                                    fontWeight: FontWeight.w500,
                                    color: themeController.isDarkMode.isTrue ?
                                    Colors.white: const Color(0xFF574667),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeController.isDarkMode.isTrue ?
                              ThemeData.dark().scaffoldBackgroundColor: const Color(0xffF4F4F4),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppTags.advancedSearch.tr,
                                  style: TextStyle(
                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 18,
                                    fontFamily: "myFontLight",
                                    fontWeight: FontWeight.w500,
                                    color: themeController.isDarkMode.isTrue ?
                                    Colors.white: const Color(0xFF574667),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (ResponsiveWidget.isSmallScreen(context)) Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            search();
                          },
                          child: Container(
                            width: 170,
                            decoration: const BoxDecoration(
                              color: AppColors.pinkButton,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                            child: FittedBox(
                              child: Text(
                                AppTags.lookingForAHusband.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            search();
                          },
                          child: Container(
                            width: 170,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.pinkButton),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                            child: FittedBox(
                              child: Text(
                                AppTags.imLookingForAWife.tr,
                                style: const TextStyle(
                                  color: AppColors.pinkButton,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) else Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            search();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.pinkButton,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                            child: Text(
                              AppTags.lookingForAHusband.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () {
                            search();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.pinkButton),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                            child: Text(
                              AppTags.imLookingForAWife.tr,
                              style: const TextStyle(
                                color: AppColors.pinkButton,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ResponsiveWidget.isSmallScreen(context) ?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppTags.relationshipStatus.tr,
                            style: const TextStyle(
                              color: Color(0xffC0B4CC),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffF4F4F4),
                            ),
                            child: DropdownButton(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              underline: const Text(""),
                              style: const TextStyle(textBaseline: null, color: Colors.black),
                              menuMaxHeight: Get.height / 2,
                              hint: Text(AppTags.allCases.tr),
                              alignment: Alignment.centerRight,
                              isExpanded: true,
                              // Initial Value
                              value: dropDownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 20,
                              // Array list of items
                              items: countries.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                // dropDownValue = newValue;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppTags.placeOfResidence.tr,
                            style: const TextStyle(
                              color: Color(0xffC0B4CC),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffF4F4F4),
                            ),
                            child: DropdownButton(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              underline: const Text(""),
                              style: const TextStyle(textBaseline: null, color: Colors.black),
                              menuMaxHeight: Get.height / 2,
                              hint: const Text("USA"),
                              alignment: Alignment.centerRight,
                              isExpanded: true,
                              // Initial Value
                              value: dropDownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 20,
                              // Array list of items
                              items: countries.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                // dropDownValue = newValue;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppTags.nationality.tr,
                            style: const TextStyle(
                              color: Color(0xffC0B4CC),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffF4F4F4),
                            ),
                            child: DropdownButton(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              underline: const Text(""),
                              style: const TextStyle(textBaseline: null, color: Colors.black),
                              menuMaxHeight: Get.height / 2,
                              hint: const Text("USA"),
                              alignment: Alignment.centerRight,
                              isExpanded: true,
                              // Initial Value
                              value: dropDownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 20,
                              // Array list of items
                              items: countries.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                // dropDownValue = newValue;
                              },
                            ),
                          ),
                        ],
                      ),
                    ): Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                AppTags.relationshipStatus.tr,
                                style: const TextStyle(
                                  color: Color(0xffC0B4CC),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppTags.placeOfResidence.tr,
                                style: const TextStyle(
                                  color: Color(0xffC0B4CC),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppTags.nationality.tr,
                                style: const TextStyle(
                                  color: Color(0xffC0B4CC),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF4F4F4),
                                ),
                                child: DropdownButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  underline: const Text(""),
                                  style: const TextStyle(textBaseline: null, color: Colors.black),
                                  menuMaxHeight: Get.height / 2,
                                  hint: Text(AppTags.allCases.tr),
                                  alignment: Alignment.centerRight,
                                  isExpanded: true,
                                  // Initial Value
                                  value: dropDownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 20,
                                  // Array list of items
                                  items: countries.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    // dropDownValue = newValue;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF4F4F4),
                                ),
                                child: DropdownButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  underline: const Text(""),
                                  style: const TextStyle(textBaseline: null, color: Colors.black),
                                  menuMaxHeight: Get.height / 2,
                                  hint: const Text("USA"),
                                  alignment: Alignment.centerRight,
                                  isExpanded: true,
                                  // Initial Value
                                  value: dropDownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 20,
                                  // Array list of items
                                  items: countries.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    // dropDownValue = newValue;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF4F4F4),
                                ),
                                child: DropdownButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  underline: const Text(""),
                                  style: const TextStyle(textBaseline: null, color: Colors.black),
                                  menuMaxHeight: Get.height / 2,
                                  hint: const Text("USA"),
                                  alignment: Alignment.centerRight,
                                  isExpanded: true,
                                  // Initial Value
                                  value: dropDownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 20,
                                  // Array list of items
                                  items: countries.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    // dropDownValue = newValue;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                AppTags.orderBy.tr,
                                style: const TextStyle(
                                  color: Color(0xffC0B4CC),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppTags.theAge.tr,
                                style: const TextStyle(
                                  color: Color(0xffC0B4CC),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF4F4F4),
                                ),
                                child: DropdownButton(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  underline: const Text(""),
                                  style: const TextStyle(textBaseline: null, color: Colors.black),
                                  menuMaxHeight: Get.height / 2,
                                  hint: Text(AppTags.lastLogged.tr),
                                  alignment: Alignment.centerRight,
                                  isExpanded: true,
                                  // Initial Value
                                  value: dropDownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 20,
                                  // Array list of items
                                  items: countries.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    // dropDownValue = newValue;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${AppTags.years.tr} ${_currentRange.start} - ${AppTags.years.tr} ${_currentRange.end}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xffC0B4CC),
                                    ),
                                  ),
                                  RangeSlider(
                                    activeColor: AppColors.pinkButton,
                                    values: _currentRange,
                                    min: 0,
                                    max: 100,
                                    onChanged: (newRange) {
                                      _currentRange = newRange;
                                    },
                                  ),
                                  // Slider(
                                  //   value: _currentValue,
                                  //   min: 0,
                                  //   max: 100,
                                  //   activeColor: AppColors.pinkButton,
                                  //   onChanged: (newValue) {
                                  //       _currentValue = newValue;
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        search();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff27B2CC),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
                        child: Text(
                          AppTags.search.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void search() {
    Dialogs.showDefaultDialogue(
        title: "Login",
        middleText: "Please login or create account in order to search",
        onConfirmation: () {
          Get.back();
        }
    );
  }
}
