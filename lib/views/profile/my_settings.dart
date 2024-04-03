import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/models/user_model.dart';
import 'package:nybal/widgets/custom_switch.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../Widgets/images.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/mobile_user_menu.dart';
import '../../widgets/top_bar.dart';
import '../web_views/sideBarMenus.dart';

class MySettings extends StatelessWidget {
  MySettings({super.key});
  final LanguageController langController = Get.find<LanguageController>();
  final ChatController chatController = Get.find<ChatController>();
  final NavigationController navController = Get.find<NavigationController>();

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
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          UserDataModel? user = controller.userData.user;
          return WillPopScope(
            onWillPop: () async {
              navController.handleNavIndexChanged(navController.previousIndex.value);
              return false;
            },
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
                              Text(
                                "My Settings",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "myFontLight",
                                  fontWeight: FontWeight.bold,
                                  color: themeController.isDarkMode.isTrue ?
                                  Colors.white:const Color(0xFF574667),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  "You can adjust the following settings",
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
                                    ThemeData.dark().scaffoldBackgroundColor:Colors.white,
                                  ),
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
                                  child: Column(
                                    children: [
                                      if(user != null && user.onlineStatus != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() {
                                              return CustomSwitch(
                                                checkBoxValue: chatController.isOnlineStatusVisible.value,
                                                backgroundColor: Colors.grey.withOpacity(0.3),
                                                activeColor: Colors.green,
                                                onChangedFunction: chatController.onOnlineStatusChanged,
                                              );
                                            }),
                                            Text(
                                              "Change your online status",
                                              style: TextStyle(
                                                color: themeController.isDarkMode.isTrue ?
                                                Colors.white: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if(user != null && user.activateNotifications != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSwitch(
                                              checkBoxValue: user.activateNotifications!,
                                              backgroundColor: Colors.grey.withOpacity(0.3),
                                              activeColor: Colors.green,
                                              onChangedFunction: (newValue) => controller.onUserSettingChanged(
                                                settingName: "activated_notifications",
                                                value: newValue,
                                              ),
                                            ),
                                            Text(
                                              "Activated notifications",
                                              style: TextStyle(
                                                color: themeController.isDarkMode.isTrue ?
                                                Colors.white: null,
                                              ),
                                            )
                                          ],
                                        ),
                                      if(user != null && user.emailNotificationsEnabled != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSwitch(
                                              checkBoxValue: user.emailNotificationsEnabled!,
                                              backgroundColor: Colors.grey.withOpacity(0.3),
                                              activeColor: Colors.green,
                                              onChangedFunction: (newValue) => controller.onUserSettingChanged(
                                                settingName: "email_notification",
                                                value: newValue,
                                              ),
                                            ),
                                            Text(
                                              "Send notifications to my email",
                                              style: TextStyle(
                                                color: themeController.isDarkMode.isTrue ?
                                                Colors.white: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      // if(user != null && user.interestListEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.interestListEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who added me to his interest?")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.whoVisitedProfileEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoVisitedProfileEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who visited my profile?")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.whoAddedMeToIgnoreEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoAddedMeToIgnoreEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who added me to your ignore list?")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.whoRemovedMeFromIgnoreEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoRemovedMeFromIgnoreEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who removed me from my ignore list?")
                                      //     ],
                                      //   ),
                                      if(user != null && user.receiveNewMessagesEnabled != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSwitch(
                                              checkBoxValue: user.receiveNewMessagesEnabled!,
                                              backgroundColor: Colors.grey.withOpacity(0.3),
                                              activeColor: Colors.green,
                                              onChangedFunction: (newValue) => controller.onUserSettingChanged(
                                                settingName: "receive_new_messages",
                                                value: newValue,
                                              ),
                                            ),
                                            Text(
                                              "Receive new messages",
                                              style: TextStyle(
                                                color: themeController.isDarkMode.isTrue ?
                                                Colors.white: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if(user != null && user.isMarryInterested != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSwitch(
                                              checkBoxValue: user.isMarryInterested!,
                                              backgroundColor: Colors.grey.withOpacity(0.3),
                                              activeColor: Colors.green,
                                              onChangedFunction: (newValue) => controller.onUserSettingChanged(
                                                settingName: "user_marry_interest",
                                                value: newValue,
                                              ),
                                            ),
                                            Text(
                                              "Interested in marriage",
                                              style: TextStyle(
                                                color: themeController.isDarkMode.isTrue ?
                                                Colors.white: null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 30),
                                      InkWell(
                                        onTap: () => navController.handleNavIndexChanged(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Text(
                                              "Delete my profile",
                                              style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Color(0xff27B2CC),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Image.asset(
                                              Images.delete,
                                              height: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // if(user != null && user.whoPermittedMeGalleryEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoPermittedMeGalleryEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Members who let me see their photos")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.successStoriesEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.successStoriesEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("New Success Stories")
                                      //     ],
                                      //   ),
                                    ],
                                  ),
                                ),
                              ),
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
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "My Settings",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "myFontLight",
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF574667),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Text(
                                          "You can adjust the following settings",
                                          style: TextStyle(
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
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                  child: Column(
                                    children: [
                                      if(user != null && user.onlineStatus != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Obx(() {
                                              return CustomSwitch(
                                                checkBoxValue: chatController.isOnlineStatusVisible.value,
                                                backgroundColor: Colors.grey.withOpacity(0.3),
                                                activeColor: Colors.green,
                                                onChangedFunction: chatController.onOnlineStatusChanged,
                                              );
                                            }),
                                            const Text("Change your online status")
                                          ],
                                        ),
                                      if(user != null && user.activateNotifications != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSwitch(
                                              checkBoxValue: user.activateNotifications!,
                                              onChangedFunction: () {},
                                              backgroundColor: Colors.grey.withOpacity(0.3),
                                              activeColor: Colors.green,
                                            ),
                                            const Text("Activated notifications")
                                          ],
                                        ),
                                      if(user != null && user.emailNotificationsEnabled != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSwitch(
                                              checkBoxValue: user.emailNotificationsEnabled!,
                                              onChangedFunction: (bool value) => {
                                                print("value $value")
                                              },
                                              backgroundColor: Colors.grey.withOpacity(0.3),
                                              activeColor: Colors.green,
                                            ),
                                            const Text("Send notifications to my email")
                                          ],
                                        ),
                                      // if(user != null && user.interestListEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.interestListEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who added me to his interest?")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.whoVisitedProfileEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoVisitedProfileEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who visited my profile?")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.whoAddedMeToIgnoreEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoAddedMeToIgnoreEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who added me to your ignore list?")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.whoRemovedMeFromIgnoreEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoRemovedMeFromIgnoreEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Who removed me from my ignore list?")
                                      //     ],
                                      //   ),
                                      if(user != null && user.receiveNewMessagesEnabled != null)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSwitch(
                                              checkBoxValue: user.receiveNewMessagesEnabled!,
                                              onChangedFunction: () {},
                                              backgroundColor: Colors.grey.withOpacity(0.3),
                                              activeColor: Colors.green,
                                            ),
                                            const Text("Receive new messages")
                                          ],
                                        ),
                                      // if(user != null && user.whoPermittedMeGalleryEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.whoPermittedMeGalleryEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("Members who let me see their photos")
                                      //     ],
                                      //   ),
                                      // if(user != null && user.successStoriesEnabled != null)
                                      //   Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       CustomSwitch(
                                      //         checkBoxValue: user.successStoriesEnabled!,
                                      //         onChangedFunction: () {},
                                      //         backgroundColor: Colors.grey.withOpacity(0.3),
                                      //         activeColor: Colors.green,
                                      //       ),
                                      //       const Text("New Success Stories")
                                      //     ],
                                      //   ),
                                      const SizedBox(height: 50),
                                      InkWell(
                                        onTap: () => navController.handleNavIndexChanged(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Delete my profile",
                                              style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Color(0xff27B2CC),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Image.asset(Images.delete),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
