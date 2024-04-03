import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/controllers/payment_controller.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/utils/functions.dart';
import 'package:nybal/views/profile/interests_screen.dart';
import 'package:nybal/widgets/theme_data.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/responsive_widget.dart';
import '../../controllers/setting_controller.dart';
import '../../controllers/splash_controller.dart';
import '../../controllers/user_controller.dart';
import '../../helpers/local_data_helper.dart';
import '../../models/package_model.dart';
import '../../utils/app_tags.dart';
import '../../widgets/top_bar.dart';
import '../../widgets/dialogs.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final PaymentController paymentController = Get.find<PaymentController>();
  final UserController userController = Get.find<UserController>();
  final NavigationController navController = Get.find<NavigationController>();
  final ThemeController themeController = Get.find<ThemeController>();
  var dropDownValue;
  double _currentValue = 25;
  final RangeValues _currentRange = const RangeValues(20, 40);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (SettingController controller) {
      return FutureBuilder<List<UserPackage>?>(
        future: controller.getPackagesList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoader());
          } else if(snapshot.hasData) {
            return Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    children: [
                      if(ResponsiveWidget.isSmallScreen(context))
                        const TopBar(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 20.w,
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppTags.loveForIslamicMarriage.tr,
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
                                fontSize: 30,
                                fontFamily: "myFontLight",
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8F003E),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              AppTags.weAreLookingForYourOtherHalf.tr,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: "myFontLight",
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF574667),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if(controller.specialPackageAvailable.isTrue)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 20.w,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xff574667),
                                  Color(0xffCC1262),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  AppTags.specialSubscriptionPrice.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Obx(()=>
                                            Text(
                                              controller.hours.value.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppTags.hrs.tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Obx(()=>
                                            Text(
                                              controller.minutes.value.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppTags.min.tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Obx(()=>
                                            Text(
                                              controller.seconds.string,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppTags.sec.tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                                      child: Text(
                                        AppTags.clickHere.tr,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if(LocalDataHelper().getUserToken() == null && LocalDataHelper().getUserAllData() == null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 30.0: 20.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    navController.previousIndex.value = navController.selectedIndex.value;
                                    navController.handleIndexChanged(2);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.pinkButton,
                                      border: Border.all(color: AppColors.pinkButton),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                    child: Text(
                                      AppTags.signUp.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    navController.previousIndex.value = navController.selectedIndex.value;
                                    navController.handleIndexChanged(2);
                                  },
                                  child: Obx(()=>
                                    Container(
                                      decoration: BoxDecoration(
                                        color: themeController.isDarkMode.isTrue ?
                                        ThemeData.dark().scaffoldBackgroundColor: AppColors.whiteColor,
                                        border: Border.all(color: AppColors.pinkButton),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                      child: Text(
                                        AppTags.signIn.tr,
                                        style: const TextStyle(
                                          color: AppColors.pinkButton,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (controller.packages.where((package) => package.name != "Free Package").toList().length > 1)
                      // height: ResponsiveWidget.isSmallScreen(context) ? Get.height: 200,
                        SizedBox(
                          height: ResponsiveWidget.isSmallScreen(context) ?  Get.height * controller.packages.length / 3: 200,
                          child: ListView.builder(
                            // shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: ResponsiveWidget.isLargeScreen(context) ? Axis.horizontal: Axis.vertical,
                            itemCount: controller.packages.length,
                            itemBuilder: (context, index) {
                              List<UserPackage> packages = controller.packages.where((package) => package.name != "Free Package").toList();
                              if (controller.packages[index].name != "Free Package") {
                                return InkWell(
                                  onTap: () {
                                    userController.purchasePackage(
                                      packageId: controller.packages[index].id!,
                                      purchasedAmount: controller.packages[index].price!,
                                      discount: 0,
                                      finalAmount: controller.packages[index].price!,
                                    );
                                  },
                                  child: Obx(()=>
                                    Container(
                                      margin: ResponsiveWidget.isSmallScreen(context) ?
                                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20): const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      height: !ResponsiveWidget.isSmallScreen(context) ? 20: 200,
                                      // height: ResponsiveWidget.isSmallScreen(context) ? 200: 1.h,
                                      width: !ResponsiveWidget.isSmallScreen(context) ? 25.w: null,
                                      decoration: BoxDecoration(
                                        color: themeController.isDarkMode.isTrue ?
                                        ThemeData.dark().scaffoldBackgroundColor: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(),
                                          Text(
                                            getPackageDuration(controller.packages
                                                .firstWhere((package) => package.name != "Free Package")
                                                .duration ?? 0),
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "\$${controller.packages[index].price}",
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Image.asset("assets/images/premium.png"),
                                          const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        )
                      else Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          onTap: () {
                            int? price = controller.packages
                                .firstWhere((package) => package.name != "Free Package")
                                .price;
                            if(price != null && LocalDataHelper().getUserToken() != null && LocalDataHelper().getUserAllData() != null) {
                              paymentController.createPaymentIntent(amount: price);
                            } else {
                              Dialogs.showDefaultDialogue(
                                title: "Login",
                                middleText: "Please login or create account in order to subscribe to the package",
                                onConfirmation: () {
                                  Get.back();
                                }
                              );
                            }
                          },
                          child: Container(
                            // margin: const EdgeInsets.all(10),
                            // padding: const EdgeInsets.all(10),
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  getPackageDuration(controller.packages
                                      .firstWhere((package) => package.name != "Free Package")
                                      .duration ?? 0),
                                  // controller.packages
                                  //     .firstWhere((package) => package.name != "Free Package")
                                  //     .name
                                  //     .toString(),
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$${controller.packages.firstWhere((package) => package.name != "Free Package").price}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Image.asset("assets/images/premium.png"),
                              ],
                            ),
                          ),
                        ),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       color: Colors.white,
                      //     ),
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 20,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         // Row(
                      //         //   mainAxisSize: MainAxisSize.max,
                      //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         //   children: [
                      //         //     Expanded(
                      //         //       child: Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: Colors.white,
                      //         //         ),
                      //         //         child: Column(
                      //         //           mainAxisSize: MainAxisSize.max,
                      //         //           mainAxisAlignment: MainAxisAlignment.center,
                      //         //           crossAxisAlignment: CrossAxisAlignment.center,
                      //         //           children: [
                      //         //             Text(
                      //         //               AppTags.quickSearch.tr,
                      //         //               style: TextStyle(
                      //         //                 shadows: const <Shadow>[
                      //         //                   Shadow(
                      //         //                     offset: Offset(0.2, 0.2),
                      //         //                     blurRadius: 0.2,
                      //         //                     color: Color.fromARGB(255, 0, 0, 0),
                      //         //                   ),
                      //         //                   Shadow(
                      //         //                     offset: Offset(0.2, 0.2),
                      //         //                     blurRadius: 1.0,
                      //         //                     color: Color.fromARGB(125, 0, 0, 255),
                      //         //                   ),
                      //         //                 ],
                      //         //                 fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 18,
                      //         //                 fontFamily: "myFontLight",
                      //         //                 fontWeight: FontWeight.w600,
                      //         //                 color: const Color(0xFF574667),
                      //         //               ),
                      //         //               textAlign: TextAlign.center,
                      //         //             ),
                      //         //           ],
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //     Expanded(
                      //         //       child: Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: Color(0xffF4F4F4),
                      //         //         ),
                      //         //         child: Column(
                      //         //           mainAxisSize: MainAxisSize.max,
                      //         //           mainAxisAlignment: MainAxisAlignment.center,
                      //         //           crossAxisAlignment: CrossAxisAlignment.center,
                      //         //           children: [
                      //         //             Text(
                      //         //               AppTags.searchByUsername.tr,
                      //         //               style: TextStyle(
                      //         //                 fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 18,
                      //         //                 fontFamily: "myFontLight",
                      //         //                 fontWeight: FontWeight.w500,
                      //         //                 color: const Color(0xFF574667),
                      //         //               ),
                      //         //               textAlign: TextAlign.center,
                      //         //             ),
                      //         //           ],
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //     Expanded(
                      //         //       child: Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: Color(0xffF4F4F4),
                      //         //         ),
                      //         //         child: Column(
                      //         //           mainAxisSize: MainAxisSize.max,
                      //         //           mainAxisAlignment: MainAxisAlignment.center,
                      //         //           crossAxisAlignment: CrossAxisAlignment.center,
                      //         //           children: [
                      //         //             Text(
                      //         //               AppTags.advancedSearch.tr,
                      //         //               style: TextStyle(
                      //         //                 fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.sp: 18,
                      //         //                 fontFamily: "myFontLight",
                      //         //                 fontWeight: FontWeight.w500,
                      //         //                 color: const Color(0xFF574667),
                      //         //               ),
                      //         //               textAlign: TextAlign.center,
                      //         //             ),
                      //         //           ],
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //   ],
                      //         // ),
                      //         // const SizedBox(height: 20),
                      //         // ResponsiveWidget.isSmallScreen(context) ? Column(
                      //         //   mainAxisAlignment: MainAxisAlignment.center,
                      //         //   children: [
                      //         //     Text(
                      //         //       AppTags.startSearching.tr,
                      //         //       style: const TextStyle(
                      //         //         fontFamily: "poppins",
                      //         //         fontWeight: FontWeight.w500,
                      //         //         fontSize: 22,
                      //         //       ),
                      //         //     ),
                      //         //     const SizedBox(height: 30),
                      //         //     InkWell(
                      //         //       onTap: () {
                      //         //
                      //         //       },
                      //         //       child: Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: AppColors.pinkButton,
                      //         //         ),
                      //         //         padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                      //         //         child: Text(
                      //         //           AppTags.lookingForAHusband.tr,
                      //         //           style: const TextStyle(
                      //         //             color: Colors.white,
                      //         //           ),
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //     const SizedBox(height: 10,),
                      //         //     InkWell(
                      //         //       onTap: () {
                      //         //
                      //         //       },
                      //         //       child: Container(
                      //         //         decoration: BoxDecoration(
                      //         //           border: Border.all(color: AppColors.pinkButton),
                      //         //         ),
                      //         //         padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                      //         //         child: Text(
                      //         //           AppTags.imLookingForAWife.tr,
                      //         //           style: const TextStyle(
                      //         //             color: AppColors.pinkButton,
                      //         //           ),
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //   ],
                      //         // ): Row(
                      //         //   mainAxisAlignment: MainAxisAlignment.center,
                      //         //   children: [
                      //         //     InkWell(
                      //         //       onTap: () {
                      //         //
                      //         //       },
                      //         //       child: Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: AppColors.pinkButton,
                      //         //         ),
                      //         //         padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                      //         //         child: Text(
                      //         //           AppTags.lookingForAHusband.tr,
                      //         //           style: const TextStyle(
                      //         //             color: Colors.white,
                      //         //           ),
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //     const SizedBox(width: 20,),
                      //         //     InkWell(
                      //         //       onTap: () {
                      //         //
                      //         //       },
                      //         //       child: Container(
                      //         //         decoration: BoxDecoration(
                      //         //           border: Border.all(color: AppColors.pinkButton),
                      //         //         ),
                      //         //         padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                      //         //         child: Text(
                      //         //           AppTags.imLookingForAWife.tr,
                      //         //           style: const TextStyle(
                      //         //             color: AppColors.pinkButton,
                      //         //           ),
                      //         //         ),
                      //         //       ),
                      //         //     ),
                      //         //   ],
                      //         // ),
                      //         // const SizedBox(height: 20),
                      //         // ResponsiveWidget.isSmallScreen(context) ?
                      //         // Padding(
                      //         //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //         //   child: Column(
                      //         //     crossAxisAlignment: CrossAxisAlignment.end,
                      //         //     children: [
                      //         //       Text(
                      //         //         AppTags.relationshipStatus.tr,
                      //         //         style: const TextStyle(
                      //         //           color: Color(0xffC0B4CC),
                      //         //         ),
                      //         //       ),
                      //         //       const SizedBox(height: 10),
                      //         //       Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: Color(0xffF4F4F4),
                      //         //         ),
                      //         //         child: DropdownButton(
                      //         //           padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         //           underline: const Text(""),
                      //         //           style: const TextStyle(textBaseline: null, color: Colors.black),
                      //         //           menuMaxHeight: Get.height / 2,
                      //         //           hint: Text(AppTags.allCases.tr),
                      //         //           alignment: Alignment.centerRight,
                      //         //           isExpanded: true,
                      //         //           // Initial Value
                      //         //           value: dropDownValue,
                      //         //           icon: const Icon(Icons.keyboard_arrow_down),
                      //         //           iconSize: 20,
                      //         //           // Array list of items
                      //         //           items: countries.map((String items) {
                      //         //             return DropdownMenuItem(
                      //         //               value: items,
                      //         //               child: Text(items),
                      //         //             );
                      //         //           }).toList(),
                      //         //           // After selecting the desired option,it will
                      //         //           // change button value to selected value
                      //         //           onChanged: (newValue) {
                      //         //             // dropDownValue = newValue;
                      //         //           },
                      //         //         ),
                      //         //       ),
                      //         //       const SizedBox(height: 20),
                      //         //       Text(
                      //         //         AppTags.placeOfResidence.tr,
                      //         //         style: const TextStyle(
                      //         //           color: Color(0xffC0B4CC),
                      //         //         ),
                      //         //       ),
                      //         //       const SizedBox(height: 10),
                      //         //       Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: Color(0xffF4F4F4),
                      //         //         ),
                      //         //         child: DropdownButton(
                      //         //           padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         //           underline: const Text(""),
                      //         //           style: const TextStyle(textBaseline: null, color: Colors.black),
                      //         //           menuMaxHeight: Get.height / 2,
                      //         //           hint: const Text("USA"),
                      //         //           alignment: Alignment.centerRight,
                      //         //           isExpanded: true,
                      //         //           // Initial Value
                      //         //           value: dropDownValue,
                      //         //           icon: const Icon(Icons.keyboard_arrow_down),
                      //         //           iconSize: 20,
                      //         //           // Array list of items
                      //         //           items: countries.map((String items) {
                      //         //             return DropdownMenuItem(
                      //         //               value: items,
                      //         //               child: Text(items),
                      //         //             );
                      //         //           }).toList(),
                      //         //           // After selecting the desired option,it will
                      //         //           // change button value to selected value
                      //         //           onChanged: (newValue) {
                      //         //             // dropDownValue = newValue;
                      //         //           },
                      //         //         ),
                      //         //       ),
                      //         //       const SizedBox(height: 20),
                      //         //       Text(
                      //         //         AppTags.nationality.tr,
                      //         //         style: const TextStyle(
                      //         //           color: Color(0xffC0B4CC),
                      //         //         ),
                      //         //       ),
                      //         //       const SizedBox(height: 10),
                      //         //       Container(
                      //         //         decoration: const BoxDecoration(
                      //         //           color: Color(0xffF4F4F4),
                      //         //         ),
                      //         //         child: DropdownButton(
                      //         //           padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         //           underline: const Text(""),
                      //         //           style: const TextStyle(textBaseline: null, color: Colors.black),
                      //         //           menuMaxHeight: Get.height / 2,
                      //         //           hint: const Text("USA"),
                      //         //           alignment: Alignment.centerRight,
                      //         //           isExpanded: true,
                      //         //           // Initial Value
                      //         //           value: dropDownValue,
                      //         //           icon: const Icon(Icons.keyboard_arrow_down),
                      //         //           iconSize: 20,
                      //         //           // Array list of items
                      //         //           items: countries.map((String items) {
                      //         //             return DropdownMenuItem(
                      //         //               value: items,
                      //         //               child: Text(items),
                      //         //             );
                      //         //           }).toList(),
                      //         //           // After selecting the desired option,it will
                      //         //           // change button value to selected value
                      //         //           onChanged: (newValue) {
                      //         //             // dropDownValue = newValue;
                      //         //           },
                      //         //         ),
                      //         //       ),
                      //         //     ],
                      //         //   ),
                      //         // ): Column(
                      //         //   children: [
                      //         //     Row(
                      //         //       mainAxisAlignment: MainAxisAlignment.end,
                      //         //       crossAxisAlignment: CrossAxisAlignment.end,
                      //         //       children: [
                      //         //         Expanded(
                      //         //           child: Text(
                      //         //             AppTags.relationshipStatus.tr,
                      //         //             style: const TextStyle(
                      //         //               color: Color(0xffC0B4CC),
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //         Expanded(
                      //         //           child: Text(
                      //         //             AppTags.placeOfResidence.tr,
                      //         //             style: const TextStyle(
                      //         //               color: Color(0xffC0B4CC),
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //         Expanded(
                      //         //           child: Text(
                      //         //             AppTags.nationality.tr,
                      //         //             style: const TextStyle(
                      //         //               color: Color(0xffC0B4CC),
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //       ],
                      //         //     ),
                      //         //     const SizedBox(height: 10),
                      //         //     Row(
                      //         //       children: [
                      //         //         Expanded(
                      //         //           child: Container(
                      //         //             decoration: const BoxDecoration(
                      //         //               color: Color(0xffF4F4F4),
                      //         //             ),
                      //         //             child: DropdownButton(
                      //         //               padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         //               underline: const Text(""),
                      //         //               style: const TextStyle(textBaseline: null, color: Colors.black),
                      //         //               menuMaxHeight: Get.height / 2,
                      //         //               hint: Text(AppTags.allCases.tr),
                      //         //               alignment: Alignment.centerRight,
                      //         //               isExpanded: true,
                      //         //               // Initial Value
                      //         //               value: dropDownValue,
                      //         //               icon: const Icon(Icons.keyboard_arrow_down),
                      //         //               iconSize: 20,
                      //         //               // Array list of items
                      //         //               items: countries.map((String items) {
                      //         //                 return DropdownMenuItem(
                      //         //                   value: items,
                      //         //                   child: Text(items),
                      //         //                 );
                      //         //               }).toList(),
                      //         //               // After selecting the desired option,it will
                      //         //               // change button value to selected value
                      //         //               onChanged: (newValue) {
                      //         //                 // dropDownValue = newValue;
                      //         //               },
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //         const SizedBox(width: 10),
                      //         //         Expanded(
                      //         //           child: Container(
                      //         //             decoration: const BoxDecoration(
                      //         //               color: Color(0xffF4F4F4),
                      //         //             ),
                      //         //             child: DropdownButton(
                      //         //               padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         //               underline: const Text(""),
                      //         //               style: const TextStyle(textBaseline: null, color: Colors.black),
                      //         //               menuMaxHeight: Get.height / 2,
                      //         //               hint: const Text("USA"),
                      //         //               alignment: Alignment.centerRight,
                      //         //               isExpanded: true,
                      //         //               // Initial Value
                      //         //               value: dropDownValue,
                      //         //               icon: const Icon(Icons.keyboard_arrow_down),
                      //         //               iconSize: 20,
                      //         //               // Array list of items
                      //         //               items: countries.map((String items) {
                      //         //                 return DropdownMenuItem(
                      //         //                   value: items,
                      //         //                   child: Text(items),
                      //         //                 );
                      //         //               }).toList(),
                      //         //               // After selecting the desired option,it will
                      //         //               // change button value to selected value
                      //         //               onChanged: (newValue) {
                      //         //                 // dropDownValue = newValue;
                      //         //               },
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //         const SizedBox(width: 10),
                      //         //         Expanded(
                      //         //           child: Container(
                      //         //             decoration: const BoxDecoration(
                      //         //               color: Color(0xffF4F4F4),
                      //         //             ),
                      //         //             child: DropdownButton(
                      //         //               padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         //               underline: const Text(""),
                      //         //               style: const TextStyle(textBaseline: null, color: Colors.black),
                      //         //               menuMaxHeight: Get.height / 2,
                      //         //               hint: const Text("USA"),
                      //         //               alignment: Alignment.centerRight,
                      //         //               isExpanded: true,
                      //         //               // Initial Value
                      //         //               value: dropDownValue,
                      //         //               icon: const Icon(Icons.keyboard_arrow_down),
                      //         //               iconSize: 20,
                      //         //               // Array list of items
                      //         //               items: countries.map((String items) {
                      //         //                 return DropdownMenuItem(
                      //         //                   value: items,
                      //         //                   child: Text(items),
                      //         //                 );
                      //         //               }).toList(),
                      //         //               // After selecting the desired option,it will
                      //         //               // change button value to selected value
                      //         //               onChanged: (newValue) {
                      //         //                 // dropDownValue = newValue;
                      //         //               },
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //       ],
                      //         //     ),
                      //         //     const SizedBox(height: 30),
                      //         //     Row(
                      //         //       mainAxisAlignment: MainAxisAlignment.start,
                      //         //       crossAxisAlignment: CrossAxisAlignment.start,
                      //         //       children: [
                      //         //         Expanded(
                      //         //           child: Text(
                      //         //             AppTags.orderBy.tr,
                      //         //             style: const TextStyle(
                      //         //               color: Color(0xffC0B4CC),
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //         Expanded(
                      //         //           child: Text(
                      //         //             AppTags.theAge.tr,
                      //         //             style: const TextStyle(
                      //         //               color: Color(0xffC0B4CC),
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //       ],
                      //         //     ),
                      //         //     const SizedBox(height: 10),
                      //         //     Row(
                      //         //       children: [
                      //         //         Expanded(
                      //         //           child: Container(
                      //         //             decoration: const BoxDecoration(
                      //         //               color: Color(0xffF4F4F4),
                      //         //             ),
                      //         //             child: DropdownButton(
                      //         //               padding: const EdgeInsets.symmetric(horizontal: 5),
                      //         //               underline: const Text(""),
                      //         //               style: const TextStyle(textBaseline: null, color: Colors.black),
                      //         //               menuMaxHeight: Get.height / 2,
                      //         //               hint: Text(AppTags.lastLogged.tr),
                      //         //               alignment: Alignment.centerRight,
                      //         //               isExpanded: true,
                      //         //               // Initial Value
                      //         //               value: dropDownValue,
                      //         //               icon: const Icon(Icons.keyboard_arrow_down),
                      //         //               iconSize: 20,
                      //         //               // Array list of items
                      //         //               items: countries.map((String items) {
                      //         //                 return DropdownMenuItem(
                      //         //                   value: items,
                      //         //                   child: Text(items),
                      //         //                 );
                      //         //               }).toList(),
                      //         //               // After selecting the desired option,it will
                      //         //               // change button value to selected value
                      //         //               onChanged: (newValue) {
                      //         //                 // dropDownValue = newValue;
                      //         //               },
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //         const SizedBox(width: 10),
                      //         //         Expanded(
                      //         //           child: Column(
                      //         //             mainAxisAlignment: MainAxisAlignment.center,
                      //         //             children: [
                      //         //               Text(
                      //         //                 '${AppTags.years.tr} ${_currentRange.start}  -  ${AppTags.years.tr} ${_currentRange.end}',
                      //         //                 style: const TextStyle(
                      //         //                   fontSize: 20,
                      //         //                   color: Color(0xffC0B4CC),
                      //         //                 ),
                      //         //               ),
                      //         //               RangeSlider(
                      //         //                 activeColor: AppColors.pinkButton,
                      //         //                 values: _currentRange,
                      //         //                 min: 0,
                      //         //                 max: 100,
                      //         //                 onChanged: (newRange) {
                      //         //                   _currentRange = newRange;
                      //         //                 },
                      //         //               ),
                      //         //               // Slider(
                      //         //               //   value: _currentValue,
                      //         //               //   min: 0,
                      //         //               //   max: 100,
                      //         //               //   activeColor: AppColors.pinkButton,
                      //         //               //   onChanged: (newValue) {
                      //         //               //       _currentValue = newValue;
                      //         //               //   },
                      //         //               // ),
                      //         //             ],
                      //         //           ),
                      //         //         ),
                      //         //       ],
                      //         //     ),
                      //         //   ],
                      //         // ),
                      //         // const SizedBox(height: 20),
                      //         // InkWell(
                      //         //   onTap: () {
                      //         //     // for(var item in userController.userData.packagePermissions!) {
                      //         //     //   log(item.permissionName.toString());
                      //         //     // }
                      //         //   },
                      //         //   child: Container(
                      //         //     decoration: const BoxDecoration(
                      //         //       color: Color(0xff27B2CC),
                      //         //     ),
                      //         //     padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.h),
                      //         //     child: Text(
                      //         //       AppTags.search.tr,
                      //         //       style: const TextStyle(
                      //         //         color: Colors.white,
                      //         //         fontFamily: "poppins",
                      //         //         fontWeight: FontWeight.w500,
                      //         //       ),
                      //         //     ),
                      //         //   ),
                      //         // ),
                      //         // const SizedBox(height: 30),
                      //
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Something went wrong"),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      SplashController().handleConfigData();
                      navController.handleIndexChanged(0);
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

        },
      );
      }
    );
  }
}
