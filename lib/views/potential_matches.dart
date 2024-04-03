import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../Widgets/responsive_widget.dart';
import '../controllers/language_controller.dart';
import '../controllers/potential_matches_ctr.dart';
import '../Widgets/theme_data.dart';
import '../helpers/data.dart';
import '../utils/app_tags.dart';
import '../widgets/top_bar.dart';
import 'filter_page/filters.dart';

class PotentialMatches extends StatelessWidget {
  PotentialMatches({super.key});
  final controller = Get.find<PotentialMatchesCTR>();
  final LanguageController langController = Get.find<LanguageController>();
  var dropDownValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          if(ResponsiveWidget.isSmallScreen(context))
            const TopBar(),
          const SizedBox(height: 10),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: Get.height / 15,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // width: Get.width,
                      color: const Color(0xFFF4F4F4),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton(
                              // padding: EdgeInsets.only(left: 25, right: 25),
                              underline: const Text(""),
                              style: const TextStyle(textBaseline: null, color: Colors.black),
                              menuMaxHeight: Get.height / 2,
                              hint: Text(AppTags.allCountriesHint.tr),
                              alignment: Alignment.centerLeft,
                              isExpanded: true,
                              // Initial Value
                              value: dropDownValue,
                              // Down Arrow Icon
                              icon: const Expanded(child: Icon(Icons.keyboard_arrow_down)),
                              iconSize: 20,
                              // Array list of items
                              items: countries.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                dropDownValue = newValue;
                              },
                            ),
                          ),
                          if(ResponsiveWidget.isSmallScreen(context))
                             GestureDetector(
                              onTap: () {
                                Get.to(() => const Filters_page());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: Get.height / 15,
                                width: Get.width / 7,
                                color: const Color(0xFFF4F4F4),
                                child: const Image(
                                  image: AssetImage("assets/images/filter.png"),
                                ),
                              ),
                            )
                          else
                            Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.pinkButton,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                                    child: Text(
                                      AppTags.female.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.pinkButton),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                                    child: Text(
                                      AppTags.male.tr,
                                      style: const TextStyle(
                                        color: AppColors.pinkButton,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.pinkButton),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.h),
                                    child: Text(
                                      AppTags.all.tr,
                                      style: const TextStyle(
                                        color: AppColors.pinkButton,
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
          SizedBox(
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
                    mainAxisSpacing: 10),
                itemCount: 5,
                itemBuilder: (BuildContext ctx, index) {
                  return FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        // Get.to(()=> ProfileViewPage());
                        // controller.isProfileViewf(true);
                      },
                      child: Card(
                        elevation: 7.0,
                        shadowColor: const Color.fromARGB(255, 224, 224, 224),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // margin: EdgeInsets.all(5),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //     width: 1, color: Color(0xFF000000)),
                              // color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
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
                                        style: const TextStyle(
                                          fontSize: 07,
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
                                            "assets/images/chat-heart.svg"),
                                      )
                                    ],
                                  ),
                                ),
                                const Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          "assets/images/profile.png"),
                                    ),
                                    Positioned(
                                      bottom: -09,
                                      right: -09,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xFFffb800),
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/premium.png"),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      width: 20,
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/flag.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 08),
                                    Text(
                                      'Buchra',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "myFontLight",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF574667)),
                                    ),
                                    SizedBox(width: 08),
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    )
                                  ],
                                ),
                                Text(
                                  '23 ${AppTags.yearsOldFrom.tr} Morocco',
                                  style: const TextStyle(
                                    fontSize: 07,
                                    fontFamily: "myFontLight",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF27B2CC),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(AppTags.single.tr),
                                    const SizedBox(width: 05),
                                    const Stack(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image(
                                            image: AssetImage(
                                              "assets/images/heart_bg.png",
                                            ),
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
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                      width: 20,
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/flag.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 08),
                                    const Text(
                                      'El Jadida / Morocco',
                                      style: TextStyle(
                                          fontSize: 07,
                                          fontFamily: "myFontLight",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF574667)),
                                    ),
                                    const SizedBox(width: 08),
                                    Stack(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Image(
                                            image: AssetImage(
                                              "assets/images/heart_bg.png",
                                            ),
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
                                                  FontWeight.bold),
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
                                      style: const TextStyle(
                                        fontSize: 07,
                                        decoration:
                                        TextDecoration.underline,
                                        fontFamily: "myFontLight",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF574667),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
                }),

          ),
        ],
      ),
    );
  }
}
