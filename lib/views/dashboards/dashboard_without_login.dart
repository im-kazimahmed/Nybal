import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/images.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/utils/validators.dart';
import 'package:nybal/views/Members/search_members.dart';
import 'package:nybal/views/authentication/sign_up.dart';
import 'package:nybal/views/contact_us.dart';
import 'package:nybal/views/drawer/drawer.dart';
import 'package:nybal/views/landing_pages/landing_page.dart';
import 'package:nybal/views/members/wish_to_marry_members.dart';
import 'package:nybal/views/potential_matches.dart';
import 'package:nybal/views/web_views/actionsBar.dart';
import 'package:nybal/views/web_views/footer.dart';
import '../../../Widgets/theme_data.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../utils/app_tags.dart';
import '../../widgets/custom_responsive.dart';
import '../Members/new_members.dart';
import '../Members/online_members.dart';
import '../authentication/sign_in.dart';
import '../faq.dart';

class DashboardWithoutLogin extends StatelessWidget {
  DashboardWithoutLogin({super.key});

  final UserController userController = Get.find<UserController>();
  final LanguageController langController = Get.find<LanguageController>();
  final ThemeController themeController = Get.find<ThemeController>();

  final List<Widget> pages = [
    LandingPage(),
    SearchMembers(),
    SignIn(),
    PotentialMatches(),
    NewMembers(),
    OnlineMembers(),
    FAQ(),
    ContactUs(),
    WhoWishToMarryMembers(),
    SignUp(),
  ];

  @override
  Widget build(BuildContext context) {
    var lastExitTime = DateTime.now();
    return GetBuilder<NavigationController>(builder: (NavigationController navController) {
      return WillPopScope(
        onWillPop: () async {
          if (DateTime.now().difference(lastExitTime) >=
              const Duration(seconds: 2)) {
            showShortToast("Press the back button again exit");
            lastExitTime = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
        child: CustomResponsive(
          key: UniqueKey(),
          topNavigation: [
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: AppColors.appBarPurple,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: langController.languages.map((lang){
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
                }).toList(),
              ),
            ),
          ],
          topNavigationAlignment: MainAxisAlignment.center,
          drawerWidget: DrawerScreen(),
          actionsWidget: <Widget>[
            ActionsBarWidget()
          ],
          actionsAlignment: MainAxisAlignment.end,
          bodyContent: pages[navController.selectedIndex.value],
          mobileBottomNavBar: Obx(()=>
            Container(
              height: Get.height / 8,
              decoration: BoxDecoration(
                color: themeController.isDarkMode.isTrue ?
                ThemeData.dark().scaffoldBackgroundColor: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              // clipBehavior: Clip.none,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: DotNavigationBar(
                  borderRadius: 0,
                  splashBorderRadius: 0,
                  paddingR: const EdgeInsets.only(left: 05, right: 05),
                  itemPadding: const EdgeInsets.only(left: 20, right: 20),
                  marginR: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  enablePaddingAnimation: false,
                  margin: const EdgeInsets.only(left: 05, right: 05),
                  currentIndex: navController.selectedIndex.value,
                  dotIndicatorColor: Colors.transparent,
                  unselectedItemColor: Colors.grey[300],
                  enableFloatingNavBar: true,
                  backgroundColor: themeController.isDarkMode.isTrue ?
                  ThemeData.dark().scaffoldBackgroundColor: null,
                  onTap: navController.handleIndexChanged,
                  items: [
                    DotNavigationBarItem(
                      icon: Column(
                        children: [
                          Container(
                            height: 3,
                            width: 60,
                            color: navController.selectedIndex.value == 0 ? const Color(0xFFB14D78): null,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 45,
                            width: 45,
                            padding: const EdgeInsets.all(08),
                            child: const Image(
                              image: AssetImage("assets/images/edit.png"),
                            ),
                          ),
                          Text(
                            AppTags.subscription.tr,
                            style: const TextStyle(
                               color: Color(0xFFB14D78)
                            ),
                          ),
                        ],
                      ),
                    ),
                    DotNavigationBarItem(
                      icon: Column(
                        children: [
                          Container(
                            height: 3,
                            width: 60,
                            color: navController.selectedIndex.value == 1 ? const Color(0xFFB14D78): null,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 45,
                            width: 45,
                            padding: const EdgeInsets.all(08),
                            child: const Image(
                              image: AssetImage(Images.membersGroup),
                            ),
                          ),
                          Text(
                            AppTags.members.tr,
                            style: const TextStyle(
                                color: Color(0xFFB14D78)
                            ),
                          ),
                        ],
                      ),
                    ),
                    DotNavigationBarItem(
                      icon: Column(
                        children: [
                          Container(
                            height: 3,
                            width: 60,
                            color: navController.selectedIndex.value == 2 ? const Color(0xFFB14D78)
                                : null,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 45,
                            width: 45,
                            padding: const EdgeInsets.all(08),
                            child: const Image(
                              image: AssetImage("assets/images/access.png"),
                            ),
                          ),
                          Text(
                            AppTags.access.tr,
                            style: const TextStyle(
                                color: Color(0xFFB14D78)
                            ),
                          ),
                        ],
                      ),
                    ),
                    ]),
                ),
              ),
          ),
          footerContent: FooterView(),
          enableChatSupport: false,
        ),
      );
      }
    );
  }
}
