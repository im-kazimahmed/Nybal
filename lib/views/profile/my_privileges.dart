import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/views/web_views/sideBarMenus.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../Widgets/theme_data.dart';
import '../../Widgets/images.dart';
import '../../controllers/language_controller.dart';
import '../../widgets/mobile_user_menu.dart';
import '../../widgets/top_bar.dart';

class MyPrivileges extends StatelessWidget {
  MyPrivileges({super.key});
  final LanguageController langController = Get.find<LanguageController>();

  final List myPrivileges = [
    {"title": "Receiving messages", "image": Images.availableCheckbox},
    {"title": "Send messages to any member with affection", "image": Images.availableCheckbox},
    {"title": "Control who can message you", "image": Images.notAvailable},
    {"title": "Delete ads when sending a message", "image": Images.availableCheckbox},
    {"title": "Search and browse files", "image": Images.availableCheckbox},
    {"title": "View the lists of existing / new / distinguished members", "image": Images.availableCheckbox},
    {"title": "Show your profile distinctly from other members", "image": Images.notAvailable},
    {"title": "Edit your data", "image": Images.availableCheckbox},
    {"title": "Edit your nickname", "image": Images.notAvailable},
    {"title": "incognito", "image": Images.notAvailable},
    {"title": "Delete ads when browsing member profiles", "image": Images.availableCheckbox},
    {"title": "Add your photos", "image": Images.availableCheckbox},
    {"title": "View member photo", "image": Images.availableCheckbox},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: SafeArea(
              child: Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  if (ResponsiveWidget.isSmallScreen(context)) Container(
                    height: size.height,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const MobileUserMenu(),
                        if(controller.sideBarMenusExpanded.isFalse)
                          ...[
                            const SizedBox(height: 40),
                            Text(
                              AppTags.myPrivileges.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "myFontLight",
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF574667),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                AppTags.listOfBenefitsAvailableToYou.tr,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFC0B4CC),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themeController.isDarkMode.isTrue ?
                                  ThemeData.dark().scaffoldBackgroundColor:
                                  ThemeData.light().scaffoldBackgroundColor,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                child: ListView.builder(
                                  itemCount: myPrivileges.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  myPrivileges[index]['title'].toString(),
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: themeController.isDarkMode.isTrue ?
                                                    ThemeData.light().scaffoldBackgroundColor:
                                                    ThemeData.dark().scaffoldBackgroundColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Image.asset(myPrivileges[index]['image']),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                      ],
                    ),
                  ) else Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppTags.myPrivileges.tr,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "myFontLight",
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF574667),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text(
                                          AppTags.listOfBenefitsAvailableToYou.tr,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFFC0B4CC),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: size.width,
                                  height: size.height,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                          child: ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: myPrivileges.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            myPrivileges[index]['title'].toString(),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Image.asset(myPrivileges[index]['image']),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Container(
                                        width: 20.w,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xffFFB800),
                                              Color(0xffFFE5A1),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical :10),
                                        child: FittedBox(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppTags.excellentPackage.tr,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: size.width,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                        child: Text(
                                          AppTags.bySubscribingToTheExcellencePackage.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.pinkButton,
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: InkWell(
                                          onTap: () {

                                          },
                                          child: Text(
                                            AppTags.subscribeToTheExcellentPackage.tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   width: size.width,
                                //   decoration: const BoxDecoration(
                                //     color: Colors.white,
                                //   ),
                                //   padding: const EdgeInsets.symmetric(vertical: 20),
                                //   child: Padding(
                                //     padding: EdgeInsets.symmetric(horizontal: 5.w, vertical : 20),
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       children: [
                                //         const Text(
                                //           "Plan Prices",
                                //           style: TextStyle(
                                //             fontWeight: FontWeight.bold,
                                //           ),
                                //         ),
                                //         const SizedBox(height: 20),
                                //         Container(
                                //           decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             boxShadow: [
                                //               BoxShadow(
                                //                 color: Colors.grey[300]!,
                                //                 spreadRadius: 0.1,
                                //                 blurRadius: 30,
                                //                 offset: const Offset(0, 20),
                                //               )
                                //             ],
                                //           ),
                                //           child: Stack(
                                //             children: [
                                //               Text("Why i am seeing this?"),
                                //               Image.asset("assets/images/package.png"),
                                //               Text("Standard"),
                                //               Text(
                                //                 "30 min",
                                //                 style: TextStyle(
                                //                   color: Colors.blue,
                                //                   fontWeight: FontWeight.bold,
                                //                 )
                                //               ),
                                //               Positioned(
                                //                 top: 0,
                                //                 left: 0,
                                //                 child: Transform.rotate(
                                //                   angle: 5.5,
                                //                   child: Container(
                                //                     decoration: const BoxDecoration(
                                //                       color: Color(0xffC768E1),
                                //                     ),
                                //                     padding: const EdgeInsets.all(8.0),
                                //                     child: const Text(
                                //                       'Super price',
                                //                       style: TextStyle(color: Colors.white),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          SideBarMenus(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        }
        );
      }
    );
  }
}
