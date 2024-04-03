import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/widgets/custom_switch.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/images.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../Widgets/theme_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../controllers/user_controller.dart';
import '../../helpers/local_data_helper.dart';
import '../../models/conversation_model.dart';

class ActionsBarWidget extends StatelessWidget {
  ActionsBarWidget({super.key});
  final navController = Get.find<NavigationController>();
  final chatController = Get.find<ChatController>();
  final homeController = Get.find<HomeScreenController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(LocalDataHelper().getUserToken() != null && LocalDataHelper().getUserAllData() != null)
              Expanded(
                child: Row(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () => navController.handleNavIndexChanged(21),
                          child: SizedBox(
                            width: 12.sp,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: "${userController.userData.user?.profilePic}",
                                fit: BoxFit.cover,
                                width: 12.sp,
                                placeholder: (context, url) => const CircleAvatar(
                                  child: Icon(CupertinoIcons.person),
                                ),
                                errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                  child: Icon(CupertinoIcons.person),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(()=>
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: chatController.isOnlineStatusVisible.isTrue ? Colors.green: Colors.grey,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                              ),
                              padding: const EdgeInsets.all(4.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        homeController.onOpenMenuOrClose();
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                      color: const Color(0xffCC1262),
                    ),
                    InkWell(
                      onTap: ()=> navController.handleNavIndexChanged(5),
                      child: Image.asset(
                        Images.notification,
                        color: AppColors.pinkButton,
                        height: 12.sp,
                      ),
                    ),
                    Obx(()=>
                      CustomSwitch(
                        checkBoxValue: chatController.isOnlineStatusVisible.value,
                        backgroundColor: Colors.grey,
                        activeColor: Colors.green,
                        onChangedFunction: chatController.onOnlineStatusChanged,
                      ),
                    ),
                  ],
                ),
              )
            else
            // Login Button
              Expanded(
                child: Row(
                  children: [
                    // Signup Button
                    InkWell(
                      onTap: () {
                        navController.handleIndexChanged(9);
                        navController.selectedPage.value = "";
                        navController.clearAllHover();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.pinkButton,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                        child: Text(
                          AppTags.signUp.tr,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    InkWell(
                      onTap: () {
                        navController.handleIndexChanged(2);
                        navController.selectedPage.value = "";
                        navController.clearAllHover();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.pinkButton),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                        child: Text(
                          AppTags.signIn.tr,
                          style: const TextStyle(
                            color: AppColors.pinkButton,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            // Image and Text Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Row of Text Buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(kIsWeb)
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              navController.selectedPage.value = "potentialMatches";
                              navController.clearAllHover();
                              navController.handleIndexChanged(3);
                              // Get.offAll(()=> PotentialMatches());
                            },
                            child: MouseRegion(
                              onEnter: (_) => navController.isPotentialBtnHovered(true),
                              onExit: (_) => navController.selectedPage.value == "potentialMatches" ? null: navController.isPotentialBtnHovered(false),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppTags.potentialMatches.tr,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 30.0,
                                    height: 2.0,
                                    color: navController.isPotentialBtnHovered.value || navController.selectedPage.value == "potentialMatches" ? AppColors.pinkButton : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      const SizedBox(width: 15,),
                      if(kIsWeb)
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              print("New members");
                              navController.selectedPage.value = "newMembers";
                              navController.clearAllHover();
                              if(LocalDataHelper().getUserToken() != null) {
                                navController.handleNavIndexChanged(12);
                              } else {
                                navController.handleIndexChanged(4);
                              }
                            },
                            child: MouseRegion(
                              onEnter: (_) => navController.isNewMembersBtnHovered(true),
                              onExit: (_) => navController.isNewMembersBtnHovered(false),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppTags.newMembers.tr,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 30.0,
                                    height: 2.0,
                                    color: navController.isNewMembersBtnHovered.value || navController.selectedPage.value == "newMembers" ? AppColors.pinkButton : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      const SizedBox(width: 15,),
                      if(kIsWeb)
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              print("Online");
                              navController.selectedPage.value = "online";
                              navController.clearAllHover();
                              navController.handleIndexChanged(5);
                              if(LocalDataHelper().getUserToken() != null) {
                                navController.handleNavIndexChanged(17);
                              } else {
                                navController.handleIndexChanged(5);
                              }
                              // Get.offAll(()=> OnlineMembers());
                            },
                            child: MouseRegion(
                              onEnter: (_) => navController.isOnlineHovered(true),
                              onExit: (_) => navController.isOnlineHovered(false),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppTags.online.tr,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 30.0,
                                    height: 2.0,
                                    color: navController.isOnlineHovered.value || navController.selectedPage.value == "online" ? AppColors.pinkButton : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      const SizedBox(width: 15,),
                      if(kIsWeb)
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              print("Search");
                              navController.selectedPage.value = "search";
                              navController.clearAllHover();
                              // Get.offAll(()=> SearchMembers());
                              if(LocalDataHelper().getUserToken() != null) {
                                navController.handleNavIndexChanged(19);
                              } else {
                                navController.handleIndexChanged(1);
                              }
                            },
                            child: MouseRegion(
                              onEnter: (_) => navController.isSearchHovered(true),
                              onExit: (_) => navController.isSearchHovered(false),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppTags.search.tr,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 30.0,
                                    height: 2.0,
                                    color: navController.isSearchHovered.value || navController.selectedPage.value == "search" ? AppColors.pinkButton : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/iconMain.png",
                    fit: BoxFit.contain,
                    width: 50, // You can set a specific width for the image if needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


