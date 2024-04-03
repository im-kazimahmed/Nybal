import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/helpers/local_data_helper.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/potential_matches_ctr.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/data.dart';
import '../../Widgets/theme_data.dart';
import '../../models/user_model.dart';
import '../../widgets/my_date_util.dart';
import '../../widgets/top_bar.dart';
import '../filter_page/filters.dart';

class OnlineMembers extends StatelessWidget {
  OnlineMembers({super.key});
  final controller = Get.find<PotentialMatchesCTR>();
  final navController = Get.find<NavigationController>();
  final LanguageController langController = Get.find<LanguageController>();
  var dropDownValue;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<ChatController>(builder: (ChatController chatController) {
          return GetBuilder<UserController>(builder: (UserController controller) {
            return FutureBuilder(
              future: controller.getAllUsers(),
                builder: (context, snapshot) {
                  List<UserDataModel> onlineUsersList = chatController.countOnlineUsers(controller.usersList);
                  return Obx(() {
                    return SafeArea(
                      child: Column(
                        children: [
                          if(ResponsiveWidget.isSmallScreen(context))
                            const TopBar(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppTags.online.tr,
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
                                  fontSize: 18,
                                  fontFamily: "myFontLight",
                                  fontWeight: FontWeight.w600,
                                  color: themeController.isDarkMode.isTrue ?
                                  Colors.white:const Color(0xFF574667),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 02),
                          Text(
                            '${AppTags.thereAre.tr} ${chatController.countOnlineUsers(controller.usersList).length} ${AppTags.membersOnline.tr}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: "myFontLight",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFC0B4CC),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: Get.height / 15,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      // width: Get.width,
                                      color: themeController.isDarkMode.isTrue ?
                                      ThemeData.dark().scaffoldBackgroundColor: const Color(0xFFF4F4F4),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButton(
                                              // padding: EdgeInsets.only(left: 25, right: 25),
                                              underline: const Text(""),
                                              style: TextStyle(
                                                textBaseline: null,
                                                color: themeController.isDarkMode.isTrue ?
                                                Colors.white:Colors.black,
                                              ),
                                              menuMaxHeight: Get.height / 2,
                                              hint: Text(AppTags.allCountriesHint.tr),
                                              alignment: Alignment.centerLeft,
                                              isExpanded: true,
                                              // Initial Value
                                              value: dropDownValue,
                                              // Down Arrow Icon
                                              icon: const Expanded(child: Icon(Icons.keyboard_arrow_down)),
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
                                                dropDownValue = newValue;
                                              },
                                            ),
                                          ),
                                          ResponsiveWidget.isSmallScreen(context) ? GestureDetector(
                                            onTap: () {
                                              Get.to(() => const Filters_page());
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              height: Get.height / 15,
                                              width: Get.width / 7,
                                              color: themeController.isDarkMode.isTrue ?
                                              ThemeData.dark().scaffoldBackgroundColor:const Color(0xFFF4F4F4),
                                              child: const Image(
                                                image: AssetImage("assets/images/filter.png"),
                                              ),
                                            ),
                                          ): Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {

                                                  },
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      color: AppColors.pinkButton,
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                                                    child: Text(
                                                      AppTags.female.tr,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                InkWell(
                                                  onTap: () {

                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: AppColors.pinkButton),
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                                                    child: Text(
                                                      AppTags.male.tr,
                                                      style: const TextStyle(
                                                        color: AppColors.pinkButton,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20,),
                                                InkWell(
                                                  onTap: () {

                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: AppColors.pinkButton),
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                                                    child: Text(
                                                      AppTags.all.tr,
                                                      style: const TextStyle(
                                                        color: AppColors.pinkButton,
                                                      ),
                                                    ),
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
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if(LocalDataHelper().getUserAllData() != null && LocalDataHelper().getUserToken() != null)
                            SizedBox(
                              height: Get.height / 1.5,
                              width: Get.width / 1.1,
                              // color: Colors.red,
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 100),
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: onlineUsersList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  if(onlineUsersList.isNotEmpty) {
                                    int? age = MyDateUtil.calculateAge(onlineUsersList[index].dateOfBirth);
                                    return Stack(
                                      children: [
                                        Card(
                                          elevation: 7.0,
                                          shadowColor: const Color.fromARGB(255, 224, 224, 224),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(color: AppColors.pinkButton),
                                          ),
                                          // margin: EdgeInsets.all(5),
                                          child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                // horizontal: 10,
                                                vertical: 0,
                                              ),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     width: 1, color: Color(0xFF000000)),
                                                // color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 5.0),
                                                    child: FittedBox(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          if(controller.isAddedToFavouriteList(onlineUsersList[index].id!))
                                                            const Icon(
                                                              Icons.favorite_outlined,
                                                              size: 22,
                                                              color: Color(0xFFffb800),
                                                            )
                                                          else
                                                            const Icon(
                                                              Icons.favorite_border,
                                                              size: 22,
                                                              color: Color(0xFFffb800),
                                                            ),
                                                          const SizedBox(width: 5),
                                                          Text(
                                                            AppTags.whyIAmSeeingThis.tr,
                                                            style: TextStyle(
                                                              fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 4.sp,
                                                              decoration:
                                                              TextDecoration.underline,
                                                              fontFamily: "myFontLight",
                                                              fontWeight: FontWeight.w300,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5),
                                                          SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: SvgPicture.asset(
                                                              "assets/images/chat-heart.svg",
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller.selectedUser.value = onlineUsersList[index];
                                                          controller.addProfileVisitRecord(onlineUsersList[index].id!);
                                                          navController.previousIndex.value = navController.selectedNavIndex;
                                                          navController.handleNavIndexChanged(10);
                                                        },
                                                        child: SizedBox(
                                                          height: 80,
                                                          width: 80,
                                                          child: ClipOval(
                                                            child: CachedNetworkImage(
                                                              imageUrl:
                                                              onlineUsersList[index].profilePic.toString(),
                                                              fit: BoxFit.cover,
                                                              height: 80,
                                                              width: 80,
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
                                                      // CircleAvatar(
                                                      //   radius: 50,
                                                      //   backgroundImage: AssetImage(
                                                      //     "assets/images/profile.png",
                                                      //   ),
                                                      // ),
                                                      if(onlineUsersList[index].isPro == true)
                                                        const Positioned(
                                                          bottom: 0,
                                                          right: 1,
                                                          child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor: Color(0xFFffb800),
                                                            child: SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child: Image(
                                                                image: AssetImage(
                                                                  "assets/images/premium.png",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  GetBuilder<ChatController>(builder: (ChatController chatController) {
                                                    return Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          width: 30,
                                                          child: CachedNetworkImage(
                                                            imageUrl: "${onlineUsersList[index].countryFlag}",
                                                            fit: BoxFit.cover,
                                                            height: 20,
                                                            width: 30,
                                                            placeholder: (context, url) {
                                                              return const CircleAvatar(
                                                                child: Icon(
                                                                  CupertinoIcons.flag_fill,
                                                                ),
                                                              );
                                                            },
                                                            errorWidget: (context, url, error) {
                                                              return const CircleAvatar(
                                                                child: Icon(CupertinoIcons.flag_fill),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(width: 08),
                                                        InkWell(
                                                          onTap: () {
                                                            controller.selectedUser.value = onlineUsersList[index];
                                                            controller.addProfileVisitRecord(onlineUsersList[index].id!);
                                                            navController.previousIndex.value = navController.selectedNavIndex;
                                                            navController.handleNavIndexChanged(10);
                                                            // Get.to(()=> const ProfileViewPage());
                                                            // controller.isProfileViewf(true);
                                                          },
                                                          child: Text(
                                                            onlineUsersList[index].firstName.toString(),
                                                            style: const TextStyle(
                                                              // fontSize: 18,
                                                              fontFamily: "myFontLight",
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0xFF574667),
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 08),
                                                        if(chatController.isUserOnline(onlineUsersList[index].id!))
                                                          const CircleAvatar(
                                                            radius: 5,
                                                            backgroundColor: Colors.green,
                                                          ),
                                                      ],
                                                    );
                                                  }),
                                                  if(onlineUsersList[index].country != "" && age != null && age > 0)
                                                    Text(
                                                      "$age ${AppTags.yearsOldFrom.tr} ${onlineUsersList[index].country}",
                                                      style: const TextStyle(
                                                        // fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                                        // ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                                        fontFamily: "myFontLight",
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFF27B2CC),
                                                      ),
                                                    )
                                                  else if(onlineUsersList[index].country != "")
                                                    Text(
                                                      "${onlineUsersList[index].country}",
                                                      style: const TextStyle(
                                                        // fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                                        // ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                                        fontFamily: "myFontLight",
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFF27B2CC),
                                                      ),
                                                    ),
                                                  // RichText(
                                                  //   text: TextSpan(
                                                  //     children: [
                                                  //       TextSpan(
                                                  //         text: "${age ?? "Unknown"}",
                                                  //       ),
                                                  //       TextSpan(
                                                  //         text: AppTags.yearsOldFrom.tr,
                                                  //       ),
                                                  //       TextSpan(
                                                  //         text: "${controller.filteredUsersList[index].country}",
                                                  //       ),
                                                  //     ],
                                                  //     style: TextStyle(
                                                  //       fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                                  //       ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                                  //       fontFamily: "myFontLight",
                                                  //       fontWeight: FontWeight.w600,
                                                  //       color: const Color(0xFF27B2CC),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // const SizedBox(height: 10),
                                                  if(onlineUsersList[index].maritalStatus != "")
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Text(onlineUsersList[index].maritalStatus.toString()),
                                                        const SizedBox(width: 05),
                                                        const Stack(
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child: Image(
                                                                image: AssetImage("assets/images/heart_bg.png"),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 0,
                                                              bottom: 0,
                                                              right: 0,
                                                              left: 0,
                                                              child: Icon(
                                                                Icons.favorite,
                                                                size: 08,
                                                                color: Color(0xFFCC1262),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  const SizedBox(height: 05),
                                                  if(onlineUsersList[index].country != "" || onlineUsersList[index].city != "")
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                            width: 30,
                                                            child: CachedNetworkImage(
                                                              imageUrl: "${onlineUsersList[index].countryFlag}",
                                                              fit: BoxFit.cover,
                                                              height: 20,
                                                              width: 30,
                                                              placeholder: (context, url) {
                                                                return const CircleAvatar(
                                                                  child: Icon(
                                                                    CupertinoIcons.flag_fill,
                                                                  ),
                                                                );
                                                              },
                                                              errorWidget: (context, url, error) {
                                                                return const CircleAvatar(
                                                                  child: Icon(CupertinoIcons.flag_fill),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          const SizedBox(width: 08),
                                                          if(onlineUsersList[index].city != "" && onlineUsersList[index].country != "")
                                                            Expanded(
                                                              child: Text(
                                                                '${onlineUsersList[index].city} / ${onlineUsersList[index].country}',
                                                                style: TextStyle(
                                                                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 10: 3.sp,
                                                                  fontFamily: "myFontLight",
                                                                  fontWeight: FontWeight.w600,
                                                                  color: const Color(0xFF574667),
                                                                ),
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            )
                                                          else if(onlineUsersList[index].city != "" && onlineUsersList[index].country == "")
                                                            Expanded(
                                                              child: Text(
                                                                '${onlineUsersList[index].city}',
                                                                style: TextStyle(
                                                                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                                  fontFamily: "myFontLight",
                                                                  fontWeight: FontWeight.w600,
                                                                  color: const Color(0xFF574667),
                                                                ),
                                                              ),
                                                            )
                                                          else
                                                            Expanded(
                                                              child: Text(
                                                                '${onlineUsersList[index].country}',
                                                                style: TextStyle(
                                                                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                                  fontFamily: "myFontLight",
                                                                  fontWeight: FontWeight.w600,
                                                                  color: const Color(0xFF574667),
                                                                ),
                                                              ),
                                                            ),
                                                          const SizedBox(width: 08),
                                                          Stack(
                                                            children: [
                                                              const SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child: Image(
                                                                  image: AssetImage("assets/images/heart_bg.png"),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 0,
                                                                bottom: 0,
                                                                right: 0,
                                                                left: 0,
                                                                child: Container(
                                                                  alignment: const Alignment(0, -0.3),
                                                                  child: const Text(
                                                                    "○",
                                                                    style: TextStyle(
                                                                      color: Color(0xFFCC1262),
                                                                      fontSize: 07,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  InkWell(
                                                    onTap: () => controller.onUserReportMenuChange(index),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        const Icon(
                                                          Icons.report_gmailerrorred,
                                                          size: 08,
                                                          color: Color(0xFFC0B4CC),
                                                        ),
                                                        const SizedBox(width: 05),
                                                        Text(
                                                          AppTags.reportUser.tr,
                                                          style: TextStyle(
                                                            fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 4.sp,
                                                            decoration:
                                                            TextDecoration.underline,
                                                            fontFamily: "myFontLight",
                                                            fontWeight: FontWeight.w600,
                                                            color: const Color(0xFF574667),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              )),
                                        ),
                                        if (controller.openSelectUserReportMenuIndex.value != -1 && controller.openSelectUserReportMenuIndex.value == index)
                                          Positioned(
                                            bottom: 14,
                                            left: 18,
                                            child: Card(
                                              elevation: 7.0,
                                              shadowColor: const Color.fromARGB(255, 224, 224, 224),
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  controller.onUserReportMenuChange(-1);
                                                  controller.reportUser(onlineUsersList[index].id!);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                                  ),
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        AppTags.reportUser.tr,
                                                      ),
                                                      // Text("Report message"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    );
                                  } else {
                                    return const Center(child: Text("No users found"));
                                  }
                                },
                              )
                              // child: GridView.builder(
                              //     physics: const BouncingScrollPhysics(),
                              //     padding: const EdgeInsets.only(bottom: 100),
                              //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              //       maxCrossAxisExtent: onlineUsersCount < 2 ? 100: 300,
                              //       childAspectRatio: 0.35,
                              //       crossAxisSpacing: 5,
                              //       mainAxisSpacing: 10,
                              //     ),
                              //     itemCount: controller.usersList.length,
                              //     itemBuilder: (BuildContext ctx, index) {
                              //       if(controller.usersList.isNotEmpty) {
                              //         UserDataModel? user = controller.usersList[index];
                              //         int? age = MyDateUtil.calculateAge(user.dateOfBirth);
                              //         if(onlineUsersCount > 0 && chatController.isUserOnline(user.id!)) {
                              //           return Stack(
                              //             children: [
                              //               Card(
                              //                 elevation: 7.0,
                              //                 shadowColor: const Color.fromARGB(255, 224, 224, 224),
                              //                 color: Colors.white,
                              //                 shape: RoundedRectangleBorder(
                              //                   borderRadius: BorderRadius.circular(10),
                              //                 ),
                              //                 // margin: EdgeInsets.all(5),
                              //                 child: Container(
                              //                     padding: const EdgeInsets.symmetric(
                              //                       horizontal: 10,
                              //                       vertical: 0,
                              //                     ),
                              //                     alignment: Alignment.center,
                              //                     decoration: BoxDecoration(
                              //                       // border: Border.all(
                              //                       //     width: 1, color: Color(0xFF000000)),
                              //                       // color: Colors.white,
                              //                       borderRadius: BorderRadius.circular(10),
                              //                     ),
                              //                     child: FittedBox(
                              //                       child: Column(
                              //                         children: [
                              //                           Container(
                              //                             padding: const EdgeInsets.all(08),
                              //                             child: Row(
                              //                               mainAxisAlignment:
                              //                               MainAxisAlignment.spaceBetween,
                              //                               children: [
                              //                                 if(controller.isAddedToFavouriteList(user.id!))
                              //                                   const Icon(
                              //                                     Icons.favorite_outlined,
                              //                                     size: 22,
                              //                                     color: Color(0xFFffb800),
                              //                                   )
                              //                                 else
                              //                                   const Icon(
                              //                                     Icons.favorite_border,
                              //                                     size: 22,
                              //                                     color: Color(0xFFffb800),
                              //                                   ),
                              //                                 Text(
                              //                                   AppTags.whyIAmSeeingThis.tr,
                              //                                   style: TextStyle(
                              //                                     fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 4.sp,
                              //                                     decoration:
                              //                                     TextDecoration.underline,
                              //                                     fontFamily: "myFontLight",
                              //                                     fontWeight: FontWeight.w300,
                              //                                     color: Colors.grey,
                              //                                   ),
                              //                                 ),
                              //                                 SizedBox(
                              //                                   height: 20,
                              //                                   width: 20,
                              //                                   child: SvgPicture.asset(
                              //                                     "assets/images/chat-heart.svg",
                              //                                   ),
                              //                                 )
                              //                               ],
                              //                             ),
                              //                           ),
                              //                           Stack(
                              //                             clipBehavior: Clip.none,
                              //                             children: [
                              //                               InkWell(
                              //                                 onTap: () {
                              //                                   controller.selectedUser.value = user;
                              //                                   controller.addProfileVisitRecord(user.id!);
                              //                                   navController.previousIndex.value = navController.selectedNavIndex;
                              //                                   navController.handleNavIndexChanged(10);
                              //                                   // Get.to(()=> const ProfileViewPage());
                              //                                   // controller.isProfileViewf(true);
                              //                                 },
                              //                                 child: SizedBox(
                              //                                   height: 90,
                              //                                   width: 90,
                              //                                   child: ClipOval(
                              //                                     child: CachedNetworkImage(
                              //                                       imageUrl: user.profilePic.toString(),
                              //                                       fit: BoxFit.cover,
                              //                                       height: 90,
                              //                                       width: 90,
                              //                                       placeholder: (context, url) => const CircleAvatar(
                              //                                         child: Icon(CupertinoIcons.person),
                              //                                       ),
                              //                                       errorWidget: (context, url, error) =>
                              //                                       const CircleAvatar(
                              //                                         child: Icon(CupertinoIcons.person),
                              //                                       ),
                              //                                     ),
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                               // CircleAvatar(
                              //                               //   radius: 50,
                              //                               //   backgroundImage: AssetImage(
                              //                               //     "assets/images/profile.png",
                              //                               //   ),
                              //                               // ),
                              //                               if(user.isPro == true)
                              //                                 const Positioned(
                              //                                   bottom: 0,
                              //                                   right: 1,
                              //                                   child: CircleAvatar(
                              //                                     radius: 20,
                              //                                     backgroundColor: Color(0xFFffb800),
                              //                                     child: SizedBox(
                              //                                       height: 20,
                              //                                       width: 20,
                              //                                       child: Image(
                              //                                         image: AssetImage(
                              //                                           "assets/images/premium.png",
                              //                                         ),
                              //                                       ),
                              //                                     ),
                              //                                   ),
                              //                                 ),
                              //                             ],
                              //                           ),
                              //                           const SizedBox(height: 15),
                              //                           GetBuilder<ChatController>(builder: (ChatController chatController) {
                              //                             return Row(
                              //                               crossAxisAlignment:
                              //                               CrossAxisAlignment.center,
                              //                               mainAxisAlignment:
                              //                               MainAxisAlignment.center,
                              //                               children: [
                              //                                 // const SizedBox(
                              //                                 //   height: 15,
                              //                                 //   width: 20,
                              //                                 //   child: Image(
                              //                                 //     image: AssetImage("assets/images/flag.png"),
                              //                                 //     fit: BoxFit.cover,
                              //                                 //   ),
                              //                                 // ),
                              //                                 const SizedBox(width: 08),
                              //                                 InkWell(
                              //                                   onTap: () {
                              //                                     controller.selectedUser.value = user;
                              //                                     controller.addProfileVisitRecord(user.id!);
                              //                                     navController.previousIndex.value = navController.selectedNavIndex;
                              //                                     navController.handleNavIndexChanged(10);
                              //                                     // Get.to(()=> const ProfileViewPage());
                              //                                     // controller.isProfileViewf(true);
                              //                                   },
                              //                                   child: Text(
                              //                                     user.firstName.toString(),
                              //                                     style: const TextStyle(
                              //                                       fontSize: 18,
                              //                                       fontFamily: "myFontLight",
                              //                                       fontWeight: FontWeight.w600,
                              //                                       color: Color(0xFF574667),
                              //                                     ),
                              //                                     overflow: TextOverflow.ellipsis,
                              //                                   ),
                              //                                 ),
                              //                                 const SizedBox(width: 08),
                              //                                 if(chatController.isUserOnline(user.id!))
                              //                                   const CircleAvatar(
                              //                                     radius: 5,
                              //                                     backgroundColor: Colors.green,
                              //                                   ),
                              //                               ],
                              //                             );
                              //                           }),
                              //                           if(user.country != "" && age != null && age > 0)
                              //                             Text(
                              //                               "$age ${AppTags.yearsOldFrom.tr} ${user.country}",
                              //                               style: TextStyle(
                              //                                 fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                              //                                 ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                              //                                 fontFamily: "myFontLight",
                              //                                 fontWeight: FontWeight.w600,
                              //                                 color: const Color(0xFF27B2CC),
                              //                               ),
                              //                             )
                              //                           else if(user.country != "")
                              //                             Text(
                              //                               "${user.country}",
                              //                               style: TextStyle(
                              //                                 fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                              //                                 ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                              //                                 fontFamily: "myFontLight",
                              //                                 fontWeight: FontWeight.w600,
                              //                                 color: const Color(0xFF27B2CC),
                              //                               ),
                              //                             ),
                              //                           // RichText(
                              //                           //   text: TextSpan(
                              //                           //     children: [
                              //                           //       TextSpan(
                              //                           //         text: "${age ?? "Unknown"}",
                              //                           //       ),
                              //                           //       TextSpan(
                              //                           //         text: AppTags.yearsOldFrom.tr,
                              //                           //       ),
                              //                           //       TextSpan(
                              //                           //         text: "${controller.filteredUsersList[index].country}",
                              //                           //       ),
                              //                           //     ],
                              //                           //     style: TextStyle(
                              //                           //       fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                              //                           //       ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                              //                           //       fontFamily: "myFontLight",
                              //                           //       fontWeight: FontWeight.w600,
                              //                           //       color: const Color(0xFF27B2CC),
                              //                           //     ),
                              //                           //   ),
                              //                           // ),
                              //                           const SizedBox(height: 10),
                              //                           if(user.maritalStatus != "")
                              //                             Row(
                              //                               mainAxisAlignment:
                              //                               MainAxisAlignment.center,
                              //                               crossAxisAlignment:
                              //                               CrossAxisAlignment.center,
                              //                               children: [
                              //                                 Text(user.maritalStatus.toString()),
                              //                                 const SizedBox(width: 05),
                              //                                 const Stack(
                              //                                   children: [
                              //                                     SizedBox(
                              //                                       height: 20,
                              //                                       width: 20,
                              //                                       child: Image(
                              //                                         image: AssetImage("assets/images/heart_bg.png"),
                              //                                       ),
                              //                                     ),
                              //                                     Positioned(
                              //                                       top: 0,
                              //                                       bottom: 0,
                              //                                       right: 0,
                              //                                       left: 0,
                              //                                       child: Icon(
                              //                                         Icons.favorite,
                              //                                         size: 08,
                              //                                         color: Color(0xFFCC1262),
                              //                                       ),
                              //                                     )
                              //                                   ],
                              //                                 )
                              //                               ],
                              //                             ),
                              //                           const SizedBox(height: 05),
                              //                           if(user.country != "" || user.city != "")
                              //                             Row(
                              //                               crossAxisAlignment:
                              //                               CrossAxisAlignment.center,
                              //                               mainAxisAlignment:
                              //                               MainAxisAlignment.center,
                              //                               children: [
                              //                                 // const SizedBox(
                              //                                 //   height: 15,
                              //                                 //   width: 20,
                              //                                 //   child: Image(
                              //                                 //     image: AssetImage(
                              //                                 //       "assets/images/flag.png",
                              //                                 //     ),
                              //                                 //     fit: BoxFit.cover,
                              //                                 //   ),
                              //                                 // ),
                              //                                 // const SizedBox(width: 08),
                              //                                 if(user.city != "" && user.country != "")
                              //                                   Text(
                              //                                     '${user.city} / ${user.country}',
                              //                                     style: TextStyle(
                              //                                       fontSize: ResponsiveWidget.isSmallScreen(context) ? 10: 3.sp,
                              //                                       fontFamily: "myFontLight",
                              //                                       fontWeight: FontWeight.w600,
                              //                                       color: const Color(0xFF574667),
                              //                                     ),
                              //                                   )
                              //                                 else if(user.city != "" && user.country == "")
                              //                                   Text(
                              //                                     '${user.city}',
                              //                                     style: TextStyle(
                              //                                       fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                              //                                       fontFamily: "myFontLight",
                              //                                       fontWeight: FontWeight.w600,
                              //                                       color: const Color(0xFF574667),
                              //                                     ),
                              //                                   )
                              //                                 else
                              //                                   Text(
                              //                                     '${user.country}',
                              //                                     style: TextStyle(
                              //                                       fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                              //                                       fontFamily: "myFontLight",
                              //                                       fontWeight: FontWeight.w600,
                              //                                       color: const Color(0xFF574667),
                              //                                     ),
                              //                                   ),
                              //                                 const SizedBox(width: 08),
                              //                                 Stack(
                              //                                   children: [
                              //                                     const SizedBox(
                              //                                       height: 20,
                              //                                       width: 20,
                              //                                       child: Image(
                              //                                         image: AssetImage("assets/images/heart_bg.png"),
                              //                                       ),
                              //                                     ),
                              //                                     Positioned(
                              //                                       top: 0,
                              //                                       bottom: 0,
                              //                                       right: 0,
                              //                                       left: 0,
                              //                                       child: Container(
                              //                                         alignment: const Alignment(0, -0.3),
                              //                                         child: const Text(
                              //                                           "○",
                              //                                           style: TextStyle(
                              //                                             color: Color(0xFFCC1262),
                              //                                             fontSize: 07,
                              //                                             fontWeight:
                              //                                             FontWeight.bold,
                              //                                           ),
                              //                                         ),
                              //                                       ),
                              //                                     ),
                              //                                   ],
                              //                                 ),
                              //                               ],
                              //                             ),
                              //                           InkWell(
                              //                             onTap: () => controller.onUserReportMenuChange(index),
                              //                             child: Row(
                              //                               mainAxisAlignment:
                              //                               MainAxisAlignment.center,
                              //                               crossAxisAlignment:
                              //                               CrossAxisAlignment.center,
                              //                               children: [
                              //                                 const Icon(
                              //                                   Icons.report_gmailerrorred,
                              //                                   size: 08,
                              //                                   color: Color(0xFFC0B4CC),
                              //                                 ),
                              //                                 const SizedBox(width: 05),
                              //                                 Text(
                              //                                   AppTags.reportUser.tr,
                              //                                   style: TextStyle(
                              //                                     fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 4.sp,
                              //                                     decoration:
                              //                                     TextDecoration.underline,
                              //                                     fontFamily: "myFontLight",
                              //                                     fontWeight: FontWeight.w600,
                              //                                     color: const Color(0xFF574667),
                              //                                   ),
                              //                                 ),
                              //                               ],
                              //                             ),
                              //                           ),
                              //                           const SizedBox(
                              //                             height: 10,
                              //                           ),
                              //                         ],
                              //                       ),
                              //                     )),
                              //               ),
                              //               if (controller.openSelectUserReportMenuIndex.value != -1 && controller.openSelectUserReportMenuIndex.value == index)
                              //                 Positioned(
                              //                   bottom: 14,
                              //                   left: 18,
                              //                   child: Card(
                              //                     elevation: 7.0,
                              //                     shadowColor: const Color.fromARGB(255, 224, 224, 224),
                              //                     color: Colors.white,
                              //                     shape: RoundedRectangleBorder(
                              //                       borderRadius: BorderRadius.circular(10),
                              //                     ),
                              //                     child: Container(
                              //                       decoration: BoxDecoration(
                              //                         border: Border.all(color: Colors.grey.withOpacity(0.1)),
                              //                       ),
                              //                       padding: const EdgeInsets.all(10.0),
                              //                       child: Column(
                              //                         children: [
                              //                           Text(
                              //                             AppTags.reportUser.tr,
                              //                           ),
                              //                           const Text("Report message"),
                              //                         ],
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 )
                              //             ],
                              //           );
                              //         }
                              //         return const SizedBox.shrink();
                              //       }
                              //       return const SizedBox.shrink();
                              //     }),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Please "),
                                  InkWell(
                                    onTap: () => navController.handleIndexChanged(2),
                                    child: const Text(
                                      "login",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff27B2CC),
                                      ),
                                    ),
                                  ),
                                  const Text(" to view members"),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  });
                }
              );
            }
          );
          }
        );
      }
    );
  }
}
