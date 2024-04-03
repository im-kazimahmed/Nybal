import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../controllers/potential_matches_ctr.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/user_controller.dart';
import '../../Widgets/theme_data.dart';
import '../../models/country_model.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/model_drop_down.dart';
import '../../widgets/my_date_util.dart';
import '../../widgets/top_bar.dart';
import '../filter_page/filters.dart';

class NewMembers extends StatelessWidget {
  NewMembers({super.key});
  final controller = Get.find<PotentialMatchesCTR>();
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();
  final SettingController settingController = Get.find<SettingController>();
  // var dropDownValue;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          return SafeArea(
              child: Column(
                children: [
                  if(ResponsiveWidget.isSmallScreen(context))
                    const TopBar(),
                  const SizedBox(height: 10),
                  Text(
                    AppTags.newMembers.tr,
                    style: TextStyle(
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(0.2, 0.2),
                          blurRadius: 0.2,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(0.2, 0.2),
                          blurRadius: 1.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                      fontSize: 18,
                      fontFamily: "myFontLight",
                      fontWeight: FontWeight.w600,
                      color: themeController.isDarkMode.isTrue ?
                      Colors.white: const Color(0xFF574667),
                    ),
                  ),
                  const SizedBox(height: 02),
                  Text(
                    AppTags.latestRegistered.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "myFontLight",
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC0B4CC),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if(ResponsiveWidget.isSmallScreen(context))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => controller.onFilterChange(
                            filterName: "gender",
                            filterValue: "Female",
                            originalUsersList: controller.newMembers,
                            onFilteredListChanged: (filteredList) {
                              controller.filterMarryList(
                                filtered: filteredList,
                                filterValue: "Female",
                              );
                            },
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.currentGenderFilter == "Female" ? AppColors.pinkButton: null,
                              border: Border.all(color: AppColors.pinkButton),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                            child: Text(
                              AppTags.female.tr,
                              style: TextStyle(
                                color: controller.currentGenderFilter == "Female" ? Colors.white: AppColors.pinkButton,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () => controller.onFilterChange(
                            filterName: "gender",
                            filterValue: "Male",
                            originalUsersList: controller.newMembers,
                            onFilteredListChanged: (filteredList) {
                              controller.filterMarryList(
                                filtered: filteredList,
                                filterValue: "Male",
                              );
                            },
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.currentGenderFilter == "Male" ? AppColors.pinkButton: null,
                              border: Border.all(color: AppColors.pinkButton),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                            child: Text(
                              AppTags.male.tr,
                              style: TextStyle(
                                color: controller.currentGenderFilter == "Male" ? Colors.white: AppColors.pinkButton,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        InkWell(
                          onTap: () => controller.onFilterChange(
                            filterName: "gender",
                            filterValue: "All",
                            originalUsersList: controller.newMembers,
                            onFilteredListChanged: (filteredList) {
                              controller.filterMarryList(
                                filtered: filteredList,
                                filterValue: "All",
                              );
                            },
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.currentGenderFilter == "All" ? AppColors.pinkButton: null,
                              border: Border.all(color: AppColors.pinkButton),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                            child: Text(
                              AppTags.all.tr,
                              style: TextStyle(
                                color: controller.currentGenderFilter == "All" ? Colors.white: AppColors.pinkButton,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Container(
                    height: Get.height / 15,
                    width: Get.width / 1,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomModelDropDown<CountryModel>(
                            backgroundColor: themeController.isDarkMode.isTrue ?
                            ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9):const Color(0xFFF4F4F4),
                            options: settingController.countriesList,
                            onOptionChange: (selectedCountry) => controller.onCountryChange(selectedCountry),
                            selectedValueColor: themeController.isDarkMode.isTrue ?
                            Colors.white:const Color(0xff000000),
                            optionLabel: (country) => country.name ?? AppTags.allCountriesHint.tr,
                            selectedValue: controller.selectedCountry ?? CountryModel(name: AppTags.allCountriesHint.tr),
                            isArrowOnLeft: false,
                            arrowIcon: Icons.keyboard_arrow_down,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const Filters_page());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: Get.height / 15,
                            width: Get.width / 7,
                            color: themeController.isDarkMode.isTrue ?
                            ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.9):const Color(0xFFF4F4F4),
                            child: Image(
                              image: const AssetImage(
                                "assets/images/filter.png",
                              ),
                              color: themeController.isDarkMode.isTrue ?
                              Colors.white: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: controller.getNewMembers(),
                    builder: (context, snapshot) {
                      if(controller.newMembers.isEmpty && controller.isLoading.isTrue) {
                        return const CustomLoader();
                      } else if(controller.newMembers.isNotEmpty) {
                        return SizedBox(
                          height: Get.height / 1.5,
                          width: Get.width / 1.1,
                          // color: Colors.red,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 100),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: controller.newMembers.length,
                            itemBuilder: (BuildContext ctx, index) {
                              int? age = MyDateUtil.calculateAge(controller.newMembers[index].dateOfBirth);
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedUser.value = controller.newMembers[index];
                                  controller.addProfileVisitRecord(controller.newMembers[index].id!);
                                  navController.previousIndex.value = navController.selectedNavIndex;
                                  navController.handleNavIndexChanged(10);
                                  // Get.to(()=> const ProfileViewPage());
                                  // controller.isProfileViewf(true);
                                },
                                child: Card(
                                  elevation: 7.0,
                                  shadowColor: const Color.fromARGB(255, 224, 224, 224),
                                  color: themeController.isDarkMode.isTrue ?
                                  ThemeData.dark().scaffoldBackgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: AppColors.pinkButton)
                                  ),
                                  // margin: EdgeInsets.all(5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 0,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //     width: 1, color: Color(0xFF000000)),
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FittedBox(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(08),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Icon(
                                                  Icons.favorite_border,
                                                  size: 22,
                                                  color: Color(0xFFffb800),
                                                ),
                                                Text(
                                                  AppTags.whyIAmSeeingThis.tr,
                                                  style: TextStyle(
                                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 4.sp,
                                                    decoration:
                                                    TextDecoration.underline,
                                                    fontFamily: "myFontLight",
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: SvgPicture.asset(
                                                    "assets/images/chat-heart.svg",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              SizedBox(
                                                height: 90,
                                                width: 90,
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                    controller.newMembers[index].profilePic.toString(),
                                                    fit: BoxFit.cover,
                                                    height: 90,
                                                    width: 90,
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
                                              // CircleAvatar(
                                              //   radius: 50,
                                              //   backgroundImage: AssetImage(
                                              //     "assets/images/profile.png",
                                              //   ),
                                              // ),
                                              if(controller.newMembers[index].isPro == true)
                                                const Positioned(
                                                  bottom: 0,
                                                  right: 1,
                                                  child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: Color(0xFFffb800),
                                                    child: SizedBox(
                                                      height: 20,
                                                      width: 20,
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
                                          const SizedBox(height: 15),
                                          GetBuilder<ChatController>(builder: (ChatController chatController) {
                                            return Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                // const SizedBox(
                                                //   height: 15,
                                                //   width: 20,
                                                //   child: Image(
                                                //     image: AssetImage("assets/images/flag.png"),
                                                //     fit: BoxFit.cover,
                                                //   ),
                                                // ),
                                                const SizedBox(width: 08),
                                                Text(
                                                  controller.newMembers[index].firstName.toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "myFontLight",
                                                    fontWeight: FontWeight.w600,
                                                    color: themeController.isDarkMode.isTrue ?
                                                    Colors.white:const Color(0xFF574667),
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(width: 08),
                                                if(chatController.isUserOnline(controller.newMembers[index].id!))
                                                  const CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: Colors.green,
                                                  )
                                              ],
                                            );
                                          }),
                                          if(controller.newMembers[index].country != "")
                                            Text(
                                              "${age ?? "Unknown"} ${AppTags.yearsOldFrom.tr} ${controller.newMembers[index].country}",
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                                ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                                fontFamily: "myFontLight",
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF27B2CC),
                                              ),
                                            ),
                                          const SizedBox(height: 10),
                                          if(controller.newMembers[index].maritalStatus != "")
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  controller.newMembers[index].maritalStatus.toString(),
                                                  style: TextStyle(
                                                    color: themeController.isDarkMode.isTrue ?
                                                    Colors.white: null,
                                                  ),
                                                ),
                                                const SizedBox(width: 05),
                                                const Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: Image(
                                                        image: AssetImage("assets/images/heart_bg.png"),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      bottom: 0,
                                                      right: 0,
                                                      left: 0,
                                                      child: Icon(
                                                        Icons.favorite,
                                                        size: 08,
                                                        color: Color(0xFFCC1262),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          const SizedBox(height: 05),
                                          if(controller.newMembers[index].country != "" || controller.newMembers[index].city != "")
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                // const SizedBox(
                                                //   height: 15,
                                                //   width: 20,
                                                //   child: Image(
                                                //     image: AssetImage(
                                                //       "assets/images/flag.png",
                                                //     ),
                                                //     fit: BoxFit.cover,
                                                //   ),
                                                // ),
                                                // const SizedBox(width: 08),
                                                if(controller.newMembers[index].city != "" && controller.newMembers[index].country != "")
                                                  Text(
                                                    '${controller.newMembers[index].city} / ${controller.newMembers[index].country}',
                                                    style: TextStyle(
                                                      fontSize: ResponsiveWidget.isSmallScreen(context) ? 10: 3.sp,
                                                      fontFamily: "myFontLight",
                                                      fontWeight: FontWeight.w600,
                                                      color: themeController.isDarkMode.isTrue ?
                                                      Colors.white:const Color(0xFF574667),
                                                    ),
                                                  )
                                                else if(controller.newMembers[index].city != "" && controller.newMembers[index].country == "")
                                                  Text(
                                                    '${controller.newMembers[index].city}',
                                                    style: TextStyle(
                                                      fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                      fontFamily: "myFontLight",
                                                      fontWeight: FontWeight.w600,
                                                      color: themeController.isDarkMode.isTrue ?
                                                      Colors.white:const Color(0xFF574667),
                                                    ),
                                                  )
                                                else
                                                  Text(
                                                    '${controller.newMembers[index].country}',
                                                    style: TextStyle(
                                                      fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                      fontFamily: "myFontLight",
                                                      fontWeight: FontWeight.w600,
                                                      color: themeController.isDarkMode.isTrue ?
                                                      Colors.white:const Color(0xFF574667),
                                                    ),
                                                  ),
                                                const SizedBox(width: 08),
                                                Stack(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: Image(
                                                        image: AssetImage("assets/images/heart_bg.png"),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      bottom: 0,
                                                      right: 0,
                                                      left: 0,
                                                      child: Container(
                                                        alignment: const Alignment(0, -0.3),
                                                        child: const Text(
                                                          "○",
                                                          style: TextStyle(
                                                            color: Color(0xFFCC1262),
                                                            fontSize: 07,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.report_gmailerrorred,
                                                size: 08,
                                                color: Color(0xFFC0B4CC),
                                              ),
                                              const SizedBox(width: 05),
                                              Text(
                                                AppTags.reportUser.tr,
                                                style: TextStyle(
                                                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 4.sp,
                                                  decoration:
                                                  TextDecoration.underline,
                                                  fontFamily: "myFontLight",
                                                  fontWeight: FontWeight.w600,
                                                  color: themeController.isDarkMode.isTrue ?
                                                  Colors.white:const Color(0xFF574667),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Text(
                          "No members found",
                          style: TextStyle(
                            color: themeController.isDarkMode.isTrue ?
                            Colors.white: null,
                          ),
                        );
                      }
                    }
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}
