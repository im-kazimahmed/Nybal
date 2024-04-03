// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:nybal/config/app_config.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/utils/app_tags.dart';

import '../../../controllers/user_controller.dart';
import '../../utils/constants.dart';

class Filters_page extends StatefulWidget {
  const Filters_page({super.key});

  @override
  State<Filters_page> createState() => _Filters_pageState();
}

class _Filters_pageState extends State<Filters_page> {
  bool isBlurred = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
            return Scaffold(
              backgroundColor: themeController.isDarkMode.isTrue ?
              ThemeData.dark().scaffoldBackgroundColor: mainClr,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: const Color(0xFFCC1262),
                ),
                elevation: 0,
                backgroundColor: themeController.isDarkMode.isTrue ?
                ThemeData.dark().scaffoldBackgroundColor:mainClr,
                title: Text(
                  "Filters",
                  style: TextStyle(
                    color: themeController.isDarkMode.isTrue ?
                    Colors.white:const Color(0xFF574667),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      cards(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Age",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "myFontLight",
                                    color: themeController.isDarkMode.isTrue ?
                                    Colors.white:const Color(0xFF574667),
                                  ),
                                ),
                                Text(
                                  controller.currentAgeRangeValues.end != 0.0 ?
                                  "From ${controller.currentAgeRangeValues.start.toInt()} to ${controller.currentAgeRangeValues.end.toInt()}":
                                  "Any age",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "myFontLight",
                                    color: Color(0xFFC0B4CC),
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: 05),
                            SizedBox(
                              height: Get.height / 20,
                              width: Get.width / 1.5,
                              child: RangeSlider(
                                values: controller.currentAgeRangeValues,
                                max: 100,
                                divisions: 100,
                                activeColor: themeController.isDarkMode.isTrue ?
                                Colors.white: const Color.fromARGB(255, 0, 0, 0),
                                inactiveColor: const Color.fromARGB(137, 94, 92, 92),
                                labels: RangeLabels(
                                  controller.currentAgeRangeValues.start.round().toString(),
                                  controller.currentAgeRangeValues.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) => controller.onAgeChange(values),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      cards(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Limit location by",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "myFontLight",
                                    color: themeController.isDarkMode.isTrue ?
                                    Colors.white:const Color(0xFF574667),
                                  ),
                                ),
                                const SizedBox(height: 05),
                                const Text(
                                  "No limit",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "myFontLight",
                                    color: Color(0xFFC0B4CC),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ],
                      )),
                      // const SizedBox(height: 10),
                      // cards(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       const Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Ethnicity",
                      //             style: TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w600,
                      //               fontFamily: "myFontLight",
                      //               color: Color(0xFF574667),
                      //             ),
                      //           ),
                      //           SizedBox(height: 05),
                      //           Text(
                      //             "No preference",
                      //             style: TextStyle(
                      //               fontSize: 13,
                      //               fontWeight: FontWeight.w200,
                      //               fontFamily: "myFontLight",
                      //               color: Color(0xFFC0B4CC),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       IconButton(
                      //         onPressed: () {},
                      //         icon: const Icon(Icons.arrow_forward_ios_sharp),
                      //       ),
                      //     ],
                      // )),
                      const SizedBox(height: 10),
                      cards(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.isSubPermissionEnabled(permissionName: "same_country_chat");
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Hidden blurred photos",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "myFontLight",
                                          color: themeController.isDarkMode.isTrue ?
                                          Colors.white: const Color(0xFF574667),
                                        ),
                                      ),
                                      const SizedBox(width: 05),
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                          image: AssetImage("assets/images/king.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            CupertinoSwitch(
                              value: isBlurred,
                              onChanged: controller.isPermissionEnabled(permissionName: permissionHideBlurredPhotos) ? (value) {
                                isBlurred = value;
                                setState(
                                  () {},
                                );
                              }: null,
                              trackColor: const Color(0xFFC0B4CC),
                              thumbColor: Colors.white,
                              activeColor: const Color(0xFFC0B4CC),
                            ),
                          ],
                      )),
                      const SizedBox(height: 10),
                      cards(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Advanced filter",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "myFontLight",
                                        color: themeController.isDarkMode.isTrue ?
                                        Colors.white:const Color(0xFF574667),
                                      ),
                                    ),
                                    const SizedBox(width: 05),
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image(
                                        image: AssetImage("assets/images/king.png"),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Choose one addition filter to make your search more precise.",
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                fontFamily: "myFontLight",
                                color: Color(0xFFC0B4CC),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.selectedAdvancedFilters.map((filter){
                                  String name = filter['name']!;
                                  String imageUrl = filter['image']!;
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 05),
                                    height: Get.height / 20,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 05,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFB900).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image(
                                            image: AssetImage(imageUrl),
                                            color: const Color(0xFFDB9E00),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 05),
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFFDB9E00),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                      )),
                      const SizedBox(height: 10),
                      cards(
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width / 1.2,
                              child: Text(
                                "Sort By",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: themeController.isDarkMode.isTrue ?
                                  Colors.white:const Color(0xFF574667),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Select what is important to you in your partner we will show you the most compatible profiles first.",
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                fontFamily: "myFontLight",
                                color: Color(0xFFC0B4CC),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.advancedFilters.length,
                                itemBuilder: (context, index) {
                                  String name = controller.advancedFilters[index]['name']!;
                                  String imageUrl = controller.advancedFilters[index]['image']!;
                                  return InkWell(
                                    onTap: () => controller.userData.user?.isPro == true ?
                                    controller.selectOrRemoveAdvancedFilter(controller.advancedFilters[index]): null,
                                    child: bars(
                                      txt: name,
                                      img: imageUrl,
                                      isSelected: controller.selectedAdvancedFilters.any((filter) => filter['name'] == name),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Column(
                            //       mainAxisSize: MainAxisSize.max,
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             bars(
                            //               txt: "160 cm (5’4”)",
                            //               img: "assets/images/height.png",
                            //             ),
                            //             const SizedBox(width: 05),
                            //             bars(
                            //               txt: "Never Married",
                            //               img: "assets/images/ring.png",
                            //             ),
                            //           ],
                            //         ),
                            //         bars(
                            //           txt: "Doesn’t have children",
                            //           img: "assets/images/kid.png",
                            //         ),
                            //         bars(
                            //           txt: "Marraige within a year",
                            //           img: "assets/images/calender.png",
                            //         ),
                            //         bars(
                            //           txt: "Won’t move abroad",
                            //           img: "assets/images/airplan.png",
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => controller.resetFiltering(),
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.height / 16,
                              width: Get.width / 2.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFFCC1262),
                                ),
                              ),
                              child: const Text(
                                "Reset",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "myFontLight",
                                  color: Color(0xFFCC1262),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              if(controller.isFiltering.isTrue) {
                                controller.applyFilters(
                                  filterName: "age",
                                  filterValue: "filterValue",
                                  ageValues: controller.currentAgeRangeValues
                                );
                              }
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.height / 16,
                              width: Get.width / 2.5,
                              color: const Color(0xFFCC1262),
                              child: const Text(
                                "Apply",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "myFontLight",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}

class cards extends StatelessWidget {
  var child;
  cards({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
          // height: Get.height / 08,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: Get.width / 1.1,
          child: child),
    );
  }
}

class bars extends StatelessWidget {
  var txt;
  var img;
  bool isSelected = false;
  bars({
    required this.txt,
    required this.img,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 05),
      height: Get.height / 20,
      padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.pinkButton: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image(
              image: AssetImage(img),
              fit: BoxFit.cover,
              color: isSelected ? Colors.white: null,
            ),
          ),
          const SizedBox(width: 02),
          Text(
            txt,
            style: TextStyle(
              fontSize: 13,
              color: isSelected ? Colors.white: null,
            ),
          ),
          const SizedBox(width: 02),
          Icon(
            Icons.add,
            size: 18,
            color: isSelected ? Colors.white: null,
          ),
        ],
      ),
    );
  }
}
