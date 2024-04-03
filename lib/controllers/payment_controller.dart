// import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../repository/repository.dart';

class PaymentController extends GetxController {
  final controller = CardEditController();
  RxList userCards = [].obs;
  // var getContext;
  RxString amount = RxString("Amount : \$5.00");
  RxString customerId = RxString('');
  RxString cardNumber = RxString('');
  RxString expiryDate = RxString('');
  RxString cardHolderName = RxString('');
  RxString cvvCode = RxString('');
  RxBool isCvvFocused = RxBool(false);
  RxBool useGlassMorphism = RxBool(false);
  RxBool useBackgroundImage = RxBool(false);
  // Dio dio = Dio();

  RxBool isProcessing = RxBool(false);
  String stripePublicKey =
      "pk_test_51NtUueA3t3t6UrqOkHBbSPjC0zCv4CdPUFKbMbCvF4mgDcT0gJ8fK6TTJvEUTkmIAjElEH25MpcckQQffxDV8lYV00YM1tf66o";
  String stripePvtKey =
      "sk_test_51NtUueA3t3t6UrqOkHB8nLb2XTV3FfsdJXYRpHieID4BtP9JpCtTo5fLHOTMb6tHuQVIcJZL15AKbPlOkPNhDMxe00HGOGfrge";


  Future<String?> createCustomer({
    required String name,
    required String email,
  }) async {
    try {
      isProcessing(true);
      var data = await Repository().createStripeCustomer(
        stripePrivateKey: stripePvtKey,
        name: name,
        email: email,
      );
      if (data != null) {
        customerId(data);
        update();
        return data;
      }
    } catch (e) {
      log("Failed to create stripe customer $e");
      return null;
    } finally {
      update();
      isProcessing(false);
    }
    return null;
  }

  Future<bool> createPaymentIntent({
    ctx,
    required int amount,
  }) async {
    // getContext = ctx;
    isProcessing(true);
    update();
    try {
      var url = Uri.parse("https://api.stripe.com/v1/payment_intents");
      var response = await http.post(url,
        body: {
          'amount': amount.toString(),
          'currency': 'USD',
          'payment_method_types[]': 'card'
        },
        headers: {
          'Authorization': 'Bearer $stripePvtKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );
      var data = json.decode(response.body);

      if(response.statusCode != 200) {
        // String id = data['id'];
        // String secret = data['client_secret'];
        // Object paymentIntent = data['payment_intent'];
        // print("payment intent: $paymentIntent");
        // return await initThePaymentSheet(paymentIntent: data);
        // initThePaymentSheet(clientSecret: secret, customerId: id);
        // print(data);
        // print("here");
        // print(data['client_secret']);
        return false;
      } else{
        return await initThePaymentSheet(paymentIntent: data);
      }
    } catch (err) {
      isProcessing(false);
      update();
      debugPrint('error ${err.toString()}');
      return false;
    }
  }

  Future<bool> initThePaymentSheet({required Map<String, dynamic> paymentIntent}) async {
    try {
      Stripe.publishableKey = stripePublicKey;
      Stripe.merchantIdentifier = 'Nybal';
      await Stripe.instance.applySettings();
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customerId: customerId.value,
          paymentIntentClientSecret: paymentIntent['client_secret'],
          customerEphemeralKeySecret: paymentIntent['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Nybal',
        ),
      );
      return await displayPaymentSheet();
    } catch (e, s) {
      isProcessing(false);
      update();
      debugPrint('exception in initPaymentSheet method:$e$s');
      return false;
    }
  }

  Future<bool> initTheSetupSheet({required Map<String, dynamic> setupIntent}) async {
    try {
      Stripe.publishableKey = stripePublicKey;
      Stripe.merchantIdentifier = 'PixieDust';
      await Stripe.instance.applySettings();
      PaymentSheetPaymentOption? options = await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customerId: customerId.value,
          setupIntentClientSecret: setupIntent['client_secret'],
          // customerEphemeralKeySecret: paymentIntent[''],
          style: ThemeMode.light,
          merchantDisplayName: 'PixieDust',
        ),
      );
      return await displayPaymentSheet();
    } catch (e, s) {
      isProcessing(false);
      update();
      debugPrint('exception in initPaymentSheet method:$e$s');
      return false;
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      isProcessing(false);
      update();
      // Get.
      // ScaffoldMessenger.of(getContext)
      //     .showSnackBar(const SnackBar(content: Text("paid successfully")));
      amount.value = "Amount Paid";
      update();
      return true;
    } on StripeException catch (e) {
      isProcessing(false);
      update();
      // debugPrint(
      //     ' on StripeException: Exception in displaying payment sheet  ${e.toString()}');
      // ScaffoldMessenger.of(getContext)
      //     .showSnackBar(SnackBar(content: Text(e.error.message.toString())));
      return false;
    } catch (e) {
      isProcessing(false);
      update();
      debugPrint(
          'Exception in displaying payment sheet in general catch ${e.toString()}');
      return false;
    }
  }

  addPaymentMethod() {
    Get.defaultDialog(
      content: Container(
        height: Get.height / 2,
        width: Get.width,
        color: Colors.white,
        child: CardField(
          controller: controller,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          onCardChanged: (card) {
            print(card);
          },
        ),
      ),
    );
  }

  PaymentIntentsStatus stringToPaymentStatus(String value) {
    switch (value) {
      case 'requires_payment_method':
        return PaymentIntentsStatus.RequiresPaymentMethod;
      default:
        throw ArgumentError('Invalid payment status string: $value');
    }
  }



  storeUserCard(String number, String expiry, String cvv, String name) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cards')
        .add({'name': name, 'number': number, 'cvv': cvv, 'expiry': expiry});

    return true;
  }

  getUserCards() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection('cards')
        .snapshots().listen((event) {
      userCards.value = event.docs;
    });
  }



}