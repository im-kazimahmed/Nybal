import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart' as notification_channel;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/firebase_options.dart';
import 'package:nybal/routes/routes.dart';
import 'package:nybal/Widgets/screen_utils.dart';
import 'package:nybal/utils/dio_helper.dart';
import 'package:nybal/utils/network/cache_helper.dart';
import 'package:nybal/widgets/theme_data.dart';
import 'package:sizer/sizer.dart';
import 'bindings/init_bindings.dart';
import 'controllers/auth_controller.dart';
import 'controllers/language_controller.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/user_controller.dart';
import 'helpers/data_storage_service.dart';
import 'languages/language_translation.dart';

// Future<void> backgroundHandler(RemoteMessage message) async {
//   String? title = message.notification?.title;
//   String? body = message.notification?.body;
//   if(message.data.isNotEmpty) {
//     log("checking notification ${message.data}");
//     String? channelId = message.data['channel_id'];
//     String? agoraUid = message.data['agora_uid'];
//     String? isVideoCall = message.data['is_video_call'];
//     LocalDataHelper().saveIncomingAgoraChannelId(channelId, agoraUid, isVideoCall);
//   }
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 123,
//       channelKey: 'call_channel',
//       color: Colors.white,
//       title: title,
//       body: body,
//       category: NotificationCategory.Call,
//       wakeUpScreen: true,
//       fullScreenIntent: true,
//       autoDismissible: false,
//       backgroundColor: AppColors.pinkButton,
//     ),
//     actionButtons: [
//       NotificationActionButton(
//         key: "Accept",
//         label: "Accept Call",
//         color: Colors.green,
//         autoDismissible: true,
//       ),
//       NotificationActionButton(
//         key: "Reject",
//         label: "Reject Call",
//         color: Colors.red,
//         autoDismissible: true,
//       ),
//     ],
//   );
//
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialConfig();
  await CacheHelper.init();
  await GetStorage.init();
  DioHelper.init();
  if(!kIsWeb) {
    var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'nybal',
      importance: notification_channel.NotificationImportance.IMPORTANCE_HIGH,
      name: 'nybal',
    );
    log('\nNotification Channel Result: $result');
  }

  // AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //     channelKey: 'call_channel',
  //     channelName: 'Call Channel',
  //     channelDescription: 'channel for calling',
  //     defaultColor: AppColors.pinkButton,
  //     ledColor: Colors.white,
  //     importance: NotificationImportance.Max,
  //     channelShowBadge: true,
  //     locked: true,
  //     defaultRingtoneType: DefaultRingtoneType.Ringtone,
  //   )
  // ]);
  // AwesomeNotifications().setListeners(
  //   onActionReceivedMethod: (ReceivedAction receivedAction){
  //     return NotificationController.onActionReceivedMethod(receivedAction);
  //   },
  //   onNotificationCreatedMethod: (ReceivedNotification receivedNotification){
  //     return NotificationController.onNotificationCreatedMethod(receivedNotification);
  //   },
  //   onNotificationDisplayedMethod: (ReceivedNotification receivedNotification){
  //     return NotificationController.onNotificationDisplayedMethod(receivedNotification);
  //   },
  //   onDismissActionReceivedMethod: (ReceivedAction receivedAction){
  //     return NotificationController.onDismissActionReceivedMethod(receivedAction);
  //   },
  // );

  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
    // BlocOverrides.runZoned(() => runApp(MyApp(appRouter: AppRouter(),)),blocObserver: AppBlocObserver());
    // runApp(MaterialApp(home: SocketApp2()));
    // runApp(SocketWithTyping());
    // runApp(MySocketApp());
  });
}

Future<void> initialConfig() async {
  await Get.putAsync(() => StorageService().init());
}

class MyApp extends StatefulWidget {
  // final AppRouter appRouter;
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final langController = Get.put(LanguageController());
  final authController = Get.put(AuthController());
  final settingController = Get.put(SettingController());
  final userController = Get.put(UserController());
  final navCtrl = Get.put(NavigationController());
  final storage = Get.put(StorageService());
  final theme = Get.put(ThemeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("checking notification ${message.data}");
      // backgroundHandler(message);
      //Handle FCM background
      // FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return GetBuilder<ThemeController>(builder: (ThemeController controller) {
      return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            // onGenerateRoute: widget.appRouter.onGenerateRoute,
            locale: storage.languageCode != null ?
            Locale(storage.languageCode!, storage.countryCode):
            const Locale('en', 'US'),
            initialBinding: InitBindings(),
            translations: AppTranslations(),
            fallbackLocale: const Locale('en', 'US'),
            title: "Nybal",
            debugShowCheckedModeBanner: false,
            getPages: Routes.list,
            initialRoute: Routes.splashScreen,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: AppColors.whiteColor,
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: AppColors.darkColor,
            ),
            themeMode: controller.isDarkMode.isTrue ? ThemeMode.dark: ThemeMode.light,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown,
                PointerDeviceKind.trackpad,
              },
            ),
          );
        },
      );
    });
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (_) => AuthCubit()..getUserData(uId: CacheHelper.getString(key: 'uId')),
    //     ),
    //     BlocProvider(
    //       create: (_) => HomeCubit()..listenToInComingCalls()..getUsersRealTime()..getCallHistoryRealTime()..initFcm(context)..updateFcmToken(uId:  CacheHelper.getString(key: 'uId')),
    //     ),
    //   ],
    //   child: GetBuilder<ThemeController>(builder: (ThemeController controller) {
    //     return Sizer(
    //       builder: (context, orientation, deviceType) {
    //         return GetMaterialApp(
    //           onGenerateRoute: widget.appRouter.onGenerateRoute,
    //           locale: storage.languageCode != null ?
    //           Locale(storage.languageCode!, storage.countryCode):
    //           const Locale('en', 'US'),
    //           initialBinding: InitBindings(),
    //           translations: AppTranslations(),
    //           fallbackLocale: const Locale('en', 'US'),
    //           title: "Nybal",
    //           debugShowCheckedModeBanner: false,
    //           getPages: Routes.list,
    //           initialRoute: Routes.splashScreen,
    //           theme: ThemeData.light().copyWith(
    //             scaffoldBackgroundColor: AppColors.whiteColor,
    //           ),
    //           darkTheme: ThemeData.dark().copyWith(
    //             scaffoldBackgroundColor: AppColors.darkColor,
    //           ),
    //           themeMode: controller.isDarkMode.isTrue ? ThemeMode.dark: ThemeMode.light,
    //           scrollBehavior: const MaterialScrollBehavior().copyWith(
    //             dragDevices: {
    //               PointerDeviceKind.mouse,
    //               PointerDeviceKind.touch,
    //               PointerDeviceKind.stylus,
    //               PointerDeviceKind.unknown,
    //               PointerDeviceKind.trackpad,
    //             },
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // );
  }
}

// Future<void> _backgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   await CacheHelper.init();
//   if (message.data['type'] == 'call') {
//     Map<String, dynamic> bodyMap = jsonDecode(message.data['body']);
//     await CacheHelper.saveData(key: 'terminateIncomingCallData',value: jsonEncode(bodyMap));
//   }
//   FirebaseNotifications.showNotification(title: message.data['title'],body: message.data['body'],type: message.data['type']);
//
// }

