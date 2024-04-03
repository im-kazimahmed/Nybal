import 'dart:developer';
import 'dart:io' as io;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart';
import 'package:image/image.dart' as img;

bool changeTypeIntToBool(int value) {
  if (value == 1) {
    return true;
  } else {
    return false;
  }
}

String getPackageDuration(int number) {
  if (number == 30) {
    return "Monthly";
  } else if (number == 15) {
    return "Bi-monthly";
  } else if(number == 365){
    return "Yearly";
  } else {
    return "$number Days";
  }
}

int changeTypeBoolToInt(bool value) {
  if (value == true) {
    return 1;
  } else {
    return 0;
  }
}

double calculateHeight(int itemCount) {
  int numberOfColumns = 2;
  int numberOfRows = (itemCount / numberOfColumns).ceil();

  double totalRowHeight = numberOfRows * 70.0; // Assuming each item has 100.0 height
  double totalSpacingHeight = (numberOfRows - 1) * 10.0; // Assuming spacing between rows is 10.0

  return totalRowHeight + totalSpacingHeight;
}

Future<String> imageToBase64 ({required String filePath}) async {
  io.File imageFile = io.File(filePath);
  Uint8List imageBytes = await imageFile.readAsBytes();
  String base64string = base64.encode(imageBytes);
  // log("base 64 $base64string");
  return "data:image/jpeg;base64,$base64string";
}

Future<String> convertImageToBase64(String blobUrl) async {
  log("checking image url $blobUrl");
  // Load image from network
  final HttpClientRequest request = await HttpClient().getUrl(Uri.parse(blobUrl));
  final HttpClientResponse response = await request.close();
  final Uint8List bytes = await consolidateHttpClientResponseBytes(response);

  // Decode image
  final img.Image? image = img.decodeImage(Uint8List.fromList(bytes));

  // Encode image to JPEG
  final List<int> encodedBytes = img.encodeJpg(image!);

  // Convert to base64
  final String base64String = base64Encode(Uint8List.fromList(encodedBytes));

  return "data:image/jpeg;base64,$base64String";
}


