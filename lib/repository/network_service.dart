import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nybal/config/app_config.dart';
import 'package:nybal/utils/validators.dart';
import 'api_exception.dart';

class NetworkService {
  static String apiUrl = AppConfig.baseUrl;

  Future fetchJsonData(String url) {
    return _getData(url);
  }

  Future<dynamic> _getData(String url) async {
    dynamic responseJson;
    try {
      // var headers = {"apiKey": AppConfig.apiKey};
      final response = await http.get(
        Uri.parse(url),
          // headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      showShortToast("No internet connection!");
      throw FetchDataException("No internet connection!");
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        showShortToast("could not connect to the server : ${response.statusCode}'");
        throw FetchDataException(
            'could not connect to the server : ${response.statusCode}');
    }
  }
}
