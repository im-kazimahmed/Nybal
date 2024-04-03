import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:sizer/sizer.dart';
import '../controllers/user_controller.dart';
import '../views/web_views/sideBarMenus.dart';

class MobileUserMenu extends StatelessWidget {
  const MobileUserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          return Column(
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.isTrue ?
                  ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9):Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => controller.onSideBarMenuExpanded(),
                      icon: controller.sideBarMenusExpanded.isFalse ?
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xffCC1262),
                      ):
                      const Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xffCC1262),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 30,
                          child: CachedNetworkImage(
                            imageUrl: "${controller.userData.user?.countryFlag}",
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
                        const SizedBox(width: 20),
                        Text(
                          "${controller.userData.user?.firstName}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: themeController.isDarkMode.isTrue ?
                            Colors.white:const Color(0xff574667),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Stack(
                          children: [
                            // Image.asset(Images.personMale),
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: "${controller.userData.user?.profilePic}",
                                fit: BoxFit.cover,
                                height: 70,
                                width: 70,
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
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                ),
                                padding: const EdgeInsets.all(4.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.sideBarMenusExpanded.value,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                    color: themeController.isDarkMode.isTrue?
                    ThemeData.dark().scaffoldBackgroundColor:
                    ThemeData.light().scaffoldBackgroundColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: UserSideMenus(),
                ),
              ),
            ],
          );
        });
      }
    );
  }
}
