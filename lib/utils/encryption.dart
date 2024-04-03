
import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class EncryptData{
  //for AES Algorithms
  static Encrypted? encrypted;
  static var decrypted;


  // static encryptAES(plainText){
  //   final key = Key.fromUtf8('\$2y\$10\$BUw26QyNxUHYxYrzCUUP1uWpK0orwtqZcK.mY0vKBfwI2GW/5lF9S');
  //   final iv = IV.fromLength(16);
  //   final encrypter = Encrypter(AES(key));
  //   encrypted = encrypter.encrypt(plainText, iv: iv);
  //   print(encrypted!.base64);
  // }
  //
  // static decryptAES(plainText){
  //   final key = Key.fromUtf8('\$2y\$10\$BUw26QyNxUHYxYrzCUUP1uWpK0orwtqZcK.mY0vKBfwI2GW/5lF9S');
  //   final iv = IV.fromLength(16);
  //   final encrypter = Encrypter(AES(key));
  //   decrypted = encrypter.decrypt(encrypted!, iv: iv);
  //   print(decrypted);
  // }
  //
  // static String decryptApiKeys(String encryptedText) {
  //   const String secretKey = "thisismypassword";
  //   const String iv = "1234567890123456";
  //
  //   final key = Key.fromUtf8(secretKey);
  //   final ivBytes = IV.fromUtf8(iv);
  //
  //   final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  //
  //   try {
  //     final decrypted = encrypter.decrypt64(encryptedText, iv: ivBytes);
  //     return decrypted;
  //   } catch (e) {
  //     print("Error decrypting: $e");
  //     return "";
  //   }
  // }

  static String encrypt(String text) {
    final key = Key.fromUtf8('MySecretKeyForEncryptionAndDecry'); //32 chars
    final iv = IV.fromUtf8('helloworldhellow'); //16 chars

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  static String decrypt(String text) {
    final key = Key.fromUtf8('MySecretKeyForEncryptionAndDecry'); //32 chars
    final iv = IV.fromUtf8('helloworldhellow'); //16 chars

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);
    return decrypted;
  }
}