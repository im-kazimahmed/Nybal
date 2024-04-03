import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nybal/Widgets/dialogs.dart';
import 'package:nybal/config/app_config.dart';
import 'package:nybal/controllers/setting_controller.dart';
import 'package:nybal/utils/validators.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:http/http.dart' as http;
import '../helpers/local_data_helper.dart';
import '../models/firebase_user_model.dart';
import '../repository/repository.dart';
import '../routes/routes.dart';
import '../socket/socket.io.dart';
import '../views/landing_pages/welcome_page.dart';

class AuthController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FirebaseUserModel currentUser;
  RxString googleConsoleAndroidApiKey = RxString("");
  RxString googleConsoleIosApiKey = RxString("");
  RxString googleConsoleWebApiKey = RxString("");
  RxBool enableEmailVerification = RxBool(true);

  final List<String> scopes = <String>[
    "https://www.googleapis.com/auth/user.gender.read",
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email"
  ];

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static const userCollection = 'Users';
  static const callsCollection = 'Calls';
  static const tokensCollection = 'Tokens';

  // late Rx<GoogleSignInAccount?> googleSignInAccount;
  static AuthController authInstance =
      Get.put(AuthController(), permanent: true);
  final box = GetStorage();

  final _isLoggingIn = false.obs;
  bool get isLoggingIn => _isLoggingIn.value;

  //login screen
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = RxBool(true);
  RxBool isRememberValue = LocalDataHelper().getRememberPass() != null ? RxBool(true) : RxBool(false);
  RxBool isIncognito = RxBool(false);
  RxBool isLoading = RxBool(false);

  isIncognitoUpdate(value){
    isIncognito.value = value!;
  }

  isRememberValueUpdate(value){
    isRememberValue.value = value!;
  }
  isPasswordVisibleUpdate() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  //SignUp Screen
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameControllerSignup = TextEditingController();
  TextEditingController emailControllerSignup = TextEditingController();
  TextEditingController passwordControllerSignup = TextEditingController();
  TextEditingController referredByControllerSignup = TextEditingController();
  RxBool passwordVisibleSignup = RxBool(false);
  RxBool termsAndConditions = RxBool(false);
  RxString selectedGender = RxString("Male");

  // OTP Verification Screen
  TextEditingController otpController = TextEditingController();
  RxBool isVerifyLater = RxBool(false);

  isVisiblePasswordUpdate(){
    passwordVisibleSignup.value = !passwordVisibleSignup.value;
  }
  
  isTermsAndConditionsUpdate(){
    termsAndConditions.value = !termsAndConditions.value;
  }

  @override
  void onInit() {
    emailController =
        TextEditingController(text: LocalDataHelper().getRememberMail() ?? "");
    passwordController =
        TextEditingController(text: LocalDataHelper().getRememberPass() ?? "");
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   _googleSignInAccount = Rx<GoogleSignInAccount?>(_googleSign.currentUser);
  //   _googleSignInAccount.bindStream(_googleSign.onCurrentUserChanged);
  //   ever(_googleSignInAccount, _setInitialScreenGoogle);
  // }

  //Google SignIn
  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (googleSignInAccount != null) {
      Get.offAllNamed(Routes.dashboardScreen);
    } else {
      Get.offAll(() =>  const WelcomeScreen());
    }
  }

  //General Login with email and password
  void loginWithEmailPassword({
    required String ipAdd,
    required String email,
    required String password
  }) async {
    _isLoggingIn(true);
    String? deviceToken;
    if(!kIsWeb) {
      deviceToken = await getDeviceToken();
    }
    await Repository().loginWithEmailPassword(email, password, ipAdd, deviceToken).then(
      (value) {
        if (value) Get.offAllNamed(Routes.dashboardScreen);
        _isLoggingIn(false);
      },
    );
  }

  // General SignUp
  Future signUp(String ipAddress, String deviceId) async {
    _isLoggingIn(true);
    await Repository().signUp(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailControllerSignup.text,
      userName: userNameControllerSignup.text,
      password: passwordControllerSignup.text,
      referredBy: referredByControllerSignup.text,
      gender: selectedGender.value == "Male" ? 1: 2,
      ipAdd: ipAddress,
      deviceId: deviceId,
      deviceToken: await getDeviceToken(),
    ).then((userModel) {
      _isLoggingIn(false);
      if (userModel != null) {
        if(enableEmailVerification.isTrue && userModel.user?.emailVerify == false) {
          Get.offNamed(Routes.emailVerification);
        } else {
          Get.offNamed(Routes.dashboardScreen);
        }
      } else {
        // Get.back();
      }
    });
    _isLoggingIn(false);
  }

  // Social SignUp
  // Future socialSignUp({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String gender,
  //   required String imageUrl,
  //   required String deviceId,
  //   required String deviceToken,
  //   required String ipAddress,
  // }) async {
  //   _isLoggingIn(true);
  //   await Repository().socialSignUp(
  //     name: name,
  //     email: email,
  //     password: password,
  //     gender: gender,
  //     photoUrl: imageUrl,
  //     referredBy: referredByControllerSignup.text,
  //     uniqueDeviceToken: deviceToken,
  //     ipAdd: ipAddress,
  //     deviceID: deviceId
  //   ).then((value) {
  //     _isLoggingIn(false);
  //     if (value) {
  //       Get.offAllNamed(Routes.dashboardScreen);
  //       update();
  //     } else {
  //       // Get.back();
  //     }
  //   });
  //   _isLoggingIn(false);
  // }

  // Social SignIn
  // Future<bool> socialSignIn({
  //   required String email,
  //   required String password,
  //   required String ip,
  //   required token
  // }) async {
  //   _isLoggingIn(true);
  //   bool result = await Repository().socialSignIn(
  //     email: email,
  //     password: password,
  //     ipAddress: ip,
  //     deviceToken: "$token",
  //   ).then((value) {
  //     return value;
  //     // _isLoggingIn(false);
  //     // if (value) {
  //     //   Get.offAllNamed(Routes.dashboardScreen);
  //     //   update();
  //     //   // updateDeviceToken();
  //     // } else {
  //     //   // Get.back();
  //     // }
  //   });
  //   return result;
  //   // _isLoggingIn(false);
  // }

  // email otp verification /////
  void otpVerification({required String otp, required int userId}) async {
    _isLoggingIn(true);
    await Repository().emailVerification(otp, userId).then((value) {
      if (value) Get.offAllNamed(Routes.dashboardScreen);
        _isLoggingIn(false);
    });
  }

  void resendEmail({required int userId}) async {
    await Repository().resendEmailVerification(userId);
  }

  // Sign in with google
  // void signInWithGoogle() async {
  //   _isLoggingIn(true);
  //   try {
  //     if(kIsWeb) {
  //       GoogleAuthProvider authProvider = GoogleAuthProvider();
  //       authProvider.scopes.addAll(scopes);
  //       final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(authProvider);
  //       final User? user = (await firebaseAuth.signInWithCredential(userCredential.credential!)).user;
  //       if(user != null) {
  //         socialSignIn(
  //           email: user.email ?? user.providerData[0].email.toString(),
  //           password: user.uid,
  //         );
  //       }
  //     } else {
  //       GoogleSignInAccount? googleSignInAccount = await googleInstance().signIn();
  //
  //       if (googleSignInAccount != null) {
  //         GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //
  //         AuthCredential credential = GoogleAuthProvider.credential(
  //           accessToken: googleSignInAuthentication.accessToken,
  //           idToken: googleSignInAuthentication.idToken,
  //         );
  //         final User? user = (await firebaseAuth.signInWithCredential(credential)).user;
  //         if (user != null) {
  //           if(await _isAuthorizedScopes()) {
  //             socialSignIn(
  //               email: user.providerData[0].email!,
  //               password: user.uid,
  //             );
  //           } else {
  //             log("Please allow requested permissions they are required");
  //           }
  //         } else {
  //           log("-----google user null");
  //           _isLoggingIn(false);
  //           Get.snackbar(
  //             "Error!!",
  //             "Failed to login",
  //             snackPosition: SnackPosition.BOTTOM,
  //           );
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     log("-----sign in error: $e");
  //     _isLoggingIn(false);
  //     Get.snackbar(
  //       "Error!!",
  //       "Failed to login",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  // Google Sign up and Sign in
  Future<bool> googleSignUpAndSignIn({
    required String userName,
    required String emailAddress,
    required String pass,
    required String gender,
    required String photo,
  }) async {
    String ipAdd = await SettingController().getIpAddress();
    String deviceId = await SettingController().getDeviceId();
    String? token = await getDeviceToken();
    bool signInSuccess = await Repository().socialSignIn(
      email: emailAddress,
      password: pass,
      ipAddress: ipAdd,
      deviceToken: token,
    );
    if(signInSuccess == true) {
      return signInSuccess;
    } else {
      bool isSignUpSuccess = await Repository().socialSignUp(
        name: userName,
        email: emailAddress,
        password: pass,
        gender: gender,
        photoUrl: photo,
        referredBy: referredByControllerSignup.text,
        uniqueDeviceToken: "$token",
        ipAdd: ipAdd,
        deviceID: deviceId,
      );
      return isSignUpSuccess;
    }
  }

  // Continue with google
  void continueWithGoogle() async {
    Dialogs.showLoadingDialog();
    _isLoggingIn(true);
    // try {
      if(kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        authProvider.scopes.addAll(scopes);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(authProvider);
        final User? user = (await firebaseAuth.signInWithCredential(userCredential.credential!)).user;
        if(user != null) {
          String gender = await _getGender(userCredential.credential!.accessToken!);
          googleSignUpAndSignIn(
            gender: gender,
            userName: user.displayName ?? "Undefined",
            emailAddress: user.email ?? user.providerData[0].email.toString(),
            pass: user.uid,
            photo: user.photoURL ?? "",
          ).then((value) {
            if(value) {
              Get.back();
             _isLoggingIn(false);
              Get.offAllNamed(Routes.dashboardScreen);
            } else {
              Get.back();
              _isLoggingIn(false);
            }
          });
        }
      } else {
        GoogleSignInAccount? googleSignInAccount = await googleInstance().signIn();

        if (googleSignInAccount != null) {
          GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

          AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          final User? user = (await firebaseAuth.signInWithCredential(credential)).user;
          if (user != null) {
            if(await _isAuthorizedScopes()) {
              String gender = await _getGender(googleSignInAuthentication.accessToken!);
              googleSignUpAndSignIn(
                userName: user.displayName ?? "Undefined",
                emailAddress: user.email ?? user.providerData[0].email.toString(),
                pass: user.uid,
                gender: gender,
                photo: user.photoURL ?? "",
              ).then((value) {
                if(value) {
                  Get.back();
                  _isLoggingIn(false);
                  Get.offAllNamed(Routes.dashboardScreen);
                } else {
                  Get.back();
                  _isLoggingIn(false);
                  return;
                }
              });
            } else {
              showShortToast("Please allow requested permissions they are required");
              log("Please allow requested permissions they are required");
            }
          } else {
            log("-----google user null");
            _isLoggingIn(false);
            Get.snackbar(
              "Error!!",
              "Failed to continue please try again",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        }
      }
    // } catch (e) {
    //   log("-----sign up error: $e");
    //   _isLoggingIn(false);
    //   Get.snackbar(
    //     "Error!!",
    //     "Failed to signup",
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
  }

  Future<String> _getGender(String googleAccessToken) async {
    final r = await http.get(
        Uri.parse(
            "https://people.googleapis.com/v1/people/me?personFields=genders&key=${googleConsoleAndroidApiKey.value}"),
        headers: {"Authorization": "Bearer $googleAccessToken"});
    final response = jsonDecode(r.body);
    return response["genders"][0]["formattedValue"];
  }

  GoogleSignIn googleInstance() {
    final GoogleSignIn _googleSign = GoogleSignIn(
        clientId: "${googleConsoleWebApiKey.value}.apps.googleusercontent.com",
        scopes: [
          "https://www.googleapis.com/auth/user.gender.read",
          "https://www.googleapis.com/auth/userinfo.profile",
          "https://www.googleapis.com/auth/userinfo.email"
        ]
    );
    return _googleSign;
  }

  Future<bool> _isAuthorizedScopes() async {
    final bool isAuthorized = await googleInstance().requestScopes(scopes);
    if (isAuthorized) {
      return true;
    } else {
      return false;
    }
  }

  // Twitter authentication
  void signUpWithTwitter() async {
    _isLoggingIn(true);
    try {
      TwitterLogin twitterLogin = TwitterLogin(
        apiKey: AppConfig.twitterApiKey,
        apiSecretKey: AppConfig.twitterApiSecretKey,
        redirectURI: AppConfig.twitterRedirectURI,
      );
      if(kIsWeb) {

        await twitterLogin.loginV2();
        // TwitterAuthProvider authProvider = TwitterAuthProvider();
        // final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(authProvider);
        // final User? user = (await _auth.signInWithCredential(userCredential.credential!)).user;
        // if(user != null) {
        //   String gender = await _getGender(userCredential.credential!.accessToken!);
        //   // print("name: ${user.displayName}");
        //   // print("email ${user.email}");
        //   // print("photo ${user.photoURL}");
        //   // print("password ${user.uid}");
        //   // print("gender $gender");
        //   // print("email ${user.providerData[0].email}");
        // }
      } else {
        await twitterLogin.loginV2();

      }
    } catch (e) {
      log("-----sign in error: $e");
      _isLoggingIn(false);
      Get.snackbar(
        "Error!!",
        "Failed to login",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  chatSocketLogin({
    required String name,
    required String id,
    required String profilePic,
  }) {
    socket.emit("userLogin", {"name": name, "id": id, "img": profilePic});
  }

  // Sign Out
  void signOut() async {
    try {
      await firebaseAuth.signOut();
      googleInstance().signOut();
      await Repository().logOut().then((value) {
        LocalDataHelper().box.remove("userTokenData");
        LocalDataHelper().box.remove('userModel');
        Get.offAllNamed(Routes.dashboardScreenWoLogin);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }

  Future updateDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    // bool result = await Repository().updateDeviceToken(deviceId: token!);
    // log("Device Token Updated $result");
  }
}
