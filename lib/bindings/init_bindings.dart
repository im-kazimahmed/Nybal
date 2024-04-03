import 'package:get/get.dart';
import 'package:nybal/controllers/chat_controller.dart';
import 'package:nybal/controllers/language_controller.dart';
import 'package:nybal/controllers/navigation_controller.dart';
import 'package:nybal/controllers/pagination_controller.dart';
import 'package:nybal/controllers/payment_controller.dart';
import 'package:nybal/controllers/support_controller.dart';
import 'package:nybal/controllers/wife_reg_controller.dart';
import '../controllers/disable_profile_controller.dart';
import '../controllers/home_screen_controller.dart';
import '../controllers/potential_matches_ctr.dart';
import '../controllers/update_profile_controller.dart';

class InitBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<LanguageController>(LanguageController());
    Get.put<UpdateProfileController>(UpdateProfileController());
    Get.put<NavigationController>(NavigationController());
    Get.put<PotentialMatchesCTR>(PotentialMatchesCTR());
    Get.put<WifeRegistrationController>(WifeRegistrationController());
    Get.put<ChatController>(ChatController());
    Get.lazyPut(() => HomeScreenController());
    Get.put<PaymentController>(PaymentController());
    Get.put<PaginationController>(PaginationController());
    Get.put<SupportSystemController>(SupportSystemController());
    Get.put<DisableProfileController>(DisableProfileController());


    // Get.put<AuthService>(AuthService());
    // Get.put<StartChannelController>(StartChannelController());
    // Get.put<JoinChannelController>(JoinChannelController());
    // Get.put<ChannelController>(ChannelController());
  }
}
