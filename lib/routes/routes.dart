import 'package:get/get.dart';
import 'package:nybal/views/Authentication/email_verification.dart';

// Project imports
import 'package:nybal/views/Members/online_members.dart';
import 'package:nybal/views/Members/search_members.dart';
import 'package:nybal/views/Authentication/sign_in.dart';
import 'package:nybal/views/blog.dart';
import 'package:nybal/views/contact_us.dart';
import 'package:nybal/views/dashboards/dashboard_without_login.dart';
import 'package:nybal/views/faq.dart';
import 'package:nybal/views/help.dart';
import 'package:nybal/views/Profile/myProfile.dart';
import '../bindings/splash_binding.dart';
import '../views/Authentication/sign_up.dart';
import '../views/Messages_page/messages_page.dart';
import '../views/Registration/wife_registration.dart';
import '../views/authentication/profile_update.dart';
import '../views/dashboards/dashboard.dart';
import '../views/splash_screen/splash_screen.dart';
import '../views/Members/new_members.dart';
import '../views/Profile/my_privileges.dart';
import '../views/Profile/notifications.dart';
import '../views/potential_matches.dart';
import '../views/Registration/registration_division.dart';
import '../views/profile/my_settings.dart';
import '../views/profile/referrals.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/call_model.dart';
import '../utils/constants.dart';


class Routes {
  static const String splashScreen = '/splashScreen';
  static const String dashboardScreenWoLogin = '/dashboardScreenWoLogin';
  static const String dashboardScreen = '/dashboardScreen';
  // static const String homeScreen = '/homeScreen';
  static const String signIn = '/signIn';
  static const String logIn = '/logIn';
  static const String signUp = '/signUp';
  static const String profileUpdate = '/profileUpdate';
  static const String emailVerification = '/emailVerification';
  static const String forgetPassword = '/forgetPassword';
  static const String potentialMatches = '/potentialMatches';
  static const String onlineMembers = '/onlineMembers';
  static const String newMembers = '/newMembers';
  static const String searchMembers = '/searchMembers';
  static const String wifeRegistration = '/wifeRegistration';
  static const String regDivision = '/regDivision';
  static const String faq = '/faq';
  static const String contactUs = '/contactUs';
  static const String blog = '/blog';
  static const String helpCenter = '/helpCenter';
  static const String myProfile = '/myProfile';
  static const String myPrivileges = '/myPrivileges';
  static const String myNotifications = '/myNotifications';
  static const String referrals = '/referrals';
  static const String internetCheckView = '/internetCheckView';
  static const String phoneRegistration = '/phoneRegistration';
  static const String phoneLoginScreen = '/phoneLoginScreen';
  static const String settings = '/settings';
  static const String changePassword = '/changePassword';
  static const String messagesPage = '/messagesPage';
  static const String callView = '/callView';
  static const String joinView = '/joinView';
  static const String callingView = '/callingView';

  static var list = [
    // GetPage(
    //   name: internetCheckView,
    //   page: () => const InternetCheckView(),
    // ),
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: dashboardScreenWoLogin,
      page: () =>  DashboardWithoutLogin(),
    ),
    GetPage(
      name: dashboardScreen,
      page: () => DashBoardScreen(),
    ),
    GetPage(
      name: signIn,
      page: () => SignIn(),
    ),
    GetPage(
      name: signUp,
      page: () => SignUp(),
    ),
    GetPage(
      name: emailVerification,
      page: () => EmailVerification(),
    ),
    GetPage(
      name: potentialMatches,
      page: () => PotentialMatches(),
    ),
    GetPage(
      name: onlineMembers,
      page: () => OnlineMembers(),
    ),
    GetPage(
      name: newMembers,
      page: () => NewMembers(),
    ),
    GetPage(
      name: searchMembers,
      page: () => SearchMembers(),
    ),
    GetPage(
      name: regDivision,
      page: () => RegistrationDivision(),
    ),
    GetPage(
      name: wifeRegistration,
      page: () => WifeRegistration(),
    ),
    GetPage(
      name: faq,
      page: () => FAQ(),
    ),
    GetPage(
      name: contactUs,
      page: () => ContactUs(),
    ),
    GetPage(
      name: blog,
      page: () => BLOG(),
    ),
    GetPage(
      name: helpCenter,
      page: () => HelpCenter(),
    ),
    GetPage(
      name: myProfile,
      page: () => MyProfile(),
    ),
    GetPage(
      name: myPrivileges,
      page: () => MyPrivileges(),
    ),
    GetPage(
      name: myNotifications,
      page: () => NotificationsScreen(),
    ),
    GetPage(
      name: referrals,
      page: () => Referrals(),
    ),
    GetPage(
      name: settings,
      page: () => MySettings(),
    ),
    GetPage(
      name: profileUpdate,
      page: () => ProfileUpdateScreen(),
    ),
    GetPage(
      name: messagesPage,
      page: () => MessagesPage(),
    ),
    // GetPage(
    //   name: callView,
    //   page: () => CallView(),
    // ),
    // GetPage(
    //   name: callView,
    //   page: () => JoinView(),
    // ),
    // GetPage(
    //   name: callingView,
    //   page: () => CallingView(),
    // ),

    // GetPage(
    //   name: signUp,
    //   page: () => SignupScreen(),
    // ),

    // GetPage(
    //   name: forgetPassword,
    //   page: () => ForgetPasswordScreen(),
    // ),
  ];
}


// class AppRouter {
//   Route? onGenerateRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case loginScreen:
//         return MaterialPageRoute(
//           builder: (_) {
//             return const AuthScreen();
//           },
//         );
//       case homeScreen:
//         return MaterialPageRoute(
//           builder: (_) {
//             return const HomeScreen();
//           },
//         );
//
//
//       case callScreen:
//         List<dynamic> args = routeSettings.arguments as List<dynamic>;
//         final isReceiver = args[0] as bool;
//         final callModel = args[1] as CallModel;
//         return MaterialPageRoute(
//           builder: (_) {
//             return BlocProvider(create: (_) => CallCubit(),
//                 child: CallScreen(isReceiver: isReceiver,callModel: callModel));
//           },
//         );
//
//
//     }
//   }
// }

