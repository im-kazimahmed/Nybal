import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/views/web_views/actionsBar.dart';
import 'package:nybal/views/web_views/footer.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/responsive_widget.dart';
import '../../controllers/wife_reg_controller.dart';
import '../../Widgets/theme_data.dart';
import '../controllers/language_controller.dart';
import '../controllers/pagination_controller.dart';
import '../utils/app_tags.dart';
import '../widgets/custom_responsive.dart';
import '../widgets/top_bar.dart';

class BLOG extends StatelessWidget {
  BLOG({super.key});
  final PaginationController paginationController =
  Get.put(PaginationController());
  final LanguageController langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 20.w,
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppTags.helpCenter.tr,
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
                          AppTags.typeInTheSearchBoxWhatYouWant.tr,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 20.w),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: AppTags.search.tr,
                      hintStyle: const TextStyle(
                        color: Color(0xffC0B4CC),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      labelStyle: const TextStyle(fontSize: 12),
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey[50]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey[50]!),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveWidget.isSmallScreen(context)? 20: 50),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1.5,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: paginationController.helpCenterData.length,
                          itemBuilder: (context, sectionIndex) {
                            final sectionData = paginationController.helpCenterData[sectionIndex];
                            final sectionTitle = sectionData.keys.first;
                            final sectionQuestions = sectionData[sectionTitle] as List<String>;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Section title
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                                      child: Text(
                                        sectionTitle,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Section questions
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: sectionQuestions.map((question) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0: 10.w, vertical: 10.0),
                                          child: Container(
                                            width: size.width,
                                            decoration: const BoxDecoration(
                                              color: Color(0xffF4F4F4)
                                            ),
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              question,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: paginationController.previousPage,
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.pinkButton,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              for (int i = 1;
                              i <=
                                  (paginationController.helpCenterData.length /
                                      paginationController.itemsPerPage)
                                      .ceil();
                              i++)
                                GestureDetector(
                                  onTap: () {
                                    paginationController.currentPage.value = i;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: paginationController.currentPage.value == i ? Border.all(color: AppColors.pinkButton): null,
                                    ),
                                    child: Text(
                                      i.toString(),
                                      style: TextStyle(
                                        color: paginationController.currentPage.value == i
                                            ? AppColors.pinkButton
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: paginationController.nextPage,
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.pinkButton,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          );
        }
      ),
      footerContent: FooterView(),
      enableChatSupport: true,
    );
  }
}
