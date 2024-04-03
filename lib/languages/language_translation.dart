import 'package:get/get.dart';
import 'package:nybal/languages/espanol.dart';
import 'package:nybal/languages/swedish.dart';
import 'deutsch.dart';
import 'dutch.dart';
import 'english.dart';
import 'arabic.dart';
import 'french.dart';
import 'italian.dart';


class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'ar_SA': arSA,
    'fr_FR': frFR,
    'es_ES': esES,
    'de_DE': deDE,
    'it_IT': itIT,
    'sv_SE': svSE,
    'nl_NL': nlNL,
  };
}