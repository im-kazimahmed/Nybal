import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/controllers/support_controller.dart';
import 'package:nybal/controllers/theme_controller.dart';
import 'package:nybal/models/ticket_model.dart';
import 'package:nybal/widgets/responsive_widget.dart';
import 'package:nybal/widgets/top_bar.dart';
import '../../widgets/dialogs.dart';
import 'ticket_item_view.dart';

class TicketsHome extends StatelessWidget {
  TicketsHome({super.key});
  final navController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (ThemeController themeController) {
        return GetBuilder<SupportSystemController>(builder: (SupportSystemController controller) {
          return WillPopScope(
            onWillPop: () async {
              navController.handleNavIndexChanged(1);
              return false;
            },
            child: SafeArea(
              child: SizedBox(
                height: Get.height,
                child: Column(
                  children: [
                    if(ResponsiveWidget.isSmallScreen(context))
                      const TopBar(),
                    const SizedBox(height: 10),
                    Text(
                      'Support Ticket',
                      style: TextStyle(
                        fontSize: ResponsiveWidget.isSmallScreen(context) ? 18: 20,
                        fontFamily: "myFontLight",
                        fontWeight: FontWeight.bold,
                        color: themeController.isDarkMode.isTrue ?
                        Colors.white: const Color(0xFF574667),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Stack(
                        children: [
                          FutureBuilder(
                            future: controller.getTickets(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CustomLoader();
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else {
                                List<TicketModel>? tickets = snapshot.data;
                                if(tickets != null && tickets.isNotEmpty) {
                                  return ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: tickets.length,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(top: 0.0),
                                        child: TicketView(
                                          ticket: tickets[index],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      "No tickets found",
                                      style: TextStyle(
                                        color: themeController.isDarkMode.isTrue ?
                                        Colors.white: null,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                navController.previousIndex.value = navController.selectedNavIndex;
                                navController.handleNavIndexChanged(26);
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("New Ticket"),
                              backgroundColor: const Color(0xff27B2CC),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          }
        );
      }
    );
  }
}
