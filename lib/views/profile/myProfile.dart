import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/views/blog.dart';
import 'package:nybal/views/web_views/sideBarMenus.dart';
import 'package:nybal/widgets/my_date_util.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../Widgets/theme_data.dart';
import '../../Widgets/images.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/user_model.dart';
import '../../routes/routes.dart';
import '../../widgets/top_bar.dart';
import '../faq.dart';
import '../help.dart';
import '../registration/registration_division.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();
  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(
      builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          UserDataModel? user = controller.userData.user;
          return WillPopScope(
            onWillPop: () async {
              navController.previousIndex.value = navController.selectedNavIndex;
              navController.handleNavIndexChanged(navController.previousIndex.value);
              return false;
            },
            child: SafeArea(
              child: controller.isEditMode.isFalse ?
              Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  if (ResponsiveWidget.isSmallScreen(context)) SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: user?.profilePic != null ? user!.profilePic.toString(): "",
                                      width: size.width,
                                      height: 140,
                                      fit: BoxFit.contain,
                                      placeholder: (context, url) => const CircleAvatar(
                                        child: Icon(CupertinoIcons.person),
                                      ),
                                      errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                        child: Icon(CupertinoIcons.person),
                                      ),
                                    ),
                                    if(user?.id != null && chatController.isUserOnline(user!.id!))
                                      Positioned(
                                        right: 30,
                                        bottom: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 5),
                                          ),
                                          padding: EdgeInsets.all(2.5.w),
                                        ),
                                      ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: InkWell(
                                        onTap: () => controller.onEditProfileChanged(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.pinkButton,
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          padding: const EdgeInsets.all(4.0),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: CachedNetworkImage(
                                      imageUrl: "${user?.countryFlag}",
                                      fit: BoxFit.cover,
                                      height: 20,
                                      width: 30,
                                      placeholder: (context, url) {
                                        return const CircleAvatar(
                                          child: Icon(
                                            CupertinoIcons.flag_fill,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return const CircleAvatar(
                                          child: Icon(CupertinoIcons.flag_fill),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "${user?.firstName ?? user?.username}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: themeController.isDarkMode.isTrue ?
                                      Colors.white:const Color(0xff574667),
                                      shadows: const [
                                        Shadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 5),
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            FittedBox(
                              child: Text(
                                "${AppTags.yourMembershipNumberIs.tr}: ${user?.id}",
                                style: TextStyle(
                                  color: themeController.isDarkMode.isTrue ?
                                  Colors.white:const Color(0xff574667),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              child: Column(
                                children: [
                                  Text(
                                    AppTags.registrationDate.tr,
                                    style: const TextStyle(
                                      color: Color(0xff27B2CC),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if(user?.createdAt != null)
                                    Text(
                                      MyDateUtil.formatRegistrationDateTime(user!.createdAt!),
                                      style: const TextStyle(
                                        color: Color(0xff27B2CC),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            FittedBox(
                              child: Column(
                                children: [
                                  const Text(
                                    "Wallet Balance",
                                    style: TextStyle(
                                      color: Color(0xff27B2CC),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${user?.wallet ?? 0}",
                                    style: const TextStyle(
                                      color: Color(0xff27B2CC),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            if(user?.gender!= null && user?.gender == "Male")
                              FittedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      "Wife",
                                      style: TextStyle(
                                        color: themeController.isDarkMode.isTrue ?
                                          ThemeData.light().scaffoldBackgroundColor:
                                          ThemeData.dark().scaffoldBackgroundColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    if(user?.wifeOf != null && user?.wifeOf != "")
                                      Text(
                                        "${user?.wifeOf}",
                                        style: const TextStyle(
                                          color: Color(0xff27B2CC),
                                          decoration: TextDecoration.underline,
                                        ),
                                      )
                                    else
                                      InkWell(
                                        onTap: () {
                                          // Get.to(()=> Scaffold(
                                          //   body: SizedBox(
                                          //     height: Get.height,
                                          //     width: Get.width,
                                          //     child: RegistrationDivision(),
                                          //   ),
                                          // ),
                                          // );
                                          navController.previousIndex.value = navController.selectedNavIndex;
                                          navController.handleNavIndexChanged(22);
                                        },
                                        child: const Text(
                                          "Register Now",
                                          style: TextStyle(
                                            color: Color(0xff27B2CC),
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            else if(user?.gender!= null && user?.gender == "Female")
                              FittedBox(
                                child: Column(
                                  children: [
                                    if(user?.wifeOf != null)
                                      const Text(
                                        "Wife Of",
                                      ),
                                    const SizedBox(height: 5),
                                    if(user?.wifeOf != null)
                                      Text(
                                        "${user?.wifeOf}",
                                        style: const TextStyle(
                                          color: Color(0xff27B2CC),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: themeController.isDarkMode.isTrue ?
                                  ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9):Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(10, 10), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                                child: Column(
                                  children: [
                                    Image.asset(Images.messageNotification),
                                    const SizedBox(height: 5),
                                    Text(
                                      "0 ${AppTags.unreadMessages.tr}",
                                      style: TextStyle(
                                        color: themeController.isDarkMode.isTrue ?
                                        Colors.white:const Color(0xff574667),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    Image.asset(Images.eye),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${user?.todayProfileVisits} ${AppTags.newVisitsToYourProfileToday.tr}",
                                      style: TextStyle(
                                        color: themeController.isDarkMode.isTrue ?
                                        Colors.white:const Color(0xff574667),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    Image.asset(Images.favoriteHeart),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${user?.weekLikes} ${AppTags.likesThisWeek.tr}",
                                      style: TextStyle(
                                        color: themeController.isDarkMode.isTrue ?
                                        Colors.white:const Color(0xff574667),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFFB800),
                                    Color(0xffFFE5A1),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical :10),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppTags.excellentPackage.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: themeController.isDarkMode.isTrue ?
                                ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9):Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                              child: Text(
                                AppTags.bySubscribingToTheExcellencePackage.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: themeController.isDarkMode.isTrue ?
                                  Colors.white: null
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: const BoxDecoration(
                                color: AppColors.pinkButton,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: InkWell(
                                onTap: () {

                                },
                                child: Text(
                                  AppTags.subscribeToTheExcellentPackage.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 300),
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
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              navController.previousIndex.value = navController.selectedNavIndex;
                                              navController.handleNavIndexChanged(3);
                                            },
                                            child: Image.asset(Images.settings),
                                          ),
                                          const SizedBox(width: 10),
                                          Image.asset(Images.edit),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                    width: 30,
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${user?.countryFlag}",
                                                      fit: BoxFit.cover,
                                                      height: 20,
                                                      width: 30,
                                                      placeholder: (context, url) {
                                                        return const CircleAvatar(
                                                          child: Icon(
                                                            CupertinoIcons.flag_fill,
                                                          ),
                                                        );
                                                      },
                                                      errorWidget: (context, url, error) {
                                                        return const CircleAvatar(
                                                          child: Icon(CupertinoIcons.flag_fill),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    "${user?.firstName ?? user?.username}",
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(0xff574667)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "${AppTags.yourMembershipNumberIs.tr}: ${user?.id}",
                                                textAlign: TextAlign.right,
                                              ),
                                              const SizedBox(height: 5),
                                              if(user?.createdAt != null)
                                                FittedBox(
                                                child: Text(
                                                  "${AppTags.registrationDate.tr}: ${MyDateUtil.formatRegistrationDateTime(user!.createdAt!)}",
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    color: Color(0xff27B2CC),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              FittedBox(
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Wallet Balance: ",
                                                      style: TextStyle(
                                                        color: Color(0xff27B2CC),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${user?.wallet ?? 0}",
                                                      style: const TextStyle(
                                                        color: Color(0xff27B2CC),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              if(user?.gender!= null && user?.gender == "Male")
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Wife",
                                                      ),
                                                      const SizedBox(width: 5),
                                                      if(user?.wifeOf != null && user?.wifeOf != "")
                                                        Text(
                                                          "${user?.wifeOf}",
                                                          style: const TextStyle(
                                                            color: Color(0xff27B2CC),
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        )
                                                      else
                                                        InkWell(
                                                          onTap: () {
                                                            navController.previousIndex.value = navController.selectedNavIndex;
                                                            navController.handleNavIndexChanged(22);
                                                          },
                                                          child: const Text(
                                                            "Register Now",
                                                            style: TextStyle(
                                                              color: Color(0xff27B2CC),
                                                              decoration: TextDecoration.underline,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                )
                                              else if(user?.gender!= null && user?.gender == "Female")
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      if(user?.wifeOf != null && user?.wifeOf != "")
                                                        const Text(
                                                          "Wife Of",
                                                        ),
                                                      const SizedBox(width: 5),
                                                      if(user?.wifeOf != null && user?.wifeOf != "")
                                                        Text(
                                                          "${user?.wifeOf}",
                                                          style: const TextStyle(
                                                            color: Color(0xff27B2CC),
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        )
                                                    ],
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
                                                  imageUrl: "${user?.profilePic}",
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
                                          // CachedNetworkImage(
                                          //   imageUrl: user?.profilePic != null ? user!.profilePic.toString(): "",
                                          //   fit: BoxFit.contain,
                                          //   placeholder: (context, url) => const CircleAvatar(
                                          //     child: Icon(CupertinoIcons.person),
                                          //   ),
                                          //   errorWidget: (context, url, error) =>
                                          //   const CircleAvatar(
                                          //     child: Icon(CupertinoIcons.person),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical : 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(Images.messageNotification),
                                              Text(
                                                "0 ${AppTags.unreadMessages.tr}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(Images.eye),
                                              Text(
                                                "${user?.todayProfileVisits ?? 0} ${AppTags.newVisitsToYourProfileToday.tr}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(Images.favoriteHeart),
                                              Text(
                                                "${user?.weekLikes ?? 0} ${AppTags.likesThisWeek.tr}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical : 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppTags.excellentPackage.tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300]!,
                                                spreadRadius: 0.1,
                                                blurRadius: 30,
                                                offset: const Offset(0, 20),
                                              )
                                            ],
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                          child: Text(
                                            AppTags.bySubscribingToTheExcellencePackage.tr,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.pinkButton,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: InkWell(
                                            onTap: () {

                                            },
                                            child: Text(
                                                AppTags.subscribeToTheExcellentPackage.tr,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
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
              ): Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  if (ResponsiveWidget.isSmallScreen(context)) SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: user?.profilePic != null ? user!.profilePic.toString(): "",
                                  width: size.width,
                                  height: 140,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const CircleAvatar(
                                    child: Icon(CupertinoIcons.person),
                                  ),
                                  errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                    child: Icon(CupertinoIcons.person),
                                  ),
                                ),
                              ),
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
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              navController.previousIndex.value = navController.selectedNavIndex;
                                              navController.handleNavIndexChanged(3);
                                            },
                                            child: Image.asset(Images.settings),
                                          ),
                                          const SizedBox(width: 10),
                                          Image.asset(Images.edit),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  // Icon(Icons.flag),
                                                  // SizedBox(width: 20),
                                                  Text(
                                                    "${user?.firstName ?? user?.username}",
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(0xff574667)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "${AppTags.yourMembershipNumberIs.tr}: ${user?.id}",
                                                textAlign: TextAlign.right,
                                              ),
                                              const SizedBox(height: 5),
                                              if(user?.createdAt != null)
                                                FittedBox(
                                                  child: Text(
                                                    "${AppTags.registrationDate.tr}: ${MyDateUtil.formatDateTime(user!.createdAt!)}",
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      color: Color(0xff27B2CC),
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(height: 5),
                                              FittedBox(
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Wallet Balance: ",
                                                      style: TextStyle(
                                                        color: Color(0xff27B2CC),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${user?.wallet ?? 0}",
                                                      style: const TextStyle(
                                                        color: Color(0xff27B2CC),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              if(user?.gender!= null && user?.gender == "Male")
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Wife",
                                                      ),
                                                      const SizedBox(width: 5),
                                                      if(user?.wifeOf != null && user?.wifeOf != "")
                                                        Text(
                                                          "${user?.wifeOf}",
                                                          style: const TextStyle(
                                                            color: Color(0xff27B2CC),
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        )
                                                      else
                                                        InkWell(
                                                          onTap: () {
                                                            navController.previousIndex.value = navController.selectedNavIndex;
                                                            navController.handleNavIndexChanged(22);
                                                          },
                                                          child: const Text(
                                                            "Register Now",
                                                            style: TextStyle(
                                                              color: Color(0xff27B2CC),
                                                              decoration: TextDecoration.underline,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                )
                                              else if(user?.gender!= null && user?.gender == "Female")
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      if(user?.wifeOf != null && user?.wifeOf != "")
                                                        const Text(
                                                          "Wife Of",
                                                        ),
                                                      const SizedBox(width: 5),
                                                      if(user?.wifeOf != null && user?.wifeOf != "")
                                                        Text(
                                                          "${user?.wifeOf}",
                                                          style: const TextStyle(
                                                            color: Color(0xff27B2CC),
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          CachedNetworkImage(
                                            imageUrl: user?.profilePic != null ? user!.profilePic.toString(): "",
                                            fit: BoxFit.contain,
                                            placeholder: (context, url) => const CircleAvatar(
                                              child: Icon(CupertinoIcons.person),
                                            ),
                                            errorWidget: (context, url, error) =>
                                            const CircleAvatar(
                                              child: Icon(CupertinoIcons.person),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical : 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(Images.messageNotification),
                                              Text(
                                                "18 ${AppTags.unreadMessages.tr}",
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(Images.eye),
                                              Text(
                                                "65 ${AppTags.newVisitsToYourProfileToday.tr}",
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Image.asset(Images.favoriteHeart),
                                              Text(
                                                "104 ${AppTags.likesThisWeek.tr}",
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical : 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppTags.excellentPackage.tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300]!,
                                                spreadRadius: 0.1,
                                                blurRadius: 30,
                                                offset: const Offset(0, 20),
                                              )
                                            ],
                                          ),
                                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                          child: Text(
                                            AppTags.bySubscribingToTheExcellencePackage.tr,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: AppColors.pinkButton,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: InkWell(
                                            onTap: () {

                                            },
                                            child: Text(
                                                AppTags.subscribeToTheExcellentPackage.tr,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
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
