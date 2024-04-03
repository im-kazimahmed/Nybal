
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/views/support/tickets_home.dart';
import '../../Widgets/images.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/local_data_helper.dart';
import '../../utils/app_tags.dart';
import '../../widgets/theme_data.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();
  final UserController userController = Get.find<UserController>();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController controller) {
      return Drawer(
        width: Get.width / 1.7,
        backgroundColor: themeController.isDarkMode.isTrue ?
        ThemeData.dark().scaffoldBackgroundColor:
        AppColors.pinkButton,
        child: SafeArea(
          child: SizedBox(
            height: Get.height,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                if(LocalDataHelper().getUserToken() != null && LocalDataHelper().getUserAllData() != null)
                  ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            navController.previousIndex.value = navController.selectedNavIndex;
                            navController.handleNavIndexChanged(5);
                          },
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 25,
                          )
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navController.previousIndex.value = navController.selectedNavIndex;
                        navController.handleNavIndexChanged(21);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(width: 20),
                                Stack(
                                  children: [
                                    // Image.asset(
                                    //   Images.personMale,
                                    // ),
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: "${userController.userData.user?.profilePic}",
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
                                    if(userController.userData.user?.isPro == true)
                                      const Positioned(
                                        bottom: 0,
                                        left: 1,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Color(0xFFffb800),
                                          child: SizedBox(
                                            height: 10,
                                            width: 10,
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
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                const SizedBox(width: 20),
                                Text(
                                  "${userController.userData.user?.firstName}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "myFontLight",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ]
                else
                  ...[
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.only(right: 30),
                        height: Get.height / 10,
                        width: Get.height / 10,
                        child: const Image(
                          color: Colors.white,
                          image: AssetImage("assets/images/iconMain.png"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if(LocalDataHelper().getUserToken() != null && LocalDataHelper().getUserAllData() != null)
                            ...[
                              InkWell(
                                onTap: (){
                                  navController.previousIndex.value = navController.selectedNavIndex;
                                  navController.handleIndexChanged(3);
                                },
                                child: Text(
                                  AppTags.potentialMatches.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  navController.previousIndex.value = navController.selectedNavIndex;
                                  navController.handleNavIndexChanged(12);
                                },
                                child: Text(
                                  AppTags.newMembers.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  navController.previousIndex = navController.selectedIndex;
                                  navController.handleNavIndexChanged(17);
                                },
                                child: Text(
                                  AppTags.online.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  navController.previousIndex = navController.selectedIndex;
                                  navController.handleIndexChanged(1);
                                },
                                child: Text(
                                  AppTags.search.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  navController.previousIndex = navController.selectedIndex;
                                  navController.handleNavIndexChanged(27);
                                },
                                child: Text(
                                  AppTags.contactUs.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: langController.languages.map((lang) {
                              if(lang.isEnabled == true) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => langController.updateLocale(lang.key),
                                    child: FittedBox(
                                      child: Text(
                                        "${lang.name}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          ),
                          // Expanded(
                          //   child: ListView.builder(
                          //     itemCount: 10,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     itemBuilder: (context, index) {
                          //       return Text("Index $index");
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => themeController.onThemeModeChange(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(themeController.isDarkMode.isTrue)
                        const Text(
                          "Light Mode",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      else
                        const Text(
                          "Dark Mode",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      const SizedBox(width: 10),
                      Image.asset(
                        Images.darkMode,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if(LocalDataHelper().getUserToken() != null && LocalDataHelper().getUserAllData() != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          navController.previousIndex = navController.selectedIndex;
                          navController.handleIndexChanged(3);
                        },
                        child: Image.asset(
                          "assets/images/edit.png",
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          navController.previousIndex.value = navController.selectedNavIndex;
                          navController.handleNavIndexChanged(3);
                        },
                        child: Image.asset(
                          "assets/images/Settings.png",
                          color: Colors.white,
                        ),
                      ),
                      // InkWell(
                      //   onTap: ()=> Get.to(()=> const TicketsHome()),
                      //   child: Image.asset(
                      //     "assets/images/support.png",
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
      }
    );
  }
}

