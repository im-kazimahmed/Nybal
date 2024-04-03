

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../controllers/home_screen_controller.dart';
// import '../Widgets/shimmer_home_content.dart';
//
// class HomeScreenContent extends StatelessWidget {
//   HomeScreenContent({Key? key}) : super(key: key);
//   // final DashboardController homeScreenController =
//   // Get.find<DashboardController>();
//   final homeScreenContentController = Get.find<HomeScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Obx(
//           () => homeScreenContentController.homeDataModel.value.data != null
//           ? Scaffold(
//         extendBodyBehindAppBar: false,
//         body: SafeArea(
//           child: RefreshIndicator(
//             onRefresh: homeScreenContentController.getHomeDataFromServer,
//             child: homeScreenContentController.isLoadingFromServer.value
//                 ? const ShimmerHomeContent()
//                 : Column(
//               children: [
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 InkWell(
//                   onTap: () {
//
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 5.w, vertical: 12.h),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.search,
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             "Search in the supermarket",
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     height: size.height,
//                     width: double.infinity,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       //itemExtent: 2000,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: homeScreenContentController
//                           .homeDataModel.value.data!.length,
//                       scrollDirection: Axis.vertical,
//                       itemBuilder: (context, index) {
//                         return Obx(() => Text("sad"));
//                         // return Obx(() => categoryCheck(
//                         //     homeScreenContentController
//                         //         .homeDataModel.value,
//                         //     index,
//                         //     context));
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )
//           : const ShimmerHomeContent(),
//     );
//   }
//
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/utils/app_tags.dart';
import 'package:nybal/widgets/my_date_util.dart';
import 'package:sizer/sizer.dart';
import '../../../Widgets/responsive_widget.dart';
import '../../../controllers/chat_controller.dart';
import '../../../controllers/navigation_controller.dart';
import '../../../controllers/theme_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../models/country_model.dart';
import '../../../widgets/model_drop_down.dart';
import '../../../widgets/top_bar.dart';
import '../../widgets/theme_data.dart';
import '../filter_page/filters.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dropdownvalue;
  final UserController userController = Get.find<UserController>();
  final ChatController chatController = Get.find<ChatController>();
  final SettingController settingController = Get.find<SettingController>();
  final NavigationController navController = Get.find<NavigationController>();

  @override
  void initState() {
    chatController.onInitSocket();
    userController.getAllUsers();
    settingController.getCountriesList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleOnlineStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<UserController>(builder: (UserController controller) {
          return WillPopScope(
            onWillPop: () async {
              navController.previousIndex.value = navController.selectedNavIndex;
              navController.handleNavIndexChanged(navController.previousIndex.value);
              return false;
            },
            child: FutureBuilder(
              future: controller.getFavouriteList(),
              builder: (context, snapshot) {
                return FutureBuilder(
                  future: controller.getSpotlightUsers(),
                  builder: (context, snapshot) {
                    return SafeArea(
                      child: GestureDetector(
                        onTap: () => controller.onUserReportMenuChange(-1),
                        child: Column(
                          children: [
                            if(ResponsiveWidget.isSmallScreen(context))
                              const TopBar(),
                            const SizedBox(height: 10),
                            // InkWell(
                            //   onTap: () {
                            //     Get.to(()=> HomeScreen());
                            //   },
                            //   // child: Text('Hello, ${AuthCubit.get(context).currentUser.name}'),
                            // ),
                            Text(
                              AppTags.potentialMatches.tr,
                              style: const TextStyle(
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
                            Text(
                              AppTags.premiumMemberGetsSpecialBenefits.tr,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: "myFontLight",
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFC0B4CC),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => controller.onFilterChange(
                                    filterName: "gender",
                                    filterValue: "Female",
                                    originalUsersList: controller.usersList,
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
                                    originalUsersList: controller.usersList,
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
                                    originalUsersList: controller.usersList,
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
                                      ThemeData.dark().scaffoldBackgroundColor: const Color(0xFFF4F4F4),
                                      options: settingController.countriesList,
                                      onOptionChange: (selectedCountry) => controller.onCountryChange(selectedCountry),
                                      selectedValueColor: themeController.isDarkMode.isTrue ?
                                      Colors.white: const Color(0xff000000),
                                      optionLabel: (country) => country.name ?? AppTags.allCountriesHint.tr,
                                      selectedValue: controller.selectedCountry ?? CountryModel(name: AppTags.allCountriesHint.tr),
                                      isArrowOnLeft: false,
                                      arrowIcon: Icons.keyboard_arrow_down,
                                    ),
                                  ),
                                  // Container(
                                  //   alignment: Alignment.center,
                                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                                  //   height: Get.height / 15,
                                  //   // width: Get.width,
                                  //   color: const Color(0xFFF4F4F4),
                                  //   child: DropdownButton(
                                  //     onTap: () => settingController.countriesList.isNotEmpty ? settingController.getCountriesList(): null,
                                  //     // padding: EdgeInsets.only(left: 25, right: 25),
                                  //     underline: const Text(""),
                                  //     style: const TextStyle(textBaseline: null, color: Colors.black),
                                  //     menuMaxHeight: Get.height / 2,
                                  //     hint: Text(AppTags.allCountriesHint.tr),
                                  //     alignment: Alignment.centerLeft,
                                  //     value: settingController.selectedCountry.name,
                                  //     icon: const Icon(Icons.keyboard_arrow_down),
                                  //     iconSize: 20,
                                  //     // Array list of items
                                  //     items: settingController.countriesList.map((CountryModel country) {
                                  //       return DropdownMenuItem(
                                  //         value: country.id,
                                  //         child: Text(country.name.toString()),
                                  //       );
                                  //     }).toList(),
                                  //     // After selecting the desired option,it will
                                  //     // change button value to selected value
                                  //     onChanged: (newValue) {
                                  //       setState(() {
                                  //         dropdownvalue = newValue!;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
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
                                      ThemeData.dark().scaffoldBackgroundColor: const Color(0xFFF4F4F4),
                                      child: const Image(
                                        image: AssetImage("assets/images/filter.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: SizedBox(
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
                                  itemCount: controller.filteredUsersList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    if(controller.filteredUsersList.isNotEmpty) {
                                      int? age = MyDateUtil.calculateAge(controller.filteredUsersList[index].dateOfBirth);
                                      return Stack(
                                        children: [
                                          Card(
                                            elevation: 7.0,
                                            shadowColor: const Color.fromARGB(255, 224, 224, 224),
                                            color: themeController.isDarkMode.isTrue ?
                                            ThemeData.dark().scaffoldBackgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: const BorderSide(color: AppColors.pinkButton),
                                            ),
                                            // margin: EdgeInsets.all(5),
                                            child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  // horizontal: 10,
                                                  vertical: 0,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     width: 1, color: Color(0xFF000000)),
                                                  // color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 5.0),
                                                      child: FittedBox(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            if(controller.isAddedToFavouriteList(controller.filteredUsersList[index].id!))
                                                              const Icon(
                                                                Icons.favorite_outlined,
                                                                size: 22,
                                                                color: Color(0xFFffb800),
                                                              )
                                                            else
                                                              const Icon(
                                                                Icons.favorite_border,
                                                                size: 22,
                                                                color: Color(0xFFffb800),
                                                              ),
                                                            const SizedBox(width: 5),
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
                                                            const SizedBox(width: 5),
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
                                                    ),
                                                    Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            userController.selectedUser.value = controller.filteredUsersList[index];
                                                            userController.addProfileVisitRecord(controller.filteredUsersList[index].id!);
                                                            navController.previousIndex.value = navController.selectedNavIndex;
                                                            navController.handleNavIndexChanged(10);
                                                          },
                                                          child: SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: ClipOval(
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                controller.filteredUsersList[index].profilePic.toString(),
                                                                fit: BoxFit.cover,
                                                                height: 80,
                                                                width: 80,
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
                                                        ),
                                                        // CircleAvatar(
                                                        //   radius: 50,
                                                        //   backgroundImage: AssetImage(
                                                        //     "assets/images/profile.png",
                                                        //   ),
                                                        // ),
                                                        if(controller.filteredUsersList[index].isPro == true)
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
                                                          SizedBox(
                                                            height: 20,
                                                            width: 30,
                                                            child: CachedNetworkImage(
                                                              imageUrl: "${controller.userData.user?.countryFlag}",
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
                                                          const SizedBox(width: 08),
                                                          InkWell(
                                                            onTap: () {
                                                              userController.selectedUser.value = controller.filteredUsersList[index];
                                                              userController.addProfileVisitRecord(controller.filteredUsersList[index].id!);
                                                              navController.previousIndex.value = navController.selectedNavIndex;
                                                              navController.handleNavIndexChanged(10);
                                                              // Get.to(()=> const ProfileViewPage());
                                                              // controller.isProfileViewf(true);
                                                            },
                                                            child: Text(
                                                              controller.filteredUsersList[index].firstName.toString(),
                                                              style: TextStyle(
                                                                // fontSize: 18,
                                                                fontFamily: "myFontLight",
                                                                fontWeight: FontWeight.w600,
                                                                color: themeController.isDarkMode.isTrue ?
                                                                Colors.white :const Color(0xFF574667),
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 08),
                                                          if(chatController.isUserOnline(controller.filteredUsersList[index].id!))
                                                            const CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor: Colors.green,
                                                            ),
                                                        ],
                                                      );
                                                    }),
                                                    if(controller.filteredUsersList[index].country != "" && age != null && age > 0)
                                                      SizedBox(
                                                        height: 20,
                                                        child: Text(
                                                          "$age ${AppTags.yearsOldFrom.tr} ${controller.filteredUsersList[index].country}",
                                                          style: const TextStyle(
                                                            // fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                                            // ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                                            fontFamily: "myFontLight",
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xFF27B2CC),
                                                          ),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      )
                                                    else if(controller.filteredUsersList[index].country != "")
                                                      SizedBox(
                                                        height: 20,
                                                        child: Text(
                                                          "${controller.filteredUsersList[index].country}",
                                                          style: const TextStyle(
                                                            // fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                                            // ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                                            fontFamily: "myFontLight",
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xFF27B2CC),
                                                          ),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    // RichText(
                                                    //   text: TextSpan(
                                                    //     children: [
                                                    //       TextSpan(
                                                    //         text: "${age ?? "Unknown"}",
                                                    //       ),
                                                    //       TextSpan(
                                                    //         text: AppTags.yearsOldFrom.tr,
                                                    //       ),
                                                    //       TextSpan(
                                                    //         text: "${controller.filteredUsersList[index].country}",
                                                    //       ),
                                                    //     ],
                                                    //     style: TextStyle(
                                                    //       fontSize: ResponsiveWidget.isSmallScreen(context) ? 12:
                                                    //       ResponsiveWidget.isMediumScreen(context) ? 4.sp: 3.sp,
                                                    //       fontFamily: "myFontLight",
                                                    //       fontWeight: FontWeight.w600,
                                                    //       color: const Color(0xFF27B2CC),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // const SizedBox(height: 10),
                                                    if(controller.filteredUsersList[index].maritalStatus != "")
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            controller.filteredUsersList[index].maritalStatus.toString(),
                                                            style: TextStyle(
                                                              color: themeController.isDarkMode.isTrue ?
                                                              Colors.white: null
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
                                                    if(controller.filteredUsersList[index].country != "" || controller.filteredUsersList[index].city != "")
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                              width: 30,
                                                              child: CachedNetworkImage(
                                                                imageUrl: "${controller.userData.user?.countryFlag}",
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
                                                            const SizedBox(width: 08),
                                                            if(controller.filteredUsersList[index].city != "" && controller.filteredUsersList[index].country != "")
                                                              Expanded(
                                                                child: Text(
                                                                  '${controller.filteredUsersList[index].city} / ${controller.filteredUsersList[index].country}',
                                                                  style: TextStyle(
                                                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 10: 3.sp,
                                                                    fontFamily: "myFontLight",
                                                                    fontWeight: FontWeight.w600,
                                                                    color: themeController.isDarkMode.isTrue ?
                                                                    Colors.white: const Color(0xFF574667),
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              )
                                                            else if(controller.filteredUsersList[index].city != "" && controller.filteredUsersList[index].country == "")
                                                              Expanded(
                                                                child: Text(
                                                                  '${controller.filteredUsersList[index].city}',
                                                                  style: TextStyle(
                                                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                                    fontFamily: "myFontLight",
                                                                    fontWeight: FontWeight.w600,
                                                                    color: themeController.isDarkMode.isTrue ?
                                                                    Colors.white:const Color(0xFF574667),
                                                                  ),
                                                                ),
                                                              )
                                                            else
                                                              Expanded(
                                                                child: Text(
                                                                  '${controller.filteredUsersList[index].country}',
                                                                  style: TextStyle(
                                                                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: 3.sp,
                                                                    fontFamily: "myFontLight",
                                                                    fontWeight: FontWeight.w600,
                                                                    color: themeController.isDarkMode.isTrue ?
                                                                    Colors.white:const Color(0xFF574667),
                                                                  ),
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
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    InkWell(
                                                      onTap: () => userController.onUserReportMenuChange(index),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.report_gmailerrorred,
                                                            size: 08,
                                                            color: themeController.isDarkMode.isTrue ?
                                                            Colors.white:const Color(0xFFC0B4CC),
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
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          if (controller.openSelectUserReportMenuIndex.value != -1 && controller.openSelectUserReportMenuIndex.value == index)
                                            Positioned(
                                              bottom: 14,
                                              left: 18,
                                              child: Card(
                                                elevation: 7.0,
                                                shadowColor: const Color.fromARGB(255, 224, 224, 224),
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.onUserReportMenuChange(-1);
                                                    controller.reportUser(controller.filteredUsersList[index].id!);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                                    ),
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          AppTags.reportUser.tr,
                                                        ),
                                                        // Text("Report message"),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      );
                                    } else {
                                      return const Center(child: Text("No users found"));
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                );
              }
            ),
          );
        });
      }
    );
  }

  void handleOnlineStatus() {
    try {
      if(userController.userData.user?.onlineStatus != null) {
        chatController.isOnlineStatusVisible.value = userController.userData.user!.onlineStatus!;
      } else {
        chatController.isOnlineStatusVisible.value = true;
      }
    } catch(e) {
      chatController.isOnlineStatusVisible.value = true;
    }
  }
}
