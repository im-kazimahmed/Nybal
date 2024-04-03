import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/images.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/controllers/user_controller.dart';
import 'package:nybal/helpers/local_data_helper.dart';
import '../Widgets/responsive_widget.dart';
import '../Widgets/screen_utils.dart';
import '../main.dart';

class CustomResponsive extends StatelessWidget {
  final List<Widget> actionsWidget;
  final List<Widget> topNavigation;
  final Widget? drawerWidget;
  final Widget bodyContent;
  final Widget footerContent;
  final bool enableChatSupport;
  final MainAxisAlignment topNavigationAlignment;
  final MainAxisAlignment actionsAlignment;
  final Widget? mobileBottomNavBar;
  final controller = Get.find<NavigationController>();
  final userController = Get.find<UserController>();
  final themeController = Get.find<ThemeController>();

  CustomResponsive(
    {
      super.key,
      required this.actionsWidget,
      required this.actionsAlignment,
      this.drawerWidget,
      required this.topNavigation,
      required this.topNavigationAlignment,
      required this.footerContent,
      required this.bodyContent,
      required this.enableChatSupport,
      this.mobileBottomNavBar,
    });

  @override
  Widget build(BuildContext context) {
    int? index = controller.selectedNavIndex;
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GestureDetector(
          onTap: () {
            userController.clearAll();
          },
          child: Material(
            color: themeController.isDarkMode.isTrue ?
            ThemeData.dark().scaffoldBackgroundColor:
            const Color(0xFFF7F8FA),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              endDrawer: drawerWidget != null && ResponsiveWidget.isSmallScreen(context) ?
              drawerWidget: null,
              body: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight,
                    ),
                    child: ResponsiveWidget(
                      largeScreen: _buildLargeScreen(context),
                      mediumScreen: _buildMediumScreen(context),
                      smallScreen: _buildSmallScreen(context),
                    ),
                  ),
                );
              }),
              bottomNavigationBar: ResponsiveWidget.isSmallScreen(context) ? mobileBottomNavBar: null,
              floatingActionButton: enableChatSupport && index != 25 && index != 26 ? ResponsiveWidget.isSmallScreen(context) ?
              FloatingActionButton(
                onPressed: () {
                  controller.previousIndex.value = controller.selectedNavIndex;
                  controller.handleNavIndexChanged(25);
                },
                child: Image.asset(Images.support),
              ):
              null: null,
              floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            ),
          ),
        );
      }
    );
  }

  // List<Widget> _buildActions() {
  //   return ;
  // }

  Widget _buildLargeScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: topNavigationAlignment,
            children: topNavigation,
          ),
          Row(
            mainAxisAlignment: actionsAlignment,
            children: actionsWidget,
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                GetBuilder<NavigationController>(builder: (NavigationController controller) {
                  if(controller.selectedIndex.value == 0) {
                    return Obx(() {
                      return Image.asset(
                        "assets/images/Circle.png",
                        height: Get.height / 1.4,
                        width: Get.width,
                        fit: BoxFit.cover,
                        color: themeController.isDarkMode.isTrue ?
                        ThemeData.dark().scaffoldBackgroundColor: null,
                      );
                    });
                  } else {
                    return Container();
                  }
                }),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (ScreenUtil.getInstance().setWidth(108)),
                  ),
                  child: _buildContent(context),
                ),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (ScreenUtil.getInstance().setWidth(108)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(flex: 1, child: _buildContent(context)),
                ],
              ),
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(flex: 1, child: Stack(
            children: [
              GetBuilder<NavigationController>(builder: (NavigationController controller) {
                if(LocalDataHelper().getUserToken() != null && controller.selectedNavIndex == 0) {
                  return Obx(() {
                    return Image.asset(
                      "assets/images/Circle.png",
                      height: Get.height / 1.4,
                      width: Get.width,
                      fit: BoxFit.cover,
                      color: themeController.isDarkMode.isTrue ?
                      ThemeData.dark().scaffoldBackgroundColor: null,
                    );
                  });
                } else if(LocalDataHelper().getUserToken() == null && controller.selectedIndex.value == 0) {
                  return Obx(() {
                    return Image.asset(
                      "assets/images/Circle.png",
                      height: Get.height / 1.4,
                      width: Get.width,
                      fit: BoxFit.cover,
                      color: themeController.isDarkMode.isTrue ?
                      ThemeData.dark().scaffoldBackgroundColor: null,
                    );
                  });
                } else {
                  return Container();
                }
              }),
              _buildContent(context),
            ],
          )),
          const Divider(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return bodyContent;
  }

  // Footer Methods:------------------------------------------------------------
  Widget _buildFooter(BuildContext context) {
    return footerContent;
  }

}