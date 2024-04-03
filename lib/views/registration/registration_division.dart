import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/views/Registration/wife_registration.dart';
import 'package:nybal/views/web_views/actionsBar.dart';
import 'package:nybal/views/web_views/footer.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../../Widgets/styles.dart';
import '../../controllers/language_controller.dart';
import '../../controllers/wife_reg_controller.dart';
import '../../Widgets/theme_data.dart';
import '../../widgets/custom_responsive.dart';
import '../../widgets/top_bar.dart';

class RegistrationDivision extends StatelessWidget {
  RegistrationDivision({super.key});
  var dropDownValue;
  double _currentValue = 25;
  RangeValues _currentRange = const RangeValues(20, 40);
  final LanguageController langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return CustomResponsive(
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
                child: FittedBox(
                  child: InkWell(
                    onTap: () => langController.updateLocale(lang.key),
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
      drawerWidget: const Drawer(),
      actionsWidget: <Widget>[
        ActionsBarWidget()
      ],
      actionsAlignment: MainAxisAlignment.end,
      bodyContent: GetBuilder<WifeRegistrationController>(builder: (WifeRegistrationController controller) {
          return SafeArea(
            child: Column(
              children: [
                if(ResponsiveWidget.isSmallScreen(context))
                  const TopBar(),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 20.w,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Registration Division',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "myFontLight",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF574667),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(
                                "I swear by God Almighty that I did not enter this site except for the purpose of legal marriage and not for any other purpose; And I pledge to God and I pledge to you that I will abide by the terms and conditions of the site , in the hope that my Lord will write good for me in this place.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFC0B4CC),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FittedBox(
                              child: Row(
                                children: [
                                  const FittedBox(
                                    child: Text(
                                      'I have taken the oath, and I will abide by it',
                                      style: TextStyle(
                                        color: Color(0xffC0B4CC),
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    activeColor: Colors.deepPurple,
                                    side: const BorderSide(color: AppColors.pinkButton),
                                    value: controller.iHaveTakenOath.value,
                                    onChanged: (value) {
                                      controller.isIHaveTakenOathUpdate(value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FittedBox(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.to(() => WifeRegistration());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: S.innerBoxShadow()
                              ),
                              padding: EdgeInsets.all(4.w),
                              child: Column(
                                  children:[
                                    Image.asset("assets/images/male.png"),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Wife Registration",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]
                              )
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: S.innerBoxShadow()
                            ),
                            padding: EdgeInsets.all(4.w),
                            child: Column(
                                children:[
                                  Image.asset("assets/images/female.png"),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Pair Registration",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ResponsiveWidget.isSmallScreen(context) ? Column(
                  children: [
                    Container(
                      height: 6.h,
                      width: 70.w,
                      decoration: const BoxDecoration(
                        color: Color(0xffE13F35),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign up with Google",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset("assets/images/google_g.png"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 6.h,
                      width: 70.w,
                      decoration: const BoxDecoration(
                        color: Color(0xff0777E8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign up with Facebook",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset("assets/images/facebook_f.png"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 6.h,
                      width: 70.w,
                      decoration: const BoxDecoration(
                        color: Color(0xff1D9BF0),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign up with Twitter",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset("assets/images/twitter.png")
                        ],
                      ),
                    ),
                  ],
                ): Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6.h,
                          decoration: const BoxDecoration(
                            color: Color(0xffE13F35),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sign up with Google",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Image.asset("assets/images/google_g.png"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 6.h,
                          decoration: const BoxDecoration(
                            color: Color(0xff0777E8),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sign up with Facebook",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Image.asset("assets/images/facebook_f.png"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 6.h,
                          decoration: const BoxDecoration(
                            color: Color(0xff1D9BF0),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sign up with Twitter",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Image.asset("assets/images/twitter.png")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
      footerContent: FooterView(),
      enableChatSupport: false,
    );
  }
}
