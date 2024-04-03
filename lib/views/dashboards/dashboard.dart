import 'dart:convert';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/images.dart';
import 'package:nybal/Widgets/responsive_widget.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/controllers/splash_controller.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/views/Authentication/email_verification.dart';
import 'package:nybal/views/Members/online_members.dart';
import 'package:nybal/views/Members/search_members.dart';
import 'package:nybal/views/Profile/myProfile.dart';
import 'package:nybal/views/Registration/registration_division.dart';
import 'package:nybal/views/Registration/wife_registration.dart';
import 'package:nybal/views/contact_us.dart';
import 'package:nybal/views/landing_pages/landing_page.dart';
import 'package:nybal/views/members/wish_to_marry_members.dart';
import 'package:nybal/views/Send_Message/send_message.dart';
import 'package:nybal/views/profile/my_block_List.dart';
import 'package:nybal/views/profile/my_ignore_list.dart';
import 'package:nybal/views/profile/my_likes.dart';
import 'package:nybal/views/profile/my_photos.dart';
import 'package:nybal/views/profile/my_settings.dart';
import 'package:nybal/views/profile/whoVisitedProfile.dart';
import 'package:nybal/views/web_views/actionsBar.dart';
import 'package:nybal/views/web_views/footer.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/theme_data.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/pagination_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/network/cache_helper.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_responsive.dart';
import '../../widgets/no_connection.dart';
import '../Members/new_members.dart';
import '../Messages_page/messages_page.dart';
import '../Profile/my_privileges.dart';
import '../Profile/notifications.dart';
import '../authentication/profile_update.dart';
import '../disable_profile/disable_profile.dart';
import '../drawer/drawer.dart';
import '../faq.dart';
import '../home/home_page.dart';
import '../authentication/logout_page.dart';
import '../profile/received_likes.dart';
import '../profile_view/profile_view_page.dart';
import '../profile/referrals.dart';
import '../support/create_ticket.dart';
import '../support/tickets_home.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final PaginationController paginationController =
  Get.put(PaginationController());
  final AuthController authController = Get.find<AuthController>();
  final UserController userController = Get.find<UserController>();
  final ChatController chatController = Get.find<ChatController>();
  final LanguageController langController = Get.find<LanguageController>();
  final HomeScreenController homeController = Get.find<HomeScreenController>();
  final ThemeController themeController = Get.find<ThemeController>();

  final List<Widget> pages = [
    MessagesPage(),
    const HomePage(),
    const Logout_page(),
    MySettings(),
    MyPrivileges(),
    NotificationsScreen(),
    PhotosScreen(),
    WhoVisitedProfileScreen(),
    MyBlockListScreen(),
    ReceivedLikesScreen(),
    const ProfileViewPage(),
    MyLikes(),
    NewMembers(),
    MyIgnoreListScreen(),
    FAQ(),
    WhoWishToMarryMembers(),
    LandingPage(),
    OnlineMembers(),
    Referrals(),
    SearchMembers(),
    DisableProfile(),
    MyProfile(),
    WifeRegistration(),
    LandingPage(),
    RegistrationDivision(),
    TicketsHome(),
    CreateTicket(),
    ContactUs(),
  ];

  @override
  void initState() {
    debugPrint('UserIdIs: ${CacheHelper.getString(key: 'uId')}');
    // if(authController.firebaseAuth.currentUser != null) {
    //   authController.firebaseAuth.currentUser?.reload();
    //   AuthCubit().checkUserExistInFirebase(uId: authController.firebaseAuth.currentUser!.uid);
    //   AuthCubit().getUserData(uId: authController.firebaseAuth.currentUser!.uid);
    // }
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   checkInComingTerminatedCall();
    // });
    super.initState();
  }

  // checkInComingTerminatedCall() async {
  //   if(CacheHelper.getString(key: 'terminateIncomingCallData').isNotEmpty){ //if there is a terminated call
  //     Map<String, dynamic> callMap = jsonDecode(CacheHelper.getString(key: 'terminateIncomingCallData'));
  //     await CacheHelper.removeData(key: 'terminateIncomingCallData');
  //     if(mounted) {
  //       Get.toNamed(
  //         callScreen,
  //         arguments: [
  //           true,
  //           CallModel.fromJson(callMap),
  //         ]
  //       );
  //       // Navigator.pushNamed(context, callScreen,arguments: [
  //       //   true,
  //       //   CallModel.fromJson(callMap),
  //       // ]);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var lastExitTime = DateTime.now();
    return GetBuilder<NavigationController>(builder: (NavigationController navController) {
      return WillPopScope(
        onWillPop: () async {
          if (DateTime.now().difference(lastExitTime) >=
              const Duration(seconds: 2)) {
            if(navController.selectedNavIndex == 1) {
              showShortToast("Press the back button again exit");
            }
            lastExitTime = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
        child: InternetWidget(
          offline: const FullScreenWidget(
            child: ConnectionLostScreen(),
          ),
          whenOnline: SplashController().handleConfigData,
          online: Stack(
            children: [
              CustomResponsive(
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
                  )
                ],
                topNavigationAlignment: MainAxisAlignment.center,
                drawerWidget: DrawerScreen(),
                // drawerWidget: const DrawerScreen(),
                actionsWidget: <Widget>[
                  ActionsBarWidget()
                ],
                actionsAlignment: MainAxisAlignment.end,
                bodyContent: Stack(
                  children: [
                    userController.isUserEmailVerified() ?
                    userController.isProfileComplete() ? pages[navController.selectedNavIndex]: ProfileUpdateScreen():
                    const EmailVerification(),
                    Obx(() {
                      return Visibility(
                        visible: homeController.isMenuOpen.value,
                        child: Positioned(
                          left: 0,
                          child: Container(
                            width: Get.width * 0.30,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10,
                            ),
                            // height: Get.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                menuWidget(
                                  onTap: () {
                                    homeController.onOpenMenuOrClose();
                                    navController.previousIndex.value = navController.selectedNavIndex;
                                    navController.handleNavIndexChanged(4);
                                  },
                                  title: AppTags.myPrivileges.tr,
                                  image: Images.privileges,
                                ),
                                const SizedBox(height: 10),
                                menuWidget(
                                  onTap: () => {},
                                  title: "Edit My Data",
                                  image: Images.edit,
                                ),
                                const SizedBox(height: 10),
                                menuWidget(
                                  onTap: () {
                                    homeController.onOpenMenuOrClose();
                                    navController.previousIndex.value = navController.selectedNavIndex;
                                    navController.handleNavIndexChanged(3);
                                  },
                                  title: "Settings",
                                  image: Images.settings,
                                ),
                                const SizedBox(height: 10),
                                menuWidget(
                                  onTap: () => {
                                    Get.defaultDialog(
                                      title: "Logging out",
                                      onCancel: () => Get.back(),
                                      onConfirm: ()  {
                                        navController.logout();
                                        homeController.onOpenMenuOrClose();
                                      },
                                      content: const Text("Are you sure you want to log out ?"),
                                      contentPadding: const EdgeInsets.all(30.0),
                                      cancelTextColor: Colors.black,
                                      confirmTextColor: Colors.white,
                                      buttonColor: AppColors.pinkButton,
                                    ),
                                  },
                                  title: "Logout",
                                  image: Images.settings,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                mobileBottomNavBar: Obx(()=>
                  Container(
                    height: Get.height / 10,
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
                        currentIndex: navController.selectedNavIndex,
                        dotIndicatorColor: Colors.transparent,
                        unselectedItemColor: Colors.grey[300],
                        backgroundColor: themeController.isDarkMode.isTrue ?
                        ThemeData.dark().scaffoldBackgroundColor: null,
                        enableFloatingNavBar: true,
                        onTap: navController.handleNavIndexChanged,
                        items: [
                          DotNavigationBarItem(
                            icon: Column(
                              children: [
                                Container(
                                  height: 3,
                                  width: 60,
                                  color: navController.selectedNavIndex == 0 &&
                                      !navController.isProfileView ?
                                  const Color(0xFFB14D78): themeController.isDarkMode.isTrue ?
                                  ThemeData.dark().scaffoldBackgroundColor: null,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 45,
                                  padding: const EdgeInsets.all(08),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(05),
                                  ),
                                  child: const Image(
                                    image: AssetImage("assets/images/ic1.png"),
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
                                  color: navController.selectedNavIndex == 1 &&
                                      !navController.isProfileView
                                      ? const Color(0xFFB14D78)
                                      : themeController.isDarkMode.isTrue ?
                                  ThemeData.dark().scaffoldBackgroundColor: null,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 45,
                                  padding: const EdgeInsets.all(08),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE6EF),
                                    borderRadius: BorderRadius.circular(05),
                                  ),
                                  child: const Image(
                                    image: AssetImage("assets/images/ic2.png"),
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
                                  color: navController.selectedNavIndex == 2 &&
                                      !navController.isProfileView
                                      ? const Color(0xFFB14D78)
                                      : themeController.isDarkMode.isTrue ?
                                  ThemeData.dark().scaffoldBackgroundColor: null,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 45,
                                  padding: const EdgeInsets.all(08),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    // color: themeController.isDarkMode.isTrue ?
                                    // Colors.grey.shade800:const Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(05),
                                  ),
                                  child: const Image(
                                    image: AssetImage(
                                      "assets/images/ic3.png",
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
                ),
                footerContent: FooterView(),
                enableChatSupport: true,
              ),
              if(!ResponsiveWidget.isSmallScreen(context))
                Obx(() {
                  return Visibility(
                    visible: chatController.isChatBoxOpened.value,
                    child: Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.5), width: 0.2)
                        ),
                        child: const ChatScreen(),
                      ),
                    ),
                  );
                })
            ],
          ),
        ),
      );
    }
    );
  }

  Widget menuWidget(
      {required String title, image, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              image,
              height: 6.sp,
              width: 6.sp,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
