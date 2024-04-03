import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/images.dart';
import 'package:nybal/controllers/update_profile_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/dialogs.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/language_controller.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../controllers/user_controller.dart';

class AddPhotoPage extends StatelessWidget {
  AddPhotoPage({super.key});
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<UpdateProfileController>(builder: (UpdateProfileController profileController) {
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          AppTags.whenYouAddYourPhotoNoMemberWillBeAbleToViewIt.tr,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFC0B4CC),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: FutureBuilder(
                          future: controller.getAllUserPhotos(),
                          builder: (context, snapshot) {
                            if(controller.userPhotos.isEmpty && controller.isLoading.isTrue) {
                              return const CustomLoader();
                            } else if(controller.userPhotos.isNotEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () => profileController.selectAndUploadImage(context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "New Image",
                                          style: TextStyle(
                                            color: Color(0xff27B2CC),
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // profileController.selectImage(ImageSource.gallery);
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: Color(0xff27B2CC),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.userPhotos.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: "${controller.userPhotos[index].image}",
                                                fit: BoxFit.cover,
                                                height: 20.h,
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
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () => controller.deleteGalleryPhoto(controller.userPhotos[index].id!),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Delete photo",
                                                    style: TextStyle(
                                                      color: Color(0xff27B2CC),
                                                      decoration: TextDecoration.underline,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Image.asset(
                                                    Images.delete,
                                                    height: 18,
                                                  ),
                                                  // Icon(
                                                  //   Icons.delete,
                                                  //   color: Colors.blue,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () => profileController.selectAndUploadImage(context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "New Image",
                                          style: TextStyle(
                                            color: Color(0xff27B2CC),
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // profileController.selectImage(ImageSource.gallery);
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: Color(0xff27B2CC),
                                          ),
                                        ),
                                      ],
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
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  AppTags.whenYouAddYourPhotoNoMemberWillBeAbleToViewIt.tr,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFC0B4CC),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              FutureBuilder(
                                future: controller.getAllUserPhotos(),
                                builder: (context, snapshot) {
                                  if(controller.userPhotos.isEmpty && controller.isLoading.isTrue) {
                                    return const CustomLoader();
                                  } else if(controller.userPhotos.isNotEmpty) {
                                    return SizedBox(
                                      height: Get.height,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () => profileController.selectAndUploadImage(context),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "New Image",
                                                  style: TextStyle(
                                                    color: Color(0xff27B2CC),
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    // profileController.selectImage(ImageSource.gallery);
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera_alt,
                                                    color: Color(0xff27B2CC),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 50),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller.userPhotos.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    height: 30.h,
                                                    width: 16.w,
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
                                                        imageUrl: "${controller.userPhotos[index].image}",
                                                        fit: BoxFit.cover,
                                                        height: 30.h,
                                                        width: 16.w,
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
                                                  InkWell(
                                                    onTap: () => controller.deleteGalleryPhoto(controller.userPhotos[index].id!),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Delete photo",
                                                          style: TextStyle(
                                                            color: Color(0xff27B2CC),
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.delete,
                                                          color: Color(0xff27B2CC),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () => profileController.selectAndUploadImage(context),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "New Image",
                                                style: TextStyle(
                                                  color: Color(0xff27B2CC),
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  // profileController.selectImage(ImageSource.gallery);
                                                },
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  color: Color(0xff27B2CC),
                                                ),
                                              ),
                                            ],
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
      return GetBuilder<UserController>(builder: (UserController controller) {
        return SafeArea(
          child: Column(
            children: [
              if (ResponsiveWidget.isSmallScreen(context)) Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          AppTags.myPhotos.tr,
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
                            AppTags.youCanAddYourRealPhotoSaveItInSafetyAndChooseWhoWillSeeIt.tr,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFFC0B4CC),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        AppTags.whenYouAddYourPhotoNoMemberWillBeAbleToViewIt.tr,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFC0B4CC),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                AppTags.whenYouAddYourPhotoNoMemberWillBeAbleToViewIt.tr,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFC0B4CC),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder(
                              future: controller.getAllUserPhotos(),
                              builder: (context, snapshot) {
                                if(controller.userPhotos.isEmpty && controller.isLoading.isTrue) {
                                  return const CustomLoader();
                                } else if(controller.userPhotos.isNotEmpty) {
                                  return SizedBox(
                                    height: Get.height,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () => profileController.selectAndUploadImage(context),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "New Image",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration.underline
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  // profileController.selectImage(ImageSource.gallery);
                                                },
                                                icon: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 50),
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller.userPhotos.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 30.h,
                                                  width: 16.w,
                                                  child: ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${controller.userPhotos[index].image}",
                                                      fit: BoxFit.cover,
                                                      height: 30.h,
                                                      width: 16.w,
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
                                                InkWell(
                                                  onTap: () => controller.deleteGalleryPhoto(controller.userPhotos[index].id!),
                                                  child: const Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "Delete photo",
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            decoration: TextDecoration.underline
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () => profileController.selectAndUploadImage(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "New Image",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                // profileController.selectImage(ImageSource.gallery);
                                              },
                                              icon: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
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
        );
      }
      );
      }
    );
  }
}
