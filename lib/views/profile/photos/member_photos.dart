import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/widgets/images.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/dialogs.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/chat_controller.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../widgets/my_date_util.dart';

class MemberPhotos extends StatelessWidget {
  MemberPhotos({super.key});
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          return WillPopScope(
            onWillPop: () async {
              navController.handleNavIndexChanged(6);
              return false;
            },
            child: SafeArea(
              child: Column(
                children: [
                  if (ResponsiveWidget.isSmallScreen(context)) Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeController.isDarkMode.isTrue ?
                        ThemeData.dark().scaffoldBackgroundColor:
                        ThemeData.light().scaffoldBackgroundColor,
                      ),
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.more_vert,
                                    color: Color(0xffC0B4CC),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Added date",
                                    style: TextStyle(
                                      color: Color(0xffC0B4CC),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "User Profile",
                                style: TextStyle(
                                  color: Color(0xffC0B4CC),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Expanded(
                            child: FutureBuilder(
                              future: controller.getUsersWhoPermittedMeGallery(),
                              builder: (context, snapshot) {
                                if(controller.whoPermittedMeGalleryUsers.isEmpty && controller.isLoading.isTrue) {
                                  return const CustomLoader();
                                } else if(controller.whoPermittedMeGalleryUsers.isNotEmpty) {
                                  return Column(
                                    children: [
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller.whoPermittedMeGalleryUsers.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  controller.whoPermittedMeGalleryUsers[index].createdAt != "" ?
                                                  MyDateUtil.formatDateTime(controller.whoPermittedMeGalleryUsers[index].createdAt!): "",
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w200,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontFamily: "myFontLight",
                                                    color: Color(0xFFC0B4CC),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${controller.whoPermittedMeGalleryUsers[index].username}",
                                                      style: TextStyle(
                                                        color: themeController.isDarkMode.isTrue ?
                                                        ThemeData.light().scaffoldBackgroundColor:
                                                        ThemeData.dark().scaffoldBackgroundColor,
                                                      ),
                                                      textAlign: TextAlign.right,
                                                    ),
                                                    const SizedBox(width:10),
                                                    Stack(
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: ClipOval(
                                                            child: CachedNetworkImage(
                                                              imageUrl: "${controller.whoPermittedMeGalleryUsers[index].profilePic}",
                                                              fit: BoxFit.cover,
                                                              height: 50,
                                                              width: 50,
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
                                                        ),
                                                        GetBuilder<ChatController>(builder: (ChatController chatController) {
                                                          try {
                                                            if(chatController.isUserOnline(controller.whoPermittedMeGalleryUsers[index].id!)) {
                                                              return Positioned(
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
                                                              );
                                                            }
                                                          }
                                                          catch (e) { }
                                                          return Container();
                                                        }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Image.asset(Images.user),
                                      const SizedBox(height: 40),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                                        child: Text(
                                          "No member has allowed you to see their photos",
                                          style: TextStyle(
                                            color: Color(0xffC0B4CC),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }
                            ),
                          ),
                        ],
                      ),
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
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.more_vert,
                                          color: Color(0xffC0B4CC),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Added date",
                                          style: TextStyle(
                                            color: Color(0xffC0B4CC),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "User Profile",
                                      style: TextStyle(
                                        color: Color(0xffC0B4CC),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                FutureBuilder(
                                  future: controller.getUsersWhoPermittedMeGallery(),
                                  builder: (context, snapshot) {
                                    if(controller.whoPermittedMeGalleryUsers.isEmpty && controller.isLoading.isTrue) {
                                      return const CustomLoader();
                                    } else if(controller.whoPermittedMeGalleryUsers.isNotEmpty) {
                                      return SizedBox(
                                        height: Get.height,
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller.whoPermittedMeGalleryUsers.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        controller.whoPermittedMeGalleryUsers[index].createdAt != "" ?
                                                        MyDateUtil.formatDateTime(controller.whoPermittedMeGalleryUsers[index].createdAt!): "",
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w200,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontFamily: "myFontLight",
                                                          color: Color(0xFFC0B4CC),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${controller.whoPermittedMeGalleryUsers[index].username}",
                                                            style: const TextStyle(
                                                            ),
                                                            textAlign: TextAlign.right,
                                                          ),
                                                          Stack(
                                                            children: [
                                                              SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: ClipOval(
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: "${controller.whoPermittedMeGalleryUsers[index].profilePic}",
                                                                    fit: BoxFit.cover,
                                                                    height: 50,
                                                                    width: 50,
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
                                                              ),
                                                              GetBuilder<ChatController>(builder: (ChatController chatController) {
                                                                try {
                                                                  if(chatController.isUserOnline(controller.whoPermittedMeGalleryUsers[index].id!)) {
                                                                    return Positioned(
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
                                                                    );
                                                                  }
                                                                }
                                                                catch (e) { }
                                                                return Container();
                                                              }),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          Image.asset(Images.user),
                                          const SizedBox(height: 40),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                                            child: Text(
                                              "No member has allowed you to see their photos",
                                              style: TextStyle(
                                                color: Color(0xffC0B4CC),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                ),
                              ],
                            ),
                          ),
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
  }
}
