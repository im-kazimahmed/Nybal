import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/utils/validators.dart';
import 'package:nybal/views/web_views/sideBarMenus.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../Widgets/images.dart';
import '../../Widgets/theme_data.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../widgets/mobile_user_menu.dart';
import '../../widgets/top_bar.dart';

class Referrals extends StatelessWidget {
  Referrals({super.key});
  final LanguageController langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          UserDataModel? user = controller.userData.user;
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: SafeArea(
              child: Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  if (ResponsiveWidget.isSmallScreen(context))
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const MobileUserMenu(),
                            if(controller.sideBarMenusExpanded.isFalse)
                              ...[
                                const SizedBox(height: 40),
                                Text(
                                  AppTags.referral.tr,
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
                                    AppTags.inviteFriends.tr,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFFC0B4CC),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: Get.width,
                                          height: Get.height * 0.20,
                                          decoration: BoxDecoration(
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.grey.shade800:
                                            mainClr,
                                          ),
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 30),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppTags.sendInvitation.tr,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: themeController.isDarkMode.isTrue ?
                                                            ThemeData.light().scaffoldBackgroundColor:
                                                            ThemeData.dark().scaffoldBackgroundColor,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Flexible(
                                                      child: Text(
                                                        AppTags.sendReferralToFriends.tr,
                                                        style: const TextStyle(
                                                          color: Color(0xffC0B4CC),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(child: Image.asset(
                                                Images.jamMessages,
                                              )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: Get.width,
                                          height: Get.height * 0.20,
                                          decoration: BoxDecoration(
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.grey.shade800:
                                            mainClr,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(child: Image.asset(Images.registrationForm)),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppTags.registration.tr,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: themeController.isDarkMode.isTrue ?
                                                        ThemeData.light().scaffoldBackgroundColor:
                                                        ThemeData.dark().scaffoldBackgroundColor,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Flexible(
                                                      child: Text(
                                                        AppTags.letThemRegisterUsingReferral.tr,
                                                        style: const TextStyle(
                                                          color: Color(0xffC0B4CC),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: Get.width,
                                          height: Get.height * 0.20,
                                          decoration: BoxDecoration(
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.grey.shade800:
                                            mainClr,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 30),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppTags.getPay.tr,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: themeController.isDarkMode.isTrue ?
                                                        ThemeData.light().scaffoldBackgroundColor:
                                                        ThemeData.dark().scaffoldBackgroundColor,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Flexible(
                                                      child: Text(
                                                        AppTags.whenReferredUsers.tr,
                                                        style: const TextStyle(
                                                          color: Color(0xffC0B4CC),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(child: Image.asset(Images.creditCard)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   AppTags.inviteYourReferralFriends.tr,
                                    //   style: const TextStyle(
                                    //     color: Color(0xff574667),
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    //   textAlign: TextAlign.center,
                                    // ),
                                    Column(
                                      children: [
                                        Text(
                                          AppTags.shareTheReferralLink.tr,
                                          style: const TextStyle(
                                            color: Color(0xff574667),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          AppTags.youCanAlsoShareYourReferralSocialMedia.tr,
                                          style: const TextStyle(
                                            color: Color(0xFFC0B4CC),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: themeController.isDarkMode.isTrue ?
                                            Colors.grey.shade800:
                                            mainClr,
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 2.h),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Clipboard.setData(ClipboardData(text: '${user?.username}'));
                                                    showShortToast("Text copied to clipboard");
                                                  },
                                                  child: const Text(
                                                    "Copy referral code",
                                                    // AppTags.copyLink.tr,
                                                    style: TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color: Color(0xff27B2CC),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "${user?.username}",
                                                  style: const TextStyle(
                                                    color: Color(0xffC0B4CC),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        FutureBuilder(
                                          future: controller.getReferredUser(),
                                          builder: (context, snapshot) {
                                            List<UserDataModel>? users = snapshot.data;
                                            if(users != null && users.isNotEmpty) {
                                              return Container(
                                                width: Get.width,
                                                height: 50,
                                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "My referrals",
                                                      style: TextStyle(
                                                        color: Color(0xff574667),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Expanded(
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: users.length,
                                                        itemBuilder: (context, index) {
                                                          return Container(
                                                            // decoration: const BoxDecoration(
                                                            //   color: Colors.white,
                                                            // ),
                                                            padding: EdgeInsets.symmetric(vertical: 2.h),
                                                            child: Text(
                                                              "${users[index].firstName ?? users[index].username}, ",
                                                              style: const TextStyle(
                                                                decoration: TextDecoration.underline,
                                                                color: Color(0xff27B2CC),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                        if(user?.refBy != null)
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 2.h),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Referred by",
                                                    style: TextStyle(
                                                      color: Color(0xff574667),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${user?.refBy?.firstName ?? user?.refBy?.username}",
                                                    style: const TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color: Color(0xff27B2CC),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       decoration: const BoxDecoration(
                            //         color: Color(0xffE13F35),
                            //       ),
                            //       padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
                            //       alignment: Alignment.center,
                            //       child: Image.asset("assets/images/google_g.png"),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Container(
                            //       decoration: const BoxDecoration(
                            //         color: Color(0xff0777E8),
                            //       ),
                            //       alignment: Alignment.center,
                            //       padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 2.w),
                            //       child: Image.asset("assets/images/facebook_f.png"),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Container(
                            //       decoration: const BoxDecoration(
                            //         color: Color(0xff1D9BF0),
                            //       ),
                            //       alignment: Alignment.center,
                            //       padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
                            //       child: Image.asset("assets/images/twitter.png"),
                            //     ),
                            //   ],
                            // ),
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
                                          AppTags.referral.tr,
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
                                            AppTags.inviteFriends.tr,
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
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 1.2,
                                          width: size.width,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.2),
                                                              spreadRadius: 10,
                                                              blurRadius: 30,
                                                              offset: const Offset(0, 3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        padding: const EdgeInsets.all(20),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Image.asset(
                                                                Images.jamMessages,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    AppTags.sendInvitation.tr,
                                                                    style: const TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  Flexible(
                                                                    child: Text(
                                                                      AppTags.sendReferralToFriends.tr,
                                                                      style: const TextStyle(
                                                                        color: Color(0xffC0B4CC),
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.2),
                                                              spreadRadius: 10,
                                                              blurRadius: 30,
                                                              offset: const Offset(0, 3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        padding: const EdgeInsets.all(20),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(child: Image.asset(Images.registrationForm)),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    AppTags.registration.tr,
                                                                    style: const TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  Flexible(
                                                                    child: Text(
                                                                      AppTags.letThemRegisterUsingReferral.tr,
                                                                      style: const TextStyle(
                                                                        color: Color(0xffC0B4CC),
                                                                      ),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.2),
                                                              spreadRadius: 10,
                                                              blurRadius: 30,
                                                              offset: const Offset(0, 3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        padding: const EdgeInsets.all(20),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(child: Image.asset(Images.creditCard)),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    AppTags.getPay.tr,
                                                                    style: const TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  Flexible(
                                                                    child: Text(
                                                                      AppTags.whenReferredUsers.tr,
                                                                      style: const TextStyle(
                                                                        color: Color(0xffC0B4CC),
                                                                      ),
                                                                      textAlign: TextAlign.center,
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
                                              const SizedBox(height: 30),
                                              Expanded(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  padding: const EdgeInsets.all(20),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              AppTags.inviteYourReferralFriends.tr,
                                                              style: const TextStyle(
                                                                color: Color(0xff574667),
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              AppTags.insertYourFriendsAddresses.tr,
                                                              style: const TextStyle(
                                                                color: Color(0xFFC0B4CC),
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: TextField(
                                                          textAlign: TextAlign.right,
                                                          decoration: InputDecoration(
                                                            hintText: AppTags.emailAddressHint.tr,
                                                            hintStyle: const TextStyle(
                                                              color: Color(0xffC0B4CC),
                                                            ),
                                                            suffix: Image.asset(Images.directMessage),
                                                            filled: true,
                                                            fillColor: Colors.blueGrey[50],
                                                            labelStyle: const TextStyle(fontSize: 12),
                                                            // contentPadding: const EdgeInsets.all(10),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.blueGrey[50]!),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(color: Colors.blueGrey[50]!),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      AppTags.shareTheReferralLink.tr,
                                                      style: const TextStyle(
                                                        color: Color(0xff574667),
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      AppTags.youCanAlsoShareYourReferralSocialMedia.tr,
                                                      style: const TextStyle(
                                                        color: Color(0xFFC0B4CC),
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      padding: EdgeInsets.symmetric(vertical: 2.h),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Clipboard.setData(ClipboardData(text: '${user?.username}'));
                                                                showShortToast("Text copied to clipboard");
                                                              },
                                                              child: Text(
                                                                AppTags.copyLink.tr,
                                                                style: const TextStyle(
                                                                  decoration: TextDecoration.underline,
                                                                  color: Color(0xff27B2CC),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              "${user?.username}",
                                                              style: const TextStyle(
                                                                color: Color(0xffC0B4CC),
                                                              ),
                                                            ),
                                                          ]
                                                        ),
                                                      )
                                                    ),
                                                  ]
                                                )
                                              ),
                                              const SizedBox(height: 20),
                                              Expanded(
                                                child: FutureBuilder(
                                                  future: controller.getReferredUser(),
                                                  builder: (context, snapshot) {
                                                    List<UserDataModel>? users = snapshot.data;
                                                    if(users != null && users.isNotEmpty) {
                                                      return ListView.builder(
                                                        itemCount: users.length,
                                                        itemBuilder: (context, index) {
                                                          return Container(
                                                            width: Get.width,
                                                            height: 50,
                                                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "My referrals",
                                                                  style: TextStyle(
                                                                    color: Color(0xff574667),
                                                                  ),
                                                                ),
                                                                ListView.builder(
                                                                  shrinkWrap: true,
                                                                  scrollDirection: Axis.horizontal,
                                                                  itemCount: users.length,
                                                                  itemBuilder: (context, index) {
                                                                    return Container(
                                                                      decoration: const BoxDecoration(
                                                                        color: Colors.white,
                                                                      ),
                                                                      padding: EdgeInsets.symmetric(vertical: 2.h),
                                                                      child: Text(
                                                                        "${users[index].firstName ?? users[index].username}, ",
                                                                        style: const TextStyle(
                                                                          decoration: TextDecoration.underline,
                                                                          color: Color(0xff27B2CC),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  },
                                                ),
                                              ),
                                              if(user?.refBy != null)
                                                Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        const Text(
                                                          "Referred by",
                                                          style: TextStyle(
                                                            color: Color(0xff574667),
                                                          ),
                                                        ),
                                                        Text(
                                                          "${user?.refBy?.firstName ?? user?.refBy?.username}",
                                                          style: const TextStyle(
                                                            decoration: TextDecoration.underline,
                                                            color: Color(0xff27B2CC),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.center,
                                              //   children: [
                                              //     Container(
                                              //       decoration: const BoxDecoration(
                                              //         color: Color(0xffE13F35),
                                              //       ),
                                              //       padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
                                              //       alignment: Alignment.center,
                                              //       child: Image.asset("assets/images/google_g.png"),
                                              //     ),
                                              //     const SizedBox(width: 10),
                                              //     Container(
                                              //       decoration: const BoxDecoration(
                                              //         color: Color(0xff0777E8),
                                              //       ),
                                              //       alignment: Alignment.center,
                                              //       padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 2.w),
                                              //
                                              //       child: Image.asset("assets/images/facebook_f.png"),
                                              //     ),
                                              //     const SizedBox(width: 10),
                                              //     Container(
                                              //       decoration: const BoxDecoration(
                                              //         color: Color(0xff1D9BF0),
                                              //       ),
                                              //       alignment: Alignment.center,
                                              //       padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
                                              //
                                              //       child: Image.asset("assets/images/twitter.png"),
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
              ),
            ),
          );
        }
        );
      }
    );
  }
}
