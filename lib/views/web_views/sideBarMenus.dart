import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/data.dart';
import '../../utils/app_tags.dart';

class SideBarMenus extends StatelessWidget {
  SideBarMenus({super.key});
  final UserController userController = Get.find<UserController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final NavigationController navController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppTags.welcome.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 30,
                          child: CachedNetworkImage(
                            imageUrl: "${userController.userData.user?.countryFlag}",
                            fit: BoxFit.cover,
                            height: 20,
                            width: 30,
                            placeholder: (context, url) {
                              return const CircleAvatar(
                                child: Icon(
                                  CupertinoIcons.person,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${userController.userData.user?.firstName ?? userController.userData.user?.username}",
                          style: TextStyle(
                            color: const Color(0xff574667),
                            fontSize: 5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: "${userController.userData.user?.profilePic}",
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
                          placeholder: (context, url) {
                            return const CircleAvatar(
                              child: Icon(
                                CupertinoIcons.person,
                              )
                            );
                          },
                          errorWidget: (context, url, error) {
                            return const CircleAvatar(
                              child: Icon(CupertinoIcons.person),
                            );
                          }
                        ),
                      ),
                    ),
                    // Image.asset(Images.personMale),
                  ],
                ),
                Positioned(
                  right: 40,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(1.0),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    padding: const EdgeInsets.all(4.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: Get.height,
              child: UserSideMenus(),
            ),
          ],
        ),
      ),
    );
  }
}

class UserSideMenus extends StatelessWidget {
  UserSideMenus({super.key});
  final UserController userController = Get.find<UserController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sideBarMenus.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: InkWell(
                onTap: () {
                  if(sideBarMenus[index]['title'] == "Dark mode" || sideBarMenus[index]['title'] == "Light mode") {
                    themeController.onThemeModeChange();
                  } else {
                    navController.previousIndex.value = navController.selectedNavIndex;
                    navController.handleNavIndexChanged(sideBarMenus[index]["route"]);
                  }
                  userController.onSideBarMenuExpanded();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: themeController.isDarkMode.isTrue ?
                    ThemeData.dark().scaffoldBackgroundColor:Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple[100]!,
                        spreadRadius: 0.2,
                        blurRadius: 20,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if(sideBarMenus[index]['title'] == "Dark mode")
                        Expanded(
                          child: Text(
                            themeController.isDarkMode.isTrue ? "Light Mode": sideBarMenus[index]['title'],
                            style: TextStyle(
                              color: themeController.isDarkMode.isTrue ?
                              Colors.white: null,
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Text(
                            sideBarMenus[index]['title'],
                            style: TextStyle(
                              color: themeController.isDarkMode.isTrue ?
                              Colors.white: null,
                            )
                          ),
                        ),
                      Image.asset(sideBarMenus[index]['image']),
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

