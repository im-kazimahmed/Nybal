import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nybal/helpers/local_data_helper.dart';
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
import '../../models/user_model.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/model_drop_down.dart';
import '../../widgets/my_date_util.dart';
import '../../widgets/top_bar.dart';
import '../filter_page/filters.dart';


class WhoWishToMarryMembers extends StatelessWidget {
  WhoWishToMarryMembers({super.key});
  final controller = Get.find<PotentialMatchesCTR>();
  final LanguageController langController = Get.find<LanguageController>();
  final NavigationController navController = Get.find<NavigationController>();
  final SettingController settingController = Get.find<SettingController>();
  var dropDownValue;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (UserController controller) {
      return SafeArea(
        child: Column(
          children: [
            if(ResponsiveWidget.isSmallScreen(context))
              const TopBar(),
            const SizedBox(height: 10),
            const Text(
              "All Who Wish To Marry",
              style: TextStyle(
                shadows: <Shadow>[
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
                color: Color(0xFF574667),
              ),
            ),
            const SizedBox(height: 02),
            const Text(
              "Members who wish to marry",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "myFontLight",
                fontWeight: FontWeight.w600,
                color: Color(0xFFC0B4CC),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: Get.height / 15,
                        // width: Get.width,
                        color: const Color(0xFFF4F4F4),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomModelDropDown<CountryModel>(
                                backgroundColor: const Color(0xFFF4F4F4),
                                options: settingController.countriesList,
                                onOptionChange: (selectedCountry) => controller.onCountryChange(selectedCountry),
                                selectedValueColor: const Color(0xff000000),
                                optionLabel: (country) => country.name ?? AppTags.allCountriesHint.tr,
                                selectedValue: controller.selectedCountry ?? CountryModel(name: AppTags.allCountriesHint.tr),
                                isArrowOnLeft: false,
                                arrowIcon: Icons.keyboard_arrow_down,
                              ),
                            ),
                            ResponsiveWidget.isSmallScreen(context) ? GestureDetector(
                              onTap: () {
                                Get.to(() => const Filters_page());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: Get.height / 15,
                                width: Get.width / 7,
                                color: const Color(0xFFF4F4F4),
                                child: const Image(
                                    image: AssetImage("assets/images/filter.png")),
                              ),
                            ): Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => controller.onFilterChange(
                                      filterName: "gender",
                                      filterValue: "Female",
                                      originalUsersList: controller.marryInterestedUsers,
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
                                      originalUsersList: controller.marryInterestedUsers,
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
                                      originalUsersList: controller.marryInterestedUsers,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
              future: controller.getWhoWishToMarryMembers(),
              builder: (context, snapshot) {
                if(controller.marryInterestedUsers.isEmpty && controller.isLoading.isTrue) {
                  return const CustomLoader();
                } else if(controller.marryInterestedUsers.isNotEmpty) {
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
                      itemCount: controller.currentGenderFilter == "All" ?
                      controller.marryInterestedUsers.length: controller.filteredUsersList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        UserDataModel? user = controller.currentGenderFilter == "All" ?
                            controller.marryInterestedUsers[index]:
                            controller.filteredUsersList[index];
                        int? age = MyDateUtil.calculateAge(user.dateOfBirth);
                        return GestureDetector(
                          onTap: () {
                            controller.selectedUser.value = user;
                            controller.addProfileVisitRecord(user.id!);
                            navController.previousIndex.value = navController.selectedNavIndex;
                            navController.handleNavIndexChanged(10);
                            // Get.to(()=> const ProfileViewPage());
                            // controller.isProfileViewf(true);
                          },
                          child: Card(
                            elevation: 7.0,
                            shadowColor: const Color.fromARGB(255, 224, 224, 224),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
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
                                              decoration: TextDecoration.underline,
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
                                              user.profilePic.toString(),
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
                                        if(user.isPro == true)
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
                                            user.firstName.toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: "myFontLight",
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF574667),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 08),
                                          if(chatController.isUserOnline(user.id!))
                                            const CircleAvatar(
                                              radius: 5,
                                              backgroundColor: Colors.green,
                                            ),
                                        ],
                                      );
                                    }),
                                    if(user.country != "")
                                      Text(
                                        "${age ?? "Unknown"} ${AppTags.yearsOldFrom.tr} ${user.country}",
                                        style: TextStyle(
                                          fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                          ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                          fontFamily: "myFontLight",
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF27B2CC),
                                        ),
                                      ),
                                    const SizedBox(height: 10),
                                    if(user.maritalStatus != "")
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(user.maritalStatus.toString()),
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
                                    if(user.country != "" || user.city != "")
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
                                          if(user.city != "" && user.country != "")
                                            Text(
                                              '${user.city} / ${user.country}',
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget.isSmallScreen(context) ? 10: 3.sp,
                                                fontFamily: "myFontLight",
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF574667),
                                              ),
                                            )
                                          else if(user.city != "" && user.country == "")
                                            Text(
                                              '${user.city}',
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                fontFamily: "myFontLight",
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF574667),
                                              ),
                                            )
                                          else
                                            Text(
                                              '${user.country}',
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                fontFamily: "myFontLight",
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF574667),
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
                                            color: const Color(0xFF574667),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )),
                          ),
                        );
                      }),
                  );
                } else {
                  if(LocalDataHelper().getUserToken() != null && LocalDataHelper().getUserAllData() != null) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text("No members found"),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Please "),
                          InkWell(
                            onTap: () => navController.handleIndexChanged(2),
                            child: const Text(
                              "login",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff27B2CC),
                              ),
                            ),
                          ),
                          const Text(" to view members"),
                        ],
                      ),
                    );
                  }
                }
              }
            ),
          ],
        ),
        );
      }
    );
  }
}
