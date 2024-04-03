import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/views/profile/photos/add_photos.dart';
import 'package:nybal/views/profile/photos/member_photos.dart';
import 'package:nybal/views/profile/photos/who_can_see_photos.dart';
import 'package:nybal/views/web_views/sideBarMenus.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../Widgets/theme_data.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/pagination_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/app_tags.dart';
import '../../widgets/mobile_user_menu.dart';
import '../../widgets/top_bar.dart';

class PhotosScreen extends StatelessWidget {
  PhotosScreen({super.key});
  final PaginationController paginationController =
  Get.put(PaginationController());
  final LanguageController langController = Get.find<LanguageController>();

  final List<Widget> pages = [
    MemberPhotos(),
    WhoCanSeeMyPhotos(),
    AddPhotoPage(),
  ];

  final List menus = [
    {"title": "Members Photos", "route": 0},
    {"title": "Who can see my photos?", "route": 1},
    {"title": "Add Photo", "route": 2},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<UserController>(builder: (UserController controller) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: SafeArea(
          child: Column(
            children: [
              if(ResponsiveWidget.isSmallScreen(context))
                const TopBar(),
              const SizedBox(height: 10),
              if (ResponsiveWidget.isSmallScreen(context))
                SizedBox(
                  height: Get.height * 1.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const MobileUserMenu(),
                        if(controller.sideBarMenusExpanded.isFalse)
                          ...[
                            const SizedBox(height: 40),
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
                              padding: const EdgeInsets.symmetric(horizontal: 55.0),
                              child: Text(
                                AppTags.youCanAddYourRealPhotoSaveItInSafetyAndChooseWhoWillSeeIt.tr,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFC0B4CC),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: (menus.length / 2).ceil(), // Calculate the number of rows
                              itemBuilder: (context, rowIndex) {
                                int startIndex = rowIndex * 2;
                                int endIndex = startIndex + 2;
                                if (endIndex > menus.length) {
                                  endIndex = menus.length;
                                }

                                return Row(
                                  children: List.generate(endIndex - startIndex, (index) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        child: InkWell(
                                          onTap: () => controller.onPhotosPageIndexHandle(menus[startIndex + index]["route"]),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: controller.selectedPhotosPageIndex.value == startIndex + index
                                                  ? AppColors.pinkButton
                                                  : Colors.white,
                                              border: Border.all(color: AppColors.pinkButton),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                            alignment: Alignment.center,
                                            child: Text(
                                              menus[startIndex + index]["title"],
                                              style: TextStyle(
                                                color: controller.selectedPhotosPageIndex.value == startIndex + index
                                                    ? Colors.white
                                                    : AppColors.pinkButton,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: pages[controller.selectedPhotosPageIndex.value],
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 8.h,
                                width: Get.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: menus.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: InkWell(
                                        onTap: ()=> controller.onPhotosPageIndexHandle(menus[index]["route"]),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: controller.selectedPhotosPageIndex.value == index ?
                                            AppColors.pinkButton: Colors.white,
                                            border: Border.all(color: AppColors.pinkButton),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 2.w),
                                          alignment: Alignment.center,
                                          child: Text(
                                            menus[index]["title"],
                                            style: TextStyle(
                                              color: controller.selectedPhotosPageIndex.value == index ?
                                              Colors.white:AppColors.pinkButton,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                child: pages[controller.selectedPhotosPageIndex.value],
                              ),
                              // Container(
                              //   width: size.width,
                              //   decoration: const BoxDecoration(
                              //     color: Colors.white,
                              //   ),
                              //   padding: const EdgeInsets.symmetric(vertical: 20),
                              //   child: Padding(
                              //     padding: EdgeInsets.symmetric(horizontal: 5.w, vertical : 20),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       children: [
                              //         const Text(
                              //           "Plan Prices",
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         const SizedBox(height: 20),
                              //         Container(
                              //           decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.grey[300]!,
                              //                 spreadRadius: 0.1,
                              //                 blurRadius: 30,
                              //                 offset: const Offset(0, 20),
                              //               )
                              //             ],
                              //           ),
                              //           child: Stack(
                              //             children: [
                              //               Text("Why i am seeing this?"),
                              //               Image.asset("assets/images/package.png"),
                              //               Text("Standard"),
                              //               Text(
                              //                 "30 min",
                              //                 style: TextStyle(
                              //                   color: Colors.blue,
                              //                   fontWeight: FontWeight.bold,
                              //                 )
                              //               ),
                              //               Positioned(
                              //                 top: 0,
                              //                 left: 0,
                              //                 child: Transform.rotate(
                              //                   angle: 5.5,
                              //                   child: Container(
                              //                     decoration: const BoxDecoration(
                              //                       color: Color(0xffC768E1),
                              //                     ),
                              //                     padding: const EdgeInsets.all(8.0),
                              //                     child: const Text(
                              //                       'Super price',
                              //                       style: TextStyle(color: Colors.white),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
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
    });
    return GetBuilder<UserController>(builder: (UserController controller) {
      return SafeArea(
        child: FutureBuilder(
          future: controller.getAllUserPhotos(),
          builder: (context, snapshot) {
            return Column(
              children: [
                if(ResponsiveWidget.isSmallScreen(context))
                  const TopBar(),
                const SizedBox(height: 10),
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
                      SizedBox(
                        height: 50,
                        width: Get.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: InkWell(
                                onTap: ()=> controller.onPhotosPageIndexHandle(menus[index]["route"]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.selectedPhotosPageIndex.value == index ?
                                    AppColors.pinkButton: Colors.white,
                                    border: Border.all(color: AppColors.pinkButton),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    menus[index]["title"],
                                    style: TextStyle(
                                      color: controller.selectedPhotosPageIndex.value == index ?
                                      Colors.white:AppColors.pinkButton,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: pages[controller.selectedPhotosPageIndex.value],
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
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 8.h,
                                width: Get.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: menus.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: InkWell(
                                        onTap: ()=> controller.onPhotosPageIndexHandle(menus[index]["route"]),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: controller.selectedPhotosPageIndex.value == index ?
                                            AppColors.pinkButton: Colors.white,
                                            border: Border.all(color: AppColors.pinkButton),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 2.w),
                                          alignment: Alignment.center,
                                          child: Text(
                                            menus[index]["title"],
                                            style: TextStyle(
                                              color: controller.selectedPhotosPageIndex.value == index ?
                                              Colors.white:AppColors.pinkButton,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                child: pages[controller.selectedPhotosPageIndex.value],
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
            );
          }
        ),
      );
    }
    );
  }
}
