import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/utils/functions.dart';
import 'package:nybal/widgets/dialogs.dart';
import '../../../Widgets/theme_data.dart';
import '../../Widgets/images.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../../widgets/my_date_util.dart';
import '../../widgets/top_bar.dart';
import '../Send_Message/send_message.dart';
import '../web_views/sideBarMenus.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({
    super.key,
  });

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  bool isLiked = false;
  final ChatController chatController = Get.find<ChatController>();
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<UserController>(builder: (UserController controller) {
    //   UserDataModel? user = controller.userData.user;
    //   int? age = MyDateUtil.calculateAge(controller.selectedUser.value.dateOfBirth);
    //   return SafeArea(
    //     child: Column(
    //       children: [
    //         if(ResponsiveWidget.isSmallScreen(context))
    //           const TopBar(),
    //         const SizedBox(height: 10),
    //         if (ResponsiveWidget.isSmallScreen(context))
    //           Container(
    //             height: Get.height,
    //             width: Get.width,
    //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //             child: Column(
    //               children: [
    //                 Container(
    //                   decoration: const BoxDecoration(
    //                     color: Colors.white,
    //                   ),
    //                   padding: const EdgeInsets.all(10),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       IconButton(
    //                         onPressed: () => controller.onSideBarMenuExpanded(),
    //                         icon: controller.sideBarMenusExpanded.isFalse ?
    //                         const Icon(
    //                           Icons.keyboard_arrow_down,
    //                           color: Color(0xffCC1262),
    //                         ):
    //                         const Icon(
    //                           Icons.keyboard_arrow_up,
    //                           color: Color(0xffCC1262),
    //                         ),
    //                       ),
    //                       Row(
    //                         children: [
    //                           const Icon(Icons.flag),
    //                           const SizedBox(width: 20),
    //                           Text("${controller.userData.user?.firstName}"),
    //                           Stack(
    //                             children: [
    //                               Image.asset(Images.personMale),
    //                               Positioned(
    //                                 right: 0,
    //                                 bottom: 0,
    //                                 child: Container(
    //                                   decoration: BoxDecoration(
    //                                     color: Colors.green,
    //                                     shape: BoxShape.circle,
    //                                     border: Border.all(color: Colors.white, width: 4),
    //                                   ),
    //                                   padding: const EdgeInsets.all(4.0),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Visibility(
    //                   visible: controller.sideBarMenusExpanded.value,
    //                   child: Container(
    //                       width: Get.width,
    //                       decoration: const BoxDecoration(
    //                         color: Colors.white,
    //                       ),
    //                       padding: EdgeInsets.symmetric(horizontal: 8.w),
    //                       child: UserSideMenus()
    //                   ),
    //                 ),
    //                 const SizedBox(height: 40),
    //                 if(controller.sideBarMenusExpanded.isFalse)
    //                   Expanded(
    //                     child: Container(
    //                       decoration: const BoxDecoration(
    //                         color: Colors.white,
    //                       ),
    //                       padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
    //                       child: Column(
    //                         children: [
    //                           FittedBox(
    //                             child: Row(
    //                               children: [
    //                                 Container(
    //                                   decoration: const BoxDecoration(
    //                                     color: AppColors.blueColor,
    //                                   ),
    //                                   padding: const EdgeInsets.all(5),
    //                                   child: Row(
    //                                     children: [
    //                                       const Text(
    //                                         "Ignore",
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       Image.asset(Images.edit)
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 const SizedBox(width: 5),
    //                                 Container(
    //                                   decoration: const BoxDecoration(
    //                                     color: AppColors.blueColor,
    //                                   ),
    //                                   padding: const EdgeInsets.all(5),
    //                                   child: Row(
    //                                     children: [
    //                                       const Text(
    //                                         "Report",
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       Image.asset(Images.edit)
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 const SizedBox(width: 5),
    //                                 Container(
    //                                   decoration: const BoxDecoration(
    //                                     color: AppColors.blueColor,
    //                                   ),
    //                                   padding: const EdgeInsets.all(5),
    //                                   child: Row(
    //                                     children: [
    //                                       const Text(
    //                                         "Ask for photos",
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       Image.asset(Images.edit)
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 const SizedBox(width: 5),
    //                                 Container(
    //                                   decoration: const BoxDecoration(
    //                                     color: AppColors.blueColor,
    //                                   ),
    //                                   padding: const EdgeInsets.all(5),
    //                                   child: Row(
    //                                     children: [
    //                                       const Text(
    //                                         "Message",
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       Image.asset(Images.edit)
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           const SizedBox(height: 20),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               const SizedBox(height: 20),
    //                               Column(
    //                                 children: [
    //                                   Row(
    //                                     mainAxisAlignment: MainAxisAlignment.center,
    //                                     crossAxisAlignment: CrossAxisAlignment.center,
    //                                     children: [
    //                                       Text(
    //                                         "${controller.selectedUser.value.firstName}",
    //                                         style: const TextStyle(
    //                                           fontSize: 20,
    //                                           fontWeight: FontWeight.w700,
    //                                           fontFamily: "myFontLight",
    //                                           color: Color(0xFF574667),
    //                                         ),
    //                                       ),
    //                                       const SizedBox(width: 10),
    //                                       if(controller.selectedUser.value.verified == true)
    //                                         const SizedBox(
    //                                           height: 20,
    //                                           width: 20,
    //                                           child: Image(image: AssetImage("assets/images/verify.png")),
    //                                         )
    //                                     ],
    //                                   ),
    //                                   Row(
    //                                     children: [
    //                                       if(age != null && age > 0)
    //                                         Text(
    //                                           "27 ${AppTags.years.tr}",
    //                                           // "$age",
    //                                           style: const TextStyle(
    //                                             fontSize: 12,
    //                                             fontFamily: "myFontLight",
    //                                             fontWeight: FontWeight.w600,
    //                                             color: Color(0xFF27B2CC),
    //                                           ),
    //                                         ),
    //                                       if(controller.selectedUser.value.country != null)
    //                                         Text(
    //                                           "${age != null && age > 0 ? " | ": ""}Living in ${controller.selectedUser.value.country}",
    //                                           style: TextStyle(
    //                                             fontSize: 12,
    //                                             fontFamily: "myFontLight",
    //                                             fontWeight: FontWeight.w600,
    //                                             color: Colors.black.withOpacity(0.4),
    //                                           ),
    //                                         ),
    //                                     ],
    //                                   )
    //                                 ],
    //                               ),
    //                               Stack(
    //                                 clipBehavior: Clip.none,
    //                                 children: [
    //                                   ClipOval(
    //                                     child: CachedNetworkImage(
    //                                       // imageUrl: "https://images.unsplash.com/photo-1682687220923-c58b9a4592ae?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //                                       imageUrl:
    //                                       controller.selectedUser.value.profilePic.toString(),
    //                                       fit: BoxFit.cover,
    //                                       height: 120,
    //                                       width: 120,
    //                                       placeholder: (context, url) => const CircleAvatar(
    //                                         child: Icon(CupertinoIcons.person),
    //                                       ),
    //                                       errorWidget: (context, url, error) =>
    //                                       const CircleAvatar(
    //                                         child: Icon(CupertinoIcons.person),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   // const CircleAvatar(
    //                                   //   radius: 80,
    //                                   //   backgroundImage: AssetImage("assets/images/profile.png"),
    //                                   // ),
    //                                   if(chatController.isUserOnline(controller.selectedUser.value.id!))
    //                                     const Positioned(
    //                                       bottom: -02,
    //                                       right: -02,
    //                                       child: CircleAvatar(
    //                                         radius: 20,
    //                                         backgroundColor: Colors.white, // Color(0xFFffb800),
    //                                         child: CircleAvatar(
    //                                           radius: 12,
    //                                           backgroundColor: Color(0xFF2ECC24),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   if(controller.isAddedToFavouriteList(controller.selectedUser.value.id!))
    //                                     Positioned(
    //                                       top: -08,
    //                                       right: -15,
    //                                       child: GestureDetector(
    //                                         // onTap: () => controller.addUserToInterestedList(
    //                                         //   userID: controller.selectedUser.value.id!,
    //                                         // ),
    //                                         child: const Icon(Icons.favorite_outlined,
    //                                           color: Color(0xffEE4B2B),
    //                                           size: 35,
    //                                         ),
    //                                       ),
    //                                     )
    //                                   else
    //                                     Positioned(
    //                                       top: -08,
    //                                       right: -15,
    //                                       child: GestureDetector(
    //                                         onTap: () => controller.addUserToInterestedList(
    //                                           userID: controller.selectedUser.value.id!,
    //                                         ),
    //                                         child: Icon(
    //                                           isLiked ? Icons.favorite_outlined: Icons.favorite_border,
    //                                           color: isLiked ? const Color(0xffEE4B2B): const Color(0xFFC0B4CC),
    //                                           size: 35,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                           const SizedBox(height: 20),
    //                           Row(
    //                             children: [
    //                               if(controller.selectedUser.value.createdAt != null)
    //                                 Container(
    //                                   decoration: BoxDecoration(
    //                                     border: Border.all(
    //                                       color: AppColors.blueColor,
    //                                     ),
    //                                   ),
    //                                   padding: const EdgeInsets.all(5),
    //                                   child: Column(
    //                                     children: [
    //                                       const Text(
    //                                         "Date of registration",
    //                                         style: TextStyle(
    //                                           color: AppColors.blueColor,
    //                                         ),
    //                                       ),
    //                                       Text(
    //                                         MyDateUtil.formatDateTime(controller.selectedUser.value.createdAt!),
    //                                         style: const TextStyle(
    //                                           color: AppColors.blueColor,
    //                                         ),
    //                                       )
    //                                     ],
    //                                   )
    //                                 ),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   )
    //               ],
    //             ),
    //           )
    //         else
    //           Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Expanded(
    //                     flex: 2,
    //                     child: Column(
    //                       children: [
    //                         Container(
    //                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    //                           child: const Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Text(
    //                                 "My Settings",
    //                                 style: TextStyle(
    //                                   fontSize: 18,
    //                                   fontFamily: "myFontLight",
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Color(0xFF574667),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 10),
    //                               Padding(
    //                                 padding: EdgeInsets.symmetric(horizontal: 20.0),
    //                                 child: Text(
    //                                   "You can adjust the following settings",
    //                                   style: TextStyle(
    //                                     fontSize: 13,
    //                                     color: Color(0xFFC0B4CC),
    //                                   ),
    //                                   textAlign: TextAlign.center,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         const SizedBox(height: 20),
    //                         Container(
    //                           decoration: const BoxDecoration(
    //                             color: Colors.white,
    //                           ),
    //                           padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
    //                           child: Column(
    //                             children: [
    //                               if(user != null && user.onlineStatus != null)
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     Obx(() {
    //                                       return CustomSwitch(
    //                                         checkBoxValue: chatController.isOnlineStatusVisible.value,
    //                                         backgroundColor: Colors.grey.withOpacity(0.3),
    //                                         activeColor: Colors.green,
    //                                         onChangedFunction: chatController.onOnlineStatusChanged,
    //                                       );
    //                                     }),
    //                                     const Text("Change your online status")
    //                                   ],
    //                                 ),
    //                               if(user != null && user.activateNotifications != null)
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     CustomSwitch(
    //                                       checkBoxValue: user.activateNotifications!,
    //                                       onChangedFunction: () {},
    //                                       backgroundColor: Colors.grey.withOpacity(0.3),
    //                                       activeColor: Colors.green,
    //                                     ),
    //                                     const Text("Activated notifications")
    //                                   ],
    //                                 ),
    //                               if(user != null && user.emailNotificationsEnabled != null)
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     CustomSwitch(
    //                                       checkBoxValue: user.emailNotificationsEnabled!,
    //                                       onChangedFunction: (bool value) => {
    //                                         print("value $value")
    //                                       },
    //                                       backgroundColor: Colors.grey.withOpacity(0.3),
    //                                       activeColor: Colors.green,
    //                                     ),
    //                                     const Text("Send notifications to my email")
    //                                   ],
    //                                 ),
    //                               // if(user != null && user.interestListEnabled != null)
    //                               //   Row(
    //                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               //     children: [
    //                               //       CustomSwitch(
    //                               //         checkBoxValue: user.interestListEnabled!,
    //                               //         onChangedFunction: () {},
    //                               //         backgroundColor: Colors.grey.withOpacity(0.3),
    //                               //         activeColor: Colors.green,
    //                               //       ),
    //                               //       const Text("Who added me to his interest?")
    //                               //     ],
    //                               //   ),
    //                               // if(user != null && user.whoVisitedProfileEnabled != null)
    //                               //   Row(
    //                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               //     children: [
    //                               //       CustomSwitch(
    //                               //         checkBoxValue: user.whoVisitedProfileEnabled!,
    //                               //         onChangedFunction: () {},
    //                               //         backgroundColor: Colors.grey.withOpacity(0.3),
    //                               //         activeColor: Colors.green,
    //                               //       ),
    //                               //       const Text("Who visited my profile?")
    //                               //     ],
    //                               //   ),
    //                               // if(user != null && user.whoAddedMeToIgnoreEnabled != null)
    //                               //   Row(
    //                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               //     children: [
    //                               //       CustomSwitch(
    //                               //         checkBoxValue: user.whoAddedMeToIgnoreEnabled!,
    //                               //         onChangedFunction: () {},
    //                               //         backgroundColor: Colors.grey.withOpacity(0.3),
    //                               //         activeColor: Colors.green,
    //                               //       ),
    //                               //       const Text("Who added me to your ignore list?")
    //                               //     ],
    //                               //   ),
    //                               // if(user != null && user.whoRemovedMeFromIgnoreEnabled != null)
    //                               //   Row(
    //                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               //     children: [
    //                               //       CustomSwitch(
    //                               //         checkBoxValue: user.whoRemovedMeFromIgnoreEnabled!,
    //                               //         onChangedFunction: () {},
    //                               //         backgroundColor: Colors.grey.withOpacity(0.3),
    //                               //         activeColor: Colors.green,
    //                               //       ),
    //                               //       const Text("Who removed me from my ignore list?")
    //                               //     ],
    //                               //   ),
    //                               if(user != null && user.receiveNewMessagesEnabled != null)
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     CustomSwitch(
    //                                       checkBoxValue: user.receiveNewMessagesEnabled!,
    //                                       onChangedFunction: () {},
    //                                       backgroundColor: Colors.grey.withOpacity(0.3),
    //                                       activeColor: Colors.green,
    //                                     ),
    //                                     const Text("Receive new messages")
    //                                   ],
    //                                 ),
    //                               // if(user != null && user.whoPermittedMeGalleryEnabled != null)
    //                               //   Row(
    //                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               //     children: [
    //                               //       CustomSwitch(
    //                               //         checkBoxValue: user.whoPermittedMeGalleryEnabled!,
    //                               //         onChangedFunction: () {},
    //                               //         backgroundColor: Colors.grey.withOpacity(0.3),
    //                               //         activeColor: Colors.green,
    //                               //       ),
    //                               //       const Text("Members who let me see their photos")
    //                               //     ],
    //                               //   ),
    //                               // if(user != null && user.successStoriesEnabled != null)
    //                               //   Row(
    //                               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               //     children: [
    //                               //       CustomSwitch(
    //                               //         checkBoxValue: user.successStoriesEnabled!,
    //                               //         onChangedFunction: () {},
    //                               //         backgroundColor: Colors.grey.withOpacity(0.3),
    //                               //         activeColor: Colors.green,
    //                               //       ),
    //                               //       const Text("New Success Stories")
    //                               //     ],
    //                               //   ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(width: 20),
    //                   SideBarMenus(),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         const SizedBox(height: 50),
    //       ],
    //     ),
    //   );
    // }
    // );
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          UserDataModel? user = controller.userData.user;
          UserDataModel? selectedUser = controller.selectedUser.value;
          PhotoPermission? userPhotos = selectedUser.photosPermission;
          int? age = MyDateUtil.calculateAge(selectedUser.dateOfBirth);
          return WillPopScope(
            onWillPop: () async {
              navController.previousIndex.value = navController.selectedNavIndex;
              navController.handleNavIndexChanged(1);
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
                      child: Column(
                        children: [
                          FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  if(controller.ignoredUsers.any((user) => user.id == selectedUser.id))
                                    InkWell(
                                      onTap: () => controller.removeUserFromIgnoreList(selectedUser.id!),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.blueColor.withOpacity(0.5),
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Un-Ignore",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Image.asset(
                                              Images.ignore,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    InkWell(
                                      onTap: () => controller.addUserToIgnoreList(selectedUser.id!),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.blueColor,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Ignore",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Image.asset(
                                              Images.ignore,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 5),
                                  if(selectedUser.hasReported == true)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blueColor.withOpacity(0.5),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Reported",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Image.asset(
                                            Images.report,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    InkWell(
                                      onTap: () => controller.reportUser(selectedUser.id!),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.blueColor,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Report",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Image.asset(
                                              Images.report,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 5),
                                  if(userPhotos != null && userPhotos.hasAsked == true)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blueColor.withOpacity(0.5),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text(
                                            userPhotos.status == 0 ? "Requested": "Accepted",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Image.asset(
                                            Images.askPhotos,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    InkWell(
                                      onTap: () => controller.askForPhotos(selectedUser.id!),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.blueColor,
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Ask for photos",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Image.asset(
                                              Images.askPhotos,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  // const SizedBox(width: 5),
                                  // Container(
                                  //   decoration: const BoxDecoration(
                                  //     color: AppColors.blueColor,
                                  //   ),
                                  //   padding: const EdgeInsets.all(5),
                                  //   child: Row(
                                  //     children: [
                                  //       const Text(
                                  //         "Message",
                                  //         style: TextStyle(
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //       Image.asset(
                                  //         Images.edit,
                                  //         color: Colors.white,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                        ),
                        const SizedBox(height: 20),
                          Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: selectedUser.profilePic.toString(),
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: 120,
                                    placeholder: (context, url) => const CircleAvatar(
                                      child: Icon(CupertinoIcons.person),
                                    ),
                                    errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                      child: Icon(CupertinoIcons.person),
                                    ),
                                  ),
                                ),
                                // const CircleAvatar(
                                //   radius: 80,
                                //   backgroundImage: AssetImage("assets/images/profile.png"),
                                // ),
                                if(chatController.isUserOnline(selectedUser.id!))
                                  const Positioned(
                                    bottom: -02,
                                    right: -02,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white, // Color(0xFFffb800),
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Color(0xFF2ECC24),
                                      ),
                                    ),
                                  ),
                                if(controller.isAddedToFavouriteList(selectedUser.id!))
                                  Positioned(
                                    top: -08,
                                    right: -15,
                                    child: GestureDetector(
                                      onTap: () => controller.removeUserFromInterestedList(
                                        userID: selectedUser.id!,
                                      ),
                                      child: const Icon(Icons.favorite_outlined,
                                        color: Color(0xffEE4B2B),
                                        size: 35,
                                      ),
                                    ),
                                  )
                                else
                                  Positioned(
                                    top: -08,
                                    right: -15,
                                    child: GestureDetector(
                                      onTap: () => controller.addUserToInterestedList(
                                        userID: selectedUser.id!,
                                      ),
                                      child: const Icon(
                                        Icons.favorite_border,
                                        color: Color(0xFFC0B4CC),
                                        size: 35,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${selectedUser.firstName}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "myFontLight",
                                  color: themeController.isDarkMode.isTrue ?
                                  Colors.white:const Color(0xFF574667),
                                ),
                              ),
                              const SizedBox(width: 10),
                              if(selectedUser.verified == true)
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image(image: AssetImage("assets/images/verify.png")),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //     height: 20,
                              //     width: 20,
                              //     child: const Image(image: AssetImage("assets/images/flag.png"))),
                              const SizedBox(width: 10),
                              if(selectedUser.country != null && selectedUser.city != null)
                                Text(
                                  "${selectedUser.city}, ${selectedUser.country}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "myFontLight",
                                    color: themeController.isDarkMode.isTrue ?
                                    Colors.white:const Color(0xFF574667),
                                  ),
                                )
                              else if(selectedUser.city != null)
                                Text(
                                  "${selectedUser.city}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "myFontLight",
                                    color: themeController.isDarkMode.isTrue ?
                                    Colors.white:const Color(0xFF574667),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(selectedUser.education == null ||selectedUser.education != "")
                                Container(
                                  height: Get.height / 20,
                                  padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFD9E7),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                          image: AssetImage("assets/images/cap.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${selectedUser.education}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // const SizedBox(width: 10),
                              // Container(
                              //   height: Get.height / 20,
                              //   padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 20),
                              //   decoration: BoxDecoration(
                              //     color: const Color(0xFFFFD9E7),
                              //     borderRadius: BorderRadius.circular(50),
                              //   ),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Container(
                              //         height: 20,
                              //         width: 20,
                              //         child: const Image(
                              //           image: AssetImage("assets/images/moon.png"),
                              //           fit: BoxFit.cover,
                              //         ),
                              //       ),
                              //       const SizedBox(width: 10),
                              //       const Text(
                              //         "Practising",
                              //         style: TextStyle(
                              //           fontSize: 15,
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70.0),
                            child: GestureDetector(
                              onTap: () async {
                                bool sameCountryChat = controller.isPermissionEnabled(permissionName: permissionSameCountryChat);
                                bool result = controller.isPermissionEnabled(permissionName: permissionUnlimitedConversations);
                                if(sameCountryChat && !controller.userHasSameCountry(selectedUser.country)) {
                                  showShortToast("You can only chat with people from the same country as yours");
                                } else if (result) {
                                  int? limit = controller.getPermissionLimitEnabled(permissionName: permissionUnlimitedConversations);
                                  if(limit != null) {
                                    if(controller.userConversations.any((element) => element.username == selectedUser.username)) {
                                      chatController.selectedConversation.conversationId = null;
                                      chatController.handleUserConversation(
                                        fromUserId: controller.userData.user!.id!,
                                        toUserId: selectedUser.id!,
                                      );
                                      log("old conversation $selectedUser");
                                      Get.to(()=> const ChatScreen());
                                    } else {
                                      Dialogs.showLoadingDialog();
                                      await controller.getAllUserConversations();
                                      int conversationsCount = controller.userConversations.length;
                                      if(conversationsCount < limit) {
                                        Get.back();
                                        chatController.selectedConversation.conversationId = null;
                                        chatController.handleUserConversation(
                                          fromUserId: controller.userData.user!.id!,
                                          toUserId: selectedUser.id!,
                                        );
                                        log("conversation $selectedUser");
                                        Get.to(()=> const ChatScreen());
                                      } else {
                                        Get.back();
                                        showShortToast("You have reached the limit of conversations");
                                      }
                                    }
                                  }
                                } else {
                                  showShortToast("You don't have the permission to initiate conversation");
                                }
                              },
                              child: Container(
                                height: Get.height / 15,
                                width: Get.width / 1.6,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF27B2CC),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Send a message",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image(
                                        image: AssetImage("assets/images/msg.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset:
                                        const Offset(0, 5), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: themeController.isDarkMode.isTrue ?
                                    ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9): Colors.white,
                                  ),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                  width: Get.width / 1.1,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width / 1.2,
                                        child: Text(
                                          "About me",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.white:const Color(0xFF574667),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if(selectedUser.maritalStatus != null || selectedUser.appearance != null)
                                                Row(
                                                  children: [
                                                    if(selectedUser.appearance != null && selectedUser.appearance!.height != null)
                                                      ...[
                                                        bars(
                                                          txt: "${selectedUser.appearance?.height}",
                                                          // txt: "${controller.selectedUser.value.appearance?.height} (5’4”)",
                                                          img: "assets/images/height.png",
                                                        ),
                                                        const SizedBox(width: 05),
                                                      ],
                                                    if(selectedUser.maritalStatus != "")
                                                      bars(
                                                        txt: "${selectedUser.maritalStatus}",
                                                        img: "assets/images/ring.png",
                                                      ),
                                                  ],
                                                ),
                                              if(selectedUser.children == null)
                                                bars(
                                                  txt: "Doesn’t have children",
                                                  img: "assets/images/kid.png",
                                                )
                                              else
                                                bars(
                                                  txt: "Have ${selectedUser.children} children",
                                                  img: "assets/images/kid.png",
                                                ),
                                              // bars(
                                              //   txt: "Marraige within a year",
                                              //   img: "assets/images/calender.png",
                                              // ),
                                              if(selectedUser.willingToRelocate != null && selectedUser.willingToRelocate == false)
                                                bars(
                                                  txt: "Won’t move abroad",
                                                  img: "assets/images/airplan.png",
                                                )
                                              else if(selectedUser.willingToRelocate == true)
                                                bars(
                                                  txt: "Will move abroad",
                                                  img: "assets/images/airplan.png",
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset:
                                        const Offset(0, 5), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: themeController.isDarkMode.isTrue ?
                                    ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9):Colors.white,
                                  ),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                  width: Get.width / 1.1,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width / 1.2,
                                        child: Text(
                                          "Religiosity",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.white:const Color(0xFF574667),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if(selectedUser.religion != null)
                                                Row(
                                                  children: [
                                                    if(selectedUser.religion != "")
                                                      ...[
                                                        bars(
                                                          txt: "${selectedUser.religion}",
                                                          img: "assets/images/moon.png",
                                                        ),
                                                        const SizedBox(width: 05),
                                                      ],
                                                    if(selectedUser.subReligion != null && selectedUser.subReligion!.isNotEmpty)
                                                      ...[
                                                        bars(
                                                          txt: "${selectedUser.subReligion}",
                                                          img: "assets/images/moon.png",
                                                        ),
                                                        const SizedBox(width: 05),
                                                      ]
                                                    else if(selectedUser.prayer != null && selectedUser.prayer == true)
                                                      bars(
                                                        txt: "Always prays",
                                                        img: "assets/images/pray.png",
                                                      )
                                                    else
                                                      bars(
                                                        txt: "Doesn't pray",
                                                        img: "assets/images/pray.png",
                                                      ),
                                                    // const SizedBox(width: 05),
                                                    // bars(
                                                    //   txt: "Modest",
                                                    //   img: "assets/images/man.png",
                                                    // ),
                                                  ],
                                                ),
                                              // Row(
                                              //   children: [
                                              //     bars(
                                              //       txt: "Practising",
                                              //       img: "assets/images/moon.png",
                                              //     ),
                                              //     const SizedBox(width: 05),
                                              //   ],
                                              // ),
                                              if(selectedUser.appearance != null)
                                                Row(
                                                  children: [
                                                    if(selectedUser.subReligion != null  && selectedUser.prayer != null && selectedUser.prayer == true)
                                                      bars(
                                                        txt: "Always prays",
                                                        img: "assets/images/pray.png",
                                                      )
                                                    else
                                                      bars(
                                                        txt: "Doesn't pray",
                                                        img: "assets/images/pray.png",
                                                      ),
                                                    const SizedBox(width: 05),
                                                    if(selectedUser.appearance?.smoking == false)
                                                      bars(
                                                        txt: "Non-smoker",
                                                        img: "assets/images/cig.png",
                                                      ),
                                                    if(selectedUser.appearance?.smoking == true)
                                                      bars(
                                                        txt: "Smoker",
                                                        img: "assets/images/cig.png",
                                                      ),
                                                  ],
                                                ),
                                              // bars(
                                              //   txt: "Doesn’t drink",
                                              //   img: "assets/images/drink.png",
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset:
                                        const Offset(0, 5), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: themeController.isDarkMode.isTrue ?
                                    ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9):Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 25,
                                    horizontal: 20,
                                  ),
                                  width: Get.width / 1.1,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width / 1.2,
                                        child: Text(
                                          "Interests",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.white:const Color(0xFF574667),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      if(selectedUser.interestsList != null)
                                        SizedBox(
                                          height: calculateHeight(
                                            selectedUser.interestsList!.isNotEmpty ?
                                            selectedUser.interestsList!.length: 1,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if(selectedUser.interestsList!.isNotEmpty)
                                                Expanded(
                                                  child:  GridView.builder(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 0.0,
                                                      crossAxisSpacing: 0.0,
                                                      childAspectRatio: 3.50,
                                                    ),
                                                    itemCount: selectedUser.interestsList?.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Row(
                                                        children: [
                                                          bars(
                                                            txt: selectedUser.interestsList![index].title,
                                                            img: "assets/images/tv.png",
                                                          ),
                                                          // const SizedBox(width: 05),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                            ],
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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
                                  Center(
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipOval(
                                          child: CachedNetworkImage(
                                            // imageUrl: "https://images.unsplash.com/photo-1682687220923-c58b9a4592ae?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                            imageUrl: selectedUser.profilePic.toString(),
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: 120,
                                            placeholder: (context, url) => const CircleAvatar(
                                              child: Icon(CupertinoIcons.person),
                                            ),
                                            errorWidget: (context, url, error) =>
                                            const CircleAvatar(
                                              child: Icon(CupertinoIcons.person),
                                            ),
                                          ),
                                        ),
                                        // const CircleAvatar(
                                        //   radius: 80,
                                        //   backgroundImage: AssetImage("assets/images/profile.png"),
                                        // ),
                                        if(chatController.isUserOnline(selectedUser.id!))
                                          const Positioned(
                                            bottom: -02,
                                            right: -02,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white, // Color(0xFFffb800),
                                              child: CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Color(0xFF2ECC24),
                                              ),
                                            ),
                                          ),
                                        if(controller.isAddedToFavouriteList(selectedUser.id!))
                                          Positioned(
                                               top: -08,
                                            right: -15,
                                            child: GestureDetector(
                                              onTap: () => controller.removeUserFromInterestedList(
                                                userID: selectedUser.id!,
                                              ),
                                              child: const Icon(Icons.favorite_outlined,
                                                color: Color(0xffEE4B2B),
                                                size: 35,
                                              ),
                                            ),
                                          )
                                        else
                                          Positioned(
                                            top: -08,
                                            right: -15,
                                            child: GestureDetector(
                                              onTap: () => controller.addUserToInterestedList(
                                                userID: selectedUser.id!,
                                              ),
                                              child: const Icon(
                                                Icons.favorite_border,
                                                color: Color(0xFFC0B4CC),
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${selectedUser.firstName}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "myFontLight",
                                          color: Color(0xFF574667),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      if(selectedUser.verified == true)
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image(image: AssetImage("assets/images/verify.png")),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Container(
                                      //     height: 20,
                                      //     width: 20,
                                      //     child: const Image(image: AssetImage("assets/images/flag.png"))),
                                      const SizedBox(width: 10),
                                      if(selectedUser.country != null && selectedUser.city != null)
                                        Text(
                                          "${selectedUser.city}, ${selectedUser.country}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200,
                                            fontFamily: "myFontLight",
                                            color: Color(0xFF574667),
                                          ),
                                        )
                                      else if(selectedUser.city != null)
                                        Text(
                                          "${selectedUser.city}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200,
                                            fontFamily: "myFontLight",
                                            color: Color(0xFF574667),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if(selectedUser.education == null || selectedUser.education != "")
                                        Container(
                                          height: Get.height / 20,
                                          padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFD9E7),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Image(
                                                  image: AssetImage("assets/images/cap.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "${selectedUser.education}",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      // const SizedBox(width: 10),
                                      // Container(
                                      //   height: Get.height / 20,
                                      //   padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 20),
                                      //   decoration: BoxDecoration(
                                      //     color: const Color(0xFFFFD9E7),
                                      //     borderRadius: BorderRadius.circular(50),
                                      //   ),
                                      //   child: Row(
                                      //     crossAxisAlignment: CrossAxisAlignment.center,
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Container(
                                      //         height: 20,
                                      //         width: 20,
                                      //         child: const Image(
                                      //           image: AssetImage("assets/images/moon.png"),
                                      //           fit: BoxFit.cover,
                                      //         ),
                                      //       ),
                                      //       const SizedBox(width: 10),
                                      //       const Text(
                                      //         "Practising",
                                      //         style: TextStyle(
                                      //           fontSize: 15,
                                      //         ),
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        chatController.selectedConversation.conversationId = null;
                                        chatController.handleUserConversation(
                                          fromUserId: controller.userData.user!.id!,
                                          toUserId: selectedUser.id!,
                                        );
                                        log("conversation $selectedUser");
                                        Get.to(()=> const ChatScreen());
                                      },
                                      child: Container(
                                        height: Get.height / 15,
                                        width: Get.width / 1.6,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF27B2CC),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 7,
                                              offset: const Offset(0, 2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Send a message",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Image(
                                                image: AssetImage("assets/images/msg.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.8),
                                                spreadRadius: 5,
                                                blurRadius: 10,
                                                offset:
                                                const Offset(0, 5), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          padding:
                                          const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          width: Get.width / 1.1,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: Get.width / 1.2,
                                                child: const Text(
                                                  "About me",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF574667),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      if(selectedUser.maritalStatus != null || selectedUser.appearance != null)
                                                        Row(
                                                          children: [
                                                            if(selectedUser.appearance != null && selectedUser.appearance!.height != null)
                                                              ...[
                                                                bars(
                                                                  txt: "${selectedUser.appearance?.height}",
                                                                  // txt: "${controller.selectedUser.value.appearance?.height} (5’4”)",
                                                                  img: "assets/images/height.png",
                                                                ),
                                                                const SizedBox(width: 05),
                                                              ],
                                                            if(selectedUser.maritalStatus != "")
                                                              bars(
                                                                txt: "${selectedUser.maritalStatus}",
                                                                img: "assets/images/ring.png",
                                                              ),
                                                          ],
                                                        ),
                                                      if(selectedUser.children == null)
                                                        bars(
                                                          txt: "Doesn’t have children",
                                                          img: "assets/images/kid.png",
                                                        )
                                                      else
                                                        bars(
                                                          txt: "Have ${selectedUser.children} children",
                                                          img: "assets/images/kid.png",
                                                        ),
                                                      // bars(
                                                      //   txt: "Marraige within a year",
                                                      //   img: "assets/images/calender.png",
                                                      // ),
                                                      if(selectedUser.willingToRelocate != null && selectedUser.willingToRelocate == false)
                                                        bars(
                                                          txt: "Won’t move abroad",
                                                          img: "assets/images/airplan.png",
                                                        )
                                                      else if(selectedUser.willingToRelocate == true)
                                                        bars(
                                                          txt: "Will move abroad",
                                                          img: "assets/images/airplan.png",
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.8),
                                                spreadRadius: 5,
                                                blurRadius: 10,
                                                offset:
                                                const Offset(0, 5), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          padding:
                                          const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          width: Get.width / 1.1,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: Get.width / 1.2,
                                                child: const Text(
                                                  "Religiosity",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF574667),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      if(selectedUser.religion != null)
                                                        Row(
                                                          children: [
                                                            if(selectedUser.religion != "")
                                                              ...[
                                                                bars(
                                                                  txt: "${selectedUser.religion}",
                                                                  img: "assets/images/moon.png",
                                                                ),
                                                                const SizedBox(width: 05),
                                                              ],
                                                            if(selectedUser.subReligion != null && selectedUser.subReligion != "")
                                                              ...[
                                                                bars(
                                                                  txt: "${selectedUser.subReligion}",
                                                                  img: "assets/images/moon.png",
                                                                ),
                                                                const SizedBox(width: 05),
                                                              ]
                                                            else if(selectedUser.prayer != null && selectedUser.prayer == true)
                                                              bars(
                                                                txt: "Always prays",
                                                                img: "assets/images/pray.png",
                                                              )
                                                            else
                                                              bars(
                                                                txt: "Doesn't pray",
                                                                img: "assets/images/pray.png",
                                                              ),
                                                            // const SizedBox(width: 05),
                                                            // bars(
                                                            //   txt: "Modest",
                                                            //   img: "assets/images/man.png",
                                                            // ),
                                                          ],
                                                        ),
                                                      // Row(
                                                      //   children: [
                                                      //     bars(
                                                      //       txt: "Practising",
                                                      //       img: "assets/images/moon.png",
                                                      //     ),
                                                      //     const SizedBox(width: 05),
                                                      //   ],
                                                      // ),
                                                      if(selectedUser.appearance != null)
                                                        Row(
                                                          children: [
                                                            if(selectedUser.subReligion != null  && selectedUser.prayer != null && selectedUser.prayer == true)
                                                              bars(
                                                                txt: "Always prays",
                                                                img: "assets/images/pray.png",
                                                              )
                                                            else
                                                              bars(
                                                                txt: "Doesn't pray",
                                                                img: "assets/images/pray.png",
                                                              ),
                                                            if(selectedUser.appearance?.smoking == false)
                                                              bars(
                                                                txt: "Non-smoker",
                                                                img: "assets/images/cig.png",
                                                              ),
                                                            if(selectedUser.appearance?.smoking == true)
                                                              bars(
                                                                txt: "Smoker",
                                                                img: "assets/images/cig.png",
                                                              ),
                                                          ],
                                                        ),
                                                      // bars(
                                                      //   txt: "Doesn’t drink",
                                                      //   img: "assets/images/drink.png",
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        clipBehavior: Clip.hardEdge,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.8),
                                                  spreadRadius: 5,
                                                  blurRadius: 10,
                                                  offset:
                                                  const Offset(0, 5), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          padding:
                                          const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                          width: Get.width / 1.1,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: Get.width / 1.2,
                                                child: const Text(
                                                  "Interests",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xFF574667)),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if(selectedUser.interestsList != null)
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: calculateHeight(
                                                          selectedUser.interestsList!.isNotEmpty ?
                                                          selectedUser.interestsList!.length: 1,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            if(selectedUser.interestsList!.isNotEmpty)
                                                              Expanded(
                                                                child: GridView.builder(
                                                                  shrinkWrap: true,
                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount: 2,
                                                                    mainAxisSpacing: 0.0,
                                                                    crossAxisSpacing: 0.0,
                                                                    childAspectRatio: 3.50,
                                                                  ),
                                                                  itemCount: selectedUser.interestsList?.length,
                                                                  itemBuilder: (BuildContext context, int index) {
                                                                    return Row(
                                                                      children: [
                                                                        bars(
                                                                          txt: selectedUser.interestsList![index].title,
                                                                          img: "assets/images/tv.png",
                                                                        ),
                                                                        // const SizedBox(width: 05),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
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
    return GetBuilder<UserController>(builder: (UserController controller) {
        return Material(
          child: Container(
            height: Get.height,
            width: Get.width,
            color: mainClr,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: Get.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: Get.height / 15,
                          width: Get.height / 15,
                          child: const Image(image: AssetImage("assets/images/iconMain.png")),
                        ),
                        SizedBox(
                          height: Get.height / 15,
                          width: Get.height / 15,
                          child: const Image(image: AssetImage("assets/images/menu.png")),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          // imageUrl: "https://images.unsplash.com/photo-1682687220923-c58b9a4592ae?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          imageUrl:
                          controller.selectedUser.value.profilePic.toString(),
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                          placeholder: (context, url) => const CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),
                          errorWidget: (context, url, error) =>
                          const CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),
                        ),
                      ),
                      // const CircleAvatar(
                      //   radius: 80,
                      //   backgroundImage: AssetImage("assets/images/profile.png"),
                      // ),
                      if(chatController.isUserOnline(controller.selectedUser.value.id!))
                        const Positioned(
                          bottom: -02,
                          right: -02,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white, // Color(0xFFffb800),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Color(0xFF2ECC24),
                            ),
                          ),
                        ),
                      if(controller.isAddedToFavouriteList(controller.selectedUser.value.id!))
                        Positioned(
                          top: -08,
                          right: -15,
                          child: GestureDetector(
                            // onTap: () => controller.addUserToInterestedList(
                            //   userID: controller.selectedUser.value.id!,
                            // ),
                            child: const Icon(Icons.favorite_outlined,
                              color: Color(0xffEE4B2B),
                              size: 35,
                            ),
                          ),
                        )
                      else
                        Positioned(
                          top: -08,
                          right: -15,
                          child: GestureDetector(
                            onTap: () => controller.addUserToInterestedList(
                              userID: controller.selectedUser.value.id!,
                            ),
                            child: Icon(
                              isLiked ? Icons.favorite_outlined: Icons.favorite_border,
                              color: isLiked ? const Color(0xffEE4B2B): const Color(0xFFC0B4CC),
                              size: 35,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${controller.selectedUser.value.firstName}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "myFontLight",
                        color: Color(0xFF574667),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if(controller.selectedUser.value.verified == true)
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: Image(image: AssetImage("assets/images/verify.png")),
                      )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //     height: 20,
                    //     width: 20,
                    //     child: const Image(image: AssetImage("assets/images/flag.png"))),
                    const SizedBox(width: 10),
                    if(controller.selectedUser.value.country != null && controller.selectedUser.value.city != null)
                      Text(
                        "${controller.selectedUser.value.city}, ${controller.selectedUser.value.country}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          fontFamily: "myFontLight",
                          color: Color(0xFF574667),
                        ),
                      )
                    else if(controller.selectedUser.value.city != null)
                      Text(
                        "${controller.selectedUser.value.city}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          fontFamily: "myFontLight",
                          color: Color(0xFF574667),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(controller.selectedUser.value.education == null ||controller.selectedUser.value.education != "")
                      Container(
                        height: Get.height / 20,
                        padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD9E7),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: Image(
                                image: AssetImage("assets/images/cap.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${controller.selectedUser.value.education}",
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    // const SizedBox(width: 10),
                    // Container(
                    //   height: Get.height / 20,
                    //   padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 20),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFFFFD9E7),
                    //     borderRadius: BorderRadius.circular(50),
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         height: 20,
                    //         width: 20,
                    //         child: const Image(
                    //           image: AssetImage("assets/images/moon.png"),
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //       const SizedBox(width: 10),
                    //       const Text(
                    //         "Practising",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: GestureDetector(
                    onTap: () {
                      chatController.selectedConversation.conversationId = null;
                      chatController.handleUserConversation(
                        fromUserId: controller.userData.user!.id!,
                        toUserId: controller.selectedUser.value.id!,
                      );
                      log("conversation ${controller.selectedUser.value}");
                      Get.to(()=> const ChatScreen());
                    },
                    child: Container(
                      height: Get.height / 15,
                      width: Get.width / 1.6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF27B2CC),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Send a message",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image(
                              image: AssetImage("assets/images/msg.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset:
                              const Offset(0, 5), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        padding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                        width: Get.width / 1.1,
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width / 1.2,
                              child: const Text(
                                "About me",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF574667),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if(controller.selectedUser.value.maritalStatus != null || controller.selectedUser.value.appearance != null)
                                    Row(
                                      children: [
                                        if(controller.selectedUser.value.appearance != null && controller.selectedUser.value.appearance!.height != null)
                                          ...[
                                            bars(
                                              txt: "${controller.selectedUser.value.appearance?.height}",
                                              // txt: "${controller.selectedUser.value.appearance?.height} (5’4”)",
                                              img: "assets/images/height.png",
                                            ),
                                            const SizedBox(width: 05),
                                          ],
                                        if(controller.selectedUser.value.maritalStatus != "")
                                          bars(
                                            txt: "${controller.selectedUser.value.maritalStatus}",
                                            img: "assets/images/ring.png",
                                          ),
                                      ],
                                    ),
                                    if(controller.selectedUser.value.children == null)
                                      bars(
                                        txt: "Doesn’t have children",
                                        img: "assets/images/kid.png",
                                      )
                                    else
                                      bars(
                                        txt: "Have ${controller.selectedUser.value.children} children",
                                        img: "assets/images/kid.png",
                                      ),
                                    // bars(
                                    //   txt: "Marraige within a year",
                                    //   img: "assets/images/calender.png",
                                    // ),
                                    if(controller.selectedUser.value.willingToRelocate != null && controller.selectedUser.value.willingToRelocate == false)
                                      bars(
                                        txt: "Won’t move abroad",
                                        img: "assets/images/airplan.png",
                                      )
                                    else if(controller.selectedUser.value.willingToRelocate == true)
                                      bars(
                                        txt: "Will move abroad",
                                        img: "assets/images/airplan.png",
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset:
                              const Offset(0, 5), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        padding:
                        const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                        width: Get.width / 1.1,
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width / 1.2,
                              child: const Text(
                                "Religiosity",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF574667),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if(controller.selectedUser.value.religion != null)
                                      Row(
                                        children: [
                                          if(controller.selectedUser.value.religion != "")
                                            ...[
                                              bars(
                                                txt: "${controller.selectedUser.value.religion}",
                                                img: "assets/images/moon.png",
                                              ),
                                              const SizedBox(width: 05),
                                            ],
                                          if(controller.selectedUser.value.prayer != null && controller.selectedUser.value.prayer == true)
                                            bars(
                                              txt: "Always prays",
                                              img: "assets/images/pray.png",
                                            )
                                          else
                                            bars(
                                              txt: "Doesn't pray",
                                              img: "assets/images/pray.png",
                                            ),
                                          // const SizedBox(width: 05),
                                          // bars(
                                          //   txt: "Modest",
                                          //   img: "assets/images/man.png",
                                          // ),
                                        ],
                                      ),
                                    // Row(
                                    //   children: [
                                    //     bars(
                                    //       txt: "Practising",
                                    //       img: "assets/images/moon.png",
                                    //     ),
                                    //     const SizedBox(width: 05),
                                    //   ],
                                    // ),
                                    if(controller.selectedUser.value.appearance != null)
                                    Row(
                                      children: [
                                        // bars(
                                        //   txt: "Only eat halal",
                                        //   img: "assets/images/eat.png",
                                        // ),
                                        // const SizedBox(width: 05),
                                        if(controller.selectedUser.value.appearance?.smoking == false)
                                          bars(
                                            txt: "Non-smoker",
                                            img: "assets/images/cig.png",
                                          ),
                                        if(controller.selectedUser.value.appearance?.smoking == true)
                                          bars(
                                            txt: "Smoker",
                                            img: "assets/images/cig.png",
                                          ),
                                      ],
                                    ),
                                    // bars(
                                    //   txt: "Doesn’t drink",
                                    //   img: "assets/images/drink.png",
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(20),
                    //   clipBehavior: Clip.hardEdge,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.grey.withOpacity(0.8),
                    //             spreadRadius: 5,
                    //             blurRadius: 10,
                    //             offset:
                    //             const Offset(0, 5), // changes position of shadow
                    //           ),
                    //         ],
                    //         borderRadius: BorderRadius.circular(20),
                    //         color: Colors.white),
                    //     padding:
                    //     const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    //     width: Get.width / 1.1,
                    //     child: Column(
                    //       children: [
                    //         Container(
                    //           width: Get.width / 1.2,
                    //           child: const Text(
                    //             "Interests",
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.w500,
                    //                 color: Color(0xFF574667)),
                    //           ),
                    //         ),
                    //         const SizedBox(height: 10),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Column(
                    //               mainAxisSize: MainAxisSize.max,
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     bars(
                    //                       txt: "TV shows",
                    //                       img: "assets/images/tv.png",
                    //                     ),
                    //                     const SizedBox(width: 05),
                    //                     bars(
                    //                       txt: "Travel",
                    //                       img: "assets/images/plan.png",
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   children: [
                    //                     bars(
                    //                       txt: "Standup comedy",
                    //                       img: "assets/images/mask.png",
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   children: [
                    //                     bars(
                    //                       txt: "Family time",
                    //                       img: "assets/images/family.png",
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 bars(
                    //                   txt: "Spending time with friends",
                    //                   img: "assets/images/rename.png",
                    //                 ),
                    //                 Row(
                    //                   children: [
                    //                     bars(
                    //                       txt: "Coffee",
                    //                       img: "assets/images/coffee.png",
                    //                     ),
                    //                     bars(
                    //                       txt: "Eating out",
                    //                       img: "assets/images/eating.png",
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   children: [
                    //                     bars(
                    //                       txt: "Chocolate",
                    //                       img: "assets/images/chocolate.png",
                    //                     ),
                    //                     bars(
                    //                       txt: "Nature walks",
                    //                       img: "assets/images/nature.png",
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 bars(
                    //                   txt: "Completed Umrah",
                    //                   img: "assets/images/umrah.png",
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                )              ],
            ),
          ),
        );
      }
    );
  }
}

class bars extends StatelessWidget {
  var txt;
  var img;
  bars({
    required this.txt,
    required this.img,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 05),
      height: Get.height / 20,
      padding: const EdgeInsets.symmetric(vertical: 05, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
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
              )),
          const SizedBox(width: 05),
          Text(
            txt,
            style: const TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
