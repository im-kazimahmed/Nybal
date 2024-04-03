import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/custom_checkbox.dart';
import 'package:nybal/Widgets/images.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/models/notification_model.dart' as notification_model;
import 'package:nybal/views/web_views/sideBarMenus.dart';
import 'package:nybal/widgets/my_date_util.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../Widgets/theme_data.dart';
import '../../Widgets/dialogs.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/pagination_controller.dart';
import '../../utils/app_tags.dart';
import '../../widgets/mobile_user_menu.dart';
import '../../widgets/top_bar.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});
  final PaginationController paginationController =
  Get.put(PaginationController());
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();

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
                  if (ResponsiveWidget.isSmallScreen(context)) Stack(
                    children: [
                      SizedBox(
                        height: Get.height,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              const MobileUserMenu(),
                              if(controller.sideBarMenusExpanded.isFalse)
                                ...[
                                  const SizedBox(height: 40),
                                  Column(
                                    children: [
                                      Text(
                                        AppTags.notifications.tr,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "myFontLight",
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF574667),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Get.width/6),
                                        child: Text(
                                          AppTags.notificationsAndConversationsYouReceived.tr,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFFC0B4CC),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: ()=> navController.handleNavIndexChanged(0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.pinkButton),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical:12),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  AppTags.allConversations.tr,
                                                  style: const TextStyle(
                                                    color: AppColors.pinkButton,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.pinkButton,
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical:12),
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppTags.allNotifications.tr,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: ()=> navController.handleNavIndexChanged(3),
                                            child: Image.asset(Images.settings),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        FutureBuilder(
                                          future: controller.getNotificationsList(),
                                          builder: (context, index) {
                                            if(controller.myNotificationsList.isEmpty && controller.isLoading.isTrue) {
                                              return const CustomLoader();
                                            } else if(controller.myNotificationsList.isNotEmpty) {
                                              return ListView.builder(
                                                itemCount: controller.myNotificationsList.length,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  notification_model.NotificationModel notification = controller.myNotificationsList[index];
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:8.0),
                                                    child: InkWell(
                                                      onLongPress: ()=> controller.onNotificationLongPress(
                                                        index,
                                                        notification.id,
                                                      ),
                                                      child: Container(
                                                        width: size.width,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey.withOpacity(0.1),
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 5,
                                                        ),
                                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "${notification.notificationDescription}",
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: themeController.isDarkMode.isTrue ?
                                                                      ThemeData.light().scaffoldBackgroundColor:
                                                                      ThemeData.dark().scaffoldBackgroundColor,
                                                                    ),
                                                                    textAlign: TextAlign.right,
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10),
                                                                Image.asset(Images.messages),
                                                              ],
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Container(
                                                              height: 20,
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () => controller.onNotificationDelete(
                                                                          notification.id,
                                                                        ),
                                                                        child: Image.asset(
                                                                          Images.delete,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(width: 20),
                                                                      Text(
                                                                        MyDateUtil.formatDateTime(notification.createdAt.toString()),
                                                                        style: const TextStyle(
                                                                          color: Color(0xffC0B4CC),
                                                                        ),
                                                                        overflow: TextOverflow.fade,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  CustomCheckBox(
                                                                  checkBoxValue: controller.selectedNotifications.contains(index),
                                                                  onChangedFunction: (value){
                                                                    controller.onNotificationSelect(
                                                                      index,
                                                                      notification.id,
                                                                      value,
                                                                    );
                                                                  },
                                                                  activeColor: AppColors.pinkButton,
                                                                  borderColor: AppColors.pinkButton,
                                                                  flipPosition: false,
                                                                  alignment: MainAxisAlignment.start,
                                                                ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              return Container(
                                                alignment: Alignment.topCenter,
                                                padding: const EdgeInsets.only(top: 30),
                                                child: const Text("No notifications found"),
                                              );
                                            }
                                          },
                                        ),
                                        if(controller.selectedNotifications.length > 1)
                                          Positioned(
                                            bottom: 210,
                                            right: 10,
                                            left: 80,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.blueColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20),
                                              child: InkWell(
                                                onTap: () => controller.onSelectedNotificationsDelete(),
                                                child: SizedBox(
                                                  height: 15,
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        Images.delete,
                                                        color: AppColors.whiteColor,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        "Eliminate",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.whiteColor,
                                                          decoration: TextDecoration.underline,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                            ],
                          ),
                        ),
                      ),
                    ],
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
                                        AppTags.notifications.tr,
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
                                          AppTags.notificationsAndConversationsYouReceived.tr,
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: ()=> navController.handleNavIndexChanged(0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.pinkButton),
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical:12),
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppTags.allConversations.tr,
                                            style: const TextStyle(
                                              color: AppColors.pinkButton,
                                            ),
                                          )
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.pinkButton,
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical:12),
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppTags.allNotifications.tr,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: ()=> navController.handleNavIndexChanged(3),
                                      child: Image.asset(Images.settings),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: size.width,
                                  height: size.height,
                                  child: FutureBuilder(
                                    future: controller.getNotificationsList(),
                                    builder: (context, index) {
                                      if(controller.myNotificationsList.isEmpty && controller.isLoading.isTrue) {
                                        return const CustomLoader();
                                      } else if(controller.myNotificationsList.isNotEmpty) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.myNotificationsList.length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical:8.0),
                                              child: Container(
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
                                                        "${controller.myNotificationsList[index].notificationDescription}",
                                                        style: const TextStyle(),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Image.asset(Images.messages),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(top: 30),
                                          child: const Text("No notifications found"),
                                        );
                                      }
                                    }
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     IconButton(
                                //       onPressed: paginationController.previousPage,
                                //       icon: const Icon(
                                //         Icons.arrow_back_ios,
                                //         color: AppColors.pinkButton,
                                //       ),
                                //     ),
                                //     const SizedBox(width: 16),
                                //     Row(
                                //       children: [
                                //         for (
                                //           int i = 1;
                                //           i <= (paginationController.helpCenterData.length / paginationController.itemsPerPage).ceil();
                                //           i++
                                //         )
                                //         GestureDetector(
                                //           onTap: () {
                                //             paginationController.currentPage.value = i;
                                //           },
                                //           child: Container(
                                //             margin: const EdgeInsets.symmetric(horizontal: 8),
                                //             padding: const EdgeInsets.all(8),
                                //             decoration: BoxDecoration(
                                //               border: paginationController.currentPage.value == i ? Border.all(color: AppColors.pinkButton): null,
                                //             ),
                                //             child: Text(
                                //               i.toString(),
                                //               style: TextStyle(
                                //                 color: paginationController.currentPage.value == i
                                //                     ? AppColors.pinkButton
                                //                     : Colors.black,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //     const SizedBox(width: 16),
                                //     IconButton(
                                //       onPressed: paginationController.nextPage,
                                //       icon: const Icon(
                                //         Icons.arrow_forward_ios,
                                //         color: AppColors.pinkButton,
                                //       ),
                                //     ),
                                //   ],
                                // )
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
