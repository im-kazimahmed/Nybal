import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/home_screen_controller.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../../Widgets/theme_data.dart';
import '../Widgets/dialogs.dart';
import '../controllers/navigation_controller.dart';
import '../utils/app_tags.dart';
import '../widgets/top_bar.dart';

class FAQ extends StatelessWidget {
  FAQ({super.key});
  final NavigationController navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (HomeScreenController controller) {
      return SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                    InkWell(
                      onTap: () {
                        // faqController.fetchFaqList();
                      },
                      child: Text(
                        AppTags.faq.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "myFontLight",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF574667),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        AppTags.frequentlyAskedQuestions.tr,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFC0B4CC),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              Text(
                AppTags.frequentlyAskedQuestions.tr,
                style: TextStyle(
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 20: 8.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 50.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.pinkButton,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: ResponsiveWidget.isSmallScreen(context)? 20: 50),
              Expanded(
                child: FutureBuilder(
                  future: controller.fetchFaqList(),
                  builder: (context, snapshot) {
                    if(controller.faqsList.isEmpty && controller.isLoadingFromServer.isTrue) {
                      return const CustomLoader();
                    } else if(controller.faqsList.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? 20: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.faqsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 0.0: 15.w),
                            child: ExpansionTile(
                              title: Text(
                                controller.faqsList[index].question.toString(),
                                style: TextStyle(
                                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 12: null,
                                ),
                              ),
                              textColor: Colors.black,
                              collapsedTextColor: Colors.black,
                              trailing: const Icon(Icons.add, color: AppColors.pinkButton,),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    controller.faqsList[index].answer.toString(),
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ], // Icon for expansion
                            ),
                          );
                        }
                      );
                    } else {
                      return const Text("No faqs found");
                    }
                  }
                ),
              ),
              SizedBox(height: ResponsiveWidget.isSmallScreen(context)? 20: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? 30.0: 20.w),
                child: InkWell(
                  radius: 0,
                  onTap: () => navController.handleIndexChanged(7),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: ResponsiveWidget.isSmallScreen(context) ? 20 : 6.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: Colors.black, // Default text color
                      ),
                      children: [
                        TextSpan(
                          text: AppTags.notFoundTheAnswerThatYouWereLookingFor.tr,
                        ),
                        TextSpan(
                          text: AppTags.contactUs.tr,
                          style: const TextStyle(
                            color: Colors.pink, // Pink color
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 50.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: AppColors.pinkButton,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
    });
  }
}

