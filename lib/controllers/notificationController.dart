import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/routes/routes.dart';
import '../utils/utility.dart';

class NotificationController {
  final NavigationController navController = Get.find<NavigationController>();
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {

  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    String? actionKey = receivedAction.buttonKeyPressed;
    int? notificationId = receivedAction.id;
    if (actionKey == "Accept") {
      // Handle Accept action
      log("User pressed Accept for notification $notificationId");
      AppUtility.readChannelDataFromLocalStorage();
      Get.toNamed(Routes.callView);
    } else if (actionKey == "Reject") {
      // Handle Reject action
      log("User pressed Reject for notification $notificationId");
    }
    // Your code goes here
    // // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}