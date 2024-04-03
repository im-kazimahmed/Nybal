import 'package:get/get.dart';

class PaginationController extends GetxController {
  final int itemsPerPage = 10;
  final RxInt currentPage = 1.obs;
  List helpCenterData = [
    {
      "Register and activate membership": [
        "How do I register on the site?",
        "I am not a Muslim, and there is no option in the field of religion but a Muslim?",
        "What are the cases in which the registration request is repeated to amend my data therein?",
        "What are the cases in which the application for registration is rejected?",
      ],
    },
    {
      "Messaging and internal messaging": [
        "Are messages between members monitored by moderators?",
        "Can I recover deleted messages?",
        "How do I message a member?",
        "How do I read the messages that I receive?",
      ],
    },
  ];

  List get currentPageData =>
      helpCenterData.sublist((currentPage.value - 1) * itemsPerPage,
          currentPage.value * itemsPerPage);

  void nextPage() {
    if (currentPage.value * itemsPerPage < helpCenterData.length) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }
}
