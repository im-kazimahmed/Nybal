import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/widgets/images.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/dialogs.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/chat_controller.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/user_model.dart';
import '../../../widgets/my_date_util.dart';

class WhoCanSeeMyPhotos extends StatelessWidget {
  WhoCanSeeMyPhotos({super.key});
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
                    child: GestureDetector(
                      onTap:  () => controller.onUserPhotoMenuChange(-1),
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
                            FutureBuilder(
                              future: controller.getGalleryPermittedUsers(),
                              builder: (context, snapshot) {
                                if(controller.galleryPermittedUsers.isEmpty && controller.isLoading.isTrue) {
                                  return const CustomLoader();
                                } else if(controller.galleryPermittedUsers.isNotEmpty) {
                                  List<Widget> status0List = [];
                                  List<Widget> status1List = [];

                                  for (int index = 0; index < controller.galleryPermittedUsers.length; index++) {
                                    UserDataModel? user = controller.galleryPermittedUsers[index];

                                    if (user.photosPermission != null) {
                                      if (user.photosPermission?.status == 1) {
                                        status1List.add(Container(
                                          width: Get.width,
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                user.createdAt != "" ?
                                                MyDateUtil.formatDateTime(user.createdAt!): "",
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
                                                  SizedBox(
                                                    width: Get.width/4,
                                                    child: Text(
                                                      "${user.username}",
                                                      style: TextStyle(
                                                        color: themeController.isDarkMode.isTrue ?
                                                        ThemeData.light().scaffoldBackgroundColor:
                                                        ThemeData.dark().scaffoldBackgroundColor,
                                                      ),
                                                      textAlign: TextAlign.right,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Stack(
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child: ClipOval(
                                                          child: CachedNetworkImage(
                                                            imageUrl: "${user.profilePic}",
                                                            fit: BoxFit.cover,
                                                            height: 30,
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
                                                      ),
                                                      GetBuilder<ChatController>(builder: (ChatController chatController) {
                                                        try {
                                                          if(chatController.isUserOnline(user.id!)) {
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
                                              IconButton(
                                                onPressed: () {
                                                  controller.onUserPhotoMenuChange(index);
                                                  controller.handleUserTap(user);
                                                },
                                                icon: const Icon(
                                                  Icons.more_vert,
                                                  color: Color(0xffC0B4CC),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                      } else {
                                        status0List.add(Container(
                                          width: Get.width,
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                user.createdAt != "" ?
                                                MyDateUtil.formatDateTime(user.createdAt!): "",
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
                                                  SizedBox(
                                                    width: Get.width/4,
                                                    child: Text(
                                                      "${user.username}",
                                                      style: const TextStyle(
                                                      ),
                                                      textAlign: TextAlign.right,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Stack(
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child: ClipOval(
                                                          child: CachedNetworkImage(
                                                            imageUrl: "${user.profilePic}",
                                                            fit: BoxFit.cover,
                                                            height: 30,
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
                                                      ),
                                                      GetBuilder<ChatController>(builder: (ChatController chatController) {
                                                        try {
                                                          if(chatController.isUserOnline(user.id!)) {
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
                                              IconButton(
                                                onPressed: () {
                                                  controller.onUserPhotoMenuChange(index);
                                                  controller.handleUserTap(user);
                                                },
                                                icon: const Icon(
                                                  Icons.more_vert,
                                                  color: Color(0xffC0B4CC),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                      }
                                    }
                                  }
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                                      child: Text(
                                        "Users who have requested permission to access your gallery.",
                                        style: TextStyle(
                                          color: Color(0xffC0B4CC),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: status0List.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            status0List[index],
                                            if (controller.openSelectUserPhotoMenuIndex.value != -1 && controller.openSelectUserPhotoMenuIndex.value == index)
                                              Positioned(
                                                top: 0,
                                                right: 30,
                                                child: Card(
                                                  elevation: 7.0,
                                                  shadowColor: const Color.fromARGB(255, 224, 224, 224),
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller.onUserPhotoMenuChange(-1);
                                                          controller.acceptGalleryRequest(controller.selectedPhotoRequestUser.value.extraField);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                                          ),
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: const Column(
                                                            children: [
                                                              Text(
                                                                "Accept",
                                                              ),
                                                              // Text("Report message"),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          controller.onUserPhotoMenuChange(-1);
                                                          controller.rejectGalleryRequest(controller.selectedPhotoRequestUser.value.extraField);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                                          ),
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: const Column(
                                                            children: [
                                                              Text(
                                                                "Reject",
                                                              ),
                                                              // Text("Report message"),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 40),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                                      child: Text(
                                        "Users to whom you have granted gallery permission.",
                                        style: TextStyle(
                                          color: Color(0xffC0B4CC),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: status1List.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            status1List[index],
                                            if (controller.openSelectUserPhotoMenuIndex.value != -1 && controller.openSelectUserPhotoMenuIndex.value == index)
                                              Positioned(
                                                top: 0,
                                                right: 30,
                                                child: Card(
                                                  elevation: 7.0,
                                                  shadowColor: const Color.fromARGB(255, 224, 224, 224),
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          controller.onUserPhotoMenuChange(-1);
                                                          controller.deleteGalleryRequest(controller.selectedPhotoRequestUser.value.extraField);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                                          ),
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: const Column(
                                                            children: [
                                                              Text(
                                                                "Delete",
                                                              ),
                                                              // Text("Report message"),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 40),
                                    InkWell(
                                      onTap: ()=> controller.selectUserToGrantGalleryPermission(),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.blueColor,
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: const Text(
                                          "Add member",
                                          style: TextStyle(
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: ()=> controller.selectUserToGrantGalleryPermission(),
                                    //   child: Image.asset(Images.addUser),
                                    // ),
                                  ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Image.asset(Images.addUser),
                                      const SizedBox(height: 40),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                                        child: Text(
                                          "You haven't given any member permission to view your photo yet",
                                          style: TextStyle(
                                            color: Color(0xffC0B4CC),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      InkWell(
                                        onTap: ()=> controller.selectUserToGrantGalleryPermission(),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.blueColor,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: const Text(
                                            "Add member",
                                            style: TextStyle(
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
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
                                    future: controller.getGalleryPermittedUsers(),
                                    builder: (context, snapshot) {
                                      if(controller.galleryPermittedUsers.isEmpty && controller.isLoading.isTrue) {
                                        return const CustomLoader();
                                      } else if(controller.galleryPermittedUsers.isNotEmpty) {
                                        return SizedBox(
                                          height: Get.height,
                                          child: Column(
                                            children: [
                                              ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller.galleryPermittedUsers.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          controller.galleryPermittedUsers[index].createdAt != "" ?
                                                          MyDateUtil.formatDateTime(controller.galleryPermittedUsers[index].createdAt!): "",
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
                                                              "${controller.galleryPermittedUsers[index].username}",
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
                                                                      imageUrl: "${controller.galleryPermittedUsers[index].profilePic}",
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
                                                                    if(chatController.isUserOnline(controller.galleryPermittedUsers[index].id!)) {
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
                                              InkWell(
                                                onTap: ()=> controller.selectUserToGrantGalleryPermission(),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: AppColors.blueColor,
                                                  ),
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                  child: const Text(
                                                    "Add member",
                                                    style: TextStyle(
                                                      color: AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return InkWell(
                                          onTap: ()=> controller.selectUserToGrantGalleryPermission(),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: AppColors.blueColor,
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: const Text(
                                              "Add member",
                                              style: TextStyle(
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
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
