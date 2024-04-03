import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/views/web_views/sideBarMenus.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../Widgets/theme_data.dart';
import '../../Widgets/dialogs.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/pagination_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/app_tags.dart';
import '../../widgets/mobile_user_menu.dart';
import '../../widgets/top_bar.dart';

class MyLikes extends StatelessWidget {
  MyLikes({super.key});
  final PaginationController paginationController =
  Get.put(PaginationController());
  final LanguageController langController = Get.find<LanguageController>();

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
                  if (ResponsiveWidget.isSmallScreen(context))
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const MobileUserMenu(),
                            if(controller.sideBarMenusExpanded.isFalse)
                              ...[
                                const SizedBox(height: 40),
                                const Text(
                                  "My Likes",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "myFontLight",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF574667),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(
                                    "Likes i've sent to other users",
                                    style: TextStyle(
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
                                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
                                    child: FutureBuilder(
                                      future: controller.getMyLikes(),
                                      builder: (context, snapshot) {
                                        if(controller.myLikes.isEmpty && controller.isLoading.isTrue) {
                                          return const CustomLoader();
                                        } else if(controller.myLikes.isNotEmpty) {
                                          return SizedBox(
                                            width: size.width,
                                            height: size.height,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: controller.myLikes.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                    // color: themeController.isDarkMode.isTrue ?
                                                    // ThemeData.light().scaffoldBackgroundColor:
                                                    color: Colors.grey.withOpacity(0.1),
                                                  ),
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 5,
                                                  ),
                                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                                  child: Row(
                                                    children: [
                                                      // const Text(
                                                      //   "1 ${AppTags.secondAgo}",
                                                      //   style: TextStyle(
                                                      //     color: Color(0xffC0B4CC),
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        child: Text(
                                                          "${controller.myLikes[index].username} liked your picture",
                                                          style: TextStyle(
                                                            color: themeController.isDarkMode.isTrue ?
                                                            ThemeData.light().scaffoldBackgroundColor:
                                                            ThemeData.dark().scaffoldBackgroundColor,
                                                          ),
                                                          textAlign: TextAlign.right,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Icon(Icons.favorite, color: AppColors.blueColor),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return const Text("You haven't received any likes");
                                        }
                                      }
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                          ],
                        ),
                      ),
                    )
                  else
                    Column(
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
                                        const Text(
                                          "My Likes",
                                          style: TextStyle(
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
                                    width: Get.width,
                                    height: Get.height,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                            child: FutureBuilder(
                                              future: controller.getMyLikes(),
                                              builder: (context, snapshot) {
                                                if(controller.myLikes.isEmpty && controller.isLoading.isTrue) {
                                                  return const CustomLoader();
                                                } else if(controller.myLikes.isNotEmpty) {
                                                  return SizedBox(
                                                    width: size.width,
                                                    height: size.height,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller.myLikes.length,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        return Container(
                                                          width: size.width,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey.withOpacity(0.1),
                                                          ),
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 5,
                                                          ),
                                                          margin: const EdgeInsets.symmetric(vertical: 5),
                                                          child: Row(
                                                            children: [
                                                              // const Text(
                                                              //   "1 ${AppTags.secondAgo}",
                                                              //   style: TextStyle(
                                                              //     color: Color(0xffC0B4CC),
                                                              //   ),
                                                              // ),
                                                              Expanded(
                                                                child: Text(
                                                                  "${controller.myLikes[index].username} liked your picture",
                                                                  style: const TextStyle(),
                                                                  textAlign: TextAlign.right,
                                                                ),
                                                              ),
                                                              const SizedBox(width: 10),
                                                              const Icon(Icons.favorite, color: AppColors.blueColor),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return const Text("You haven't received any likes");
                                                }
                                              }
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
                                          width: Get.width,
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
        });
      }
    );
    // return GetBuilder<UserController>(builder: (UserController controller) {
    //   return SafeArea(
    //     child: Column(
    //       children: [
    //         if(ResponsiveWidget.isSmallScreen(context))
    //           const TopBar(),
    //         const SizedBox(height: 10),
    //         if (ResponsiveWidget.isSmallScreen(context)) Container(
    //           height: size.height,
    //           width: size.width,
    //           padding: const EdgeInsets.symmetric(horizontal: 20),
    //           child: Column(
    //             children: [
    //               Column(
    //                 children: [
    //                   Text(
    //                     AppTags.notifications.tr,
    //                     style: const TextStyle(
    //                       fontSize: 18,
    //                       fontFamily: "myFontLight",
    //                       fontWeight: FontWeight.bold,
    //                       color: Color(0xFF574667),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 10),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //                     child: Text(
    //                       AppTags.notificationsAndConversationsYouReceived.tr,
    //                       style: const TextStyle(
    //                         fontSize: 13,
    //                         color: Color(0xFFC0B4CC),
    //                       ),
    //                       textAlign: TextAlign.center,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 50),
    //                 ],
    //               ),
    //               const SizedBox(height: 20),
    //               // Expanded(
    //               //   // child: ListView.builder(
    //               //   //   itemCount: 5,
    //               //   //   physics: const NeverScrollableScrollPhysics(),
    //               //   //   itemBuilder: (context, index) {
    //               //   //     return Padding(
    //               //   //       padding: const EdgeInsets.symmetric(vertical:8.0),
    //               //   //       child: Container(
    //               //   //         width: size.width,
    //               //   //         decoration: const BoxDecoration(
    //               //   //           color: Colors.white,
    //               //   //         ),
    //               //   //         padding: const EdgeInsets.symmetric(
    //               //   //           horizontal: 13,
    //               //   //           vertical: 13,
    //               //   //         ),
    //               //   //         child: Column(
    //               //   //           children: [
    //               //   //             Row(
    //               //   //               children: [
    //               //   //                 Column(
    //               //   //                   mainAxisAlignment: MainAxisAlignment.end,
    //               //   //                   crossAxisAlignment: CrossAxisAlignment.end,
    //               //   //                   children: [
    //               //   //                     Text(
    //               //   //                       "Simo_hugo absolute 39 ${AppTags.years.tr}",
    //               //   //                       style: const TextStyle(
    //               //   //
    //               //   //                       ),
    //               //   //                       textAlign: TextAlign.right,
    //               //   //                     ),
    //               //   //                     const SizedBox(height: 10),
    //               //   //                     const Text(
    //               //   //                       "Peace be upon you. I am inside here...",
    //               //   //                       style: TextStyle(
    //               //   //                         color: Color(0xffC0B4CC),
    //               //   //                       ),
    //               //   //                       textAlign: TextAlign.right,
    //               //   //                     ),
    //               //   //                   ],
    //               //   //                 ),
    //               //   //                 Expanded(
    //               //   //                   child: Stack(
    //               //   //                     children: [
    //               //   //                       Image.asset(
    //               //   //                         Images.personMale,
    //               //   //                       ),
    //               //   //                       Positioned(
    //               //   //                         right: 0,
    //               //   //                         bottom: 0,
    //               //   //                         child: Container(
    //               //   //                           decoration: BoxDecoration(
    //               //   //                             color: Colors.green,
    //               //   //                             shape: BoxShape.circle,
    //               //   //                             border: Border.all(color: Colors.white, width: 4),
    //               //   //                           ),
    //               //   //                           padding: const EdgeInsets.all(4.0),
    //               //   //                         ),
    //               //   //                       ),
    //               //   //                     ],
    //               //   //                   ),
    //               //   //                 ),
    //               //   //               ],
    //               //   //             ),
    //               //   //             Row(
    //               //   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               //   //               children: [
    //               //   //                 Row(
    //               //   //                   children: [
    //               //   //                     Image.asset(Images.delete),
    //               //   //                     const SizedBox(width: 10),
    //               //   //                     Text(
    //               //   //                       "1 ${AppTags.secondAgo.tr}",
    //               //   //                       style: const TextStyle(
    //               //   //                         color: Color(0xffC0B4CC),
    //               //   //                       ),
    //               //   //                     ),
    //               //   //                   ],
    //               //   //                 ),
    //               //   //                 const Icon(Icons.check_box_outline_blank)
    //               //   //               ],
    //               //   //             ),
    //               //   //           ],
    //               //   //         ),
    //               //   //       ),
    //               //   //     );
    //               //   //   },
    //               //   // ),
    //               // ),
    //             ],
    //           ),
    //         ) else Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Expanded(
    //                   flex: 2,
    //                   child: Column(
    //                     children: [
    //                       Container(
    //                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    //                         child: const Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               "My Likes",
    //                               style: TextStyle(
    //                                 fontSize: 18,
    //                                 fontFamily: "myFontLight",
    //                                 fontWeight: FontWeight.bold,
    //                                 color: Color(0xFF574667),
    //                               ),
    //                             ),
    //                             SizedBox(height: 10),
    //                             Padding(
    //                               padding: EdgeInsets.symmetric(horizontal: 20.0),
    //                               child: Text(
    //                                 "Likes i've sent to other users",
    //                                 style: TextStyle(
    //                                   fontSize: 13,
    //                                   color: Color(0xFFC0B4CC),
    //                                 ),
    //                                 textAlign: TextAlign.center,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       const SizedBox(height: 20),
    //                       FutureBuilder(
    //                         future: controller.getMyLikes(),
    //                         builder: (context, snapshot) {
    //                           if(controller.receivedLikes.isEmpty && controller.isLoading.isTrue) {
    //                             return const CustomLoader();
    //                           } else if(controller.receivedLikes.isNotEmpty) {
    //                             return SizedBox(
    //                               width: size.width,
    //                               height: size.height,
    //                               child: ListView.builder(
    //                                 shrinkWrap: true,
    //                                 itemCount: controller.receivedLikes.length,
    //                                 physics: const NeverScrollableScrollPhysics(),
    //                                 itemBuilder: (context, index) {
    //                                   return Container(
    //                                     width: size.width,
    //                                     decoration: BoxDecoration(
    //                                       color: Colors.grey.withOpacity(0.1),
    //                                     ),
    //                                     padding: const EdgeInsets.symmetric(
    //                                       horizontal: 5,
    //                                       vertical: 5,
    //                                     ),
    //                                     margin: const EdgeInsets.symmetric(vertical: 5),
    //                                     child: Row(
    //                                       children: [
    //                                         // const Text(
    //                                         //   "1 ${AppTags.secondAgo}",
    //                                         //   style: TextStyle(
    //                                         //     color: Color(0xffC0B4CC),
    //                                         //   ),
    //                                         // ),
    //                                         Expanded(
    //                                           child: Text(
    //                                             "${controller.receivedLikes[index].username} liked your picture",
    //                                             style: const TextStyle(),
    //                                             textAlign: TextAlign.right,
    //                                           ),
    //                                         ),
    //                                         const SizedBox(width: 10),
    //                                         const Icon(Icons.favorite, color: AppColors.blueColor),
    //                                       ],
    //                                     ),
    //                                   );
    //                                 },
    //                               ),
    //                             );
    //                           } else {
    //                             return const Text("You haven't received any likes");
    //                           }
    //                         }
    //                       ),
    //                       // Row(
    //                       //   mainAxisAlignment: MainAxisAlignment.center,
    //                       //   children: [
    //                       //     IconButton(
    //                       //       onPressed: paginationController.previousPage,
    //                       //       icon: const Icon(
    //                       //         Icons.arrow_back_ios,
    //                       //         color: AppColors.pinkButton,
    //                       //       ),
    //                       //     ),
    //                       //     const SizedBox(width: 16),
    //                       //     Row(
    //                       //       children: [
    //                       //         for (
    //                       //           int i = 1;
    //                       //           i <= (paginationController.helpCenterData.length / paginationController.itemsPerPage).ceil();
    //                       //           i++
    //                       //         )
    //                       //         GestureDetector(
    //                       //           onTap: () {
    //                       //             paginationController.currentPage.value = i;
    //                       //           },
    //                       //           child: Container(
    //                       //             margin: const EdgeInsets.symmetric(horizontal: 8),
    //                       //             padding: const EdgeInsets.all(8),
    //                       //             decoration: BoxDecoration(
    //                       //               border: paginationController.currentPage.value == i ? Border.all(color: AppColors.pinkButton): null,
    //                       //             ),
    //                       //             child: Text(
    //                       //               i.toString(),
    //                       //               style: TextStyle(
    //                       //                 color: paginationController.currentPage.value == i
    //                       //                     ? AppColors.pinkButton
    //                       //                     : Colors.black,
    //                       //               ),
    //                       //             ),
    //                       //           ),
    //                       //         ),
    //                       //       ],
    //                       //     ),
    //                       //     const SizedBox(width: 16),
    //                       //     IconButton(
    //                       //       onPressed: paginationController.nextPage,
    //                       //       icon: const Icon(
    //                       //         Icons.arrow_forward_ios,
    //                       //         color: AppColors.pinkButton,
    //                       //       ),
    //                       //     ),
    //                       //   ],
    //                       // )
    //                     ],
    //                   ),
    //                 ),
    //                 const SizedBox(width: 20),
    //                 SideBarMenus(),
    //               ],
    //             ),
    //
    //           ],
    //         ),
    //         const SizedBox(height: 50),
    //       ],
    //     ),
    //   );
    // }
    // );
  }
}
