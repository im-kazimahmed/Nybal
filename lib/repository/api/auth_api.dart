import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/firebase_user_model.dart';
import '../../../utils/constants.dart';

class AuthApi {
  Future<UserCredential> login(
      {required String email, required String password}) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> register(
      {required String email, required String password, required String name}) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUser(
      {required FirebaseUserModel user}) {
   return FirebaseFirestore.instance
        .collection(userCollection)
        .doc(user.id)
        .set(user.toMap());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> checkUserExistInFirebase(
      {required String uId}) {
    return FirebaseFirestore.instance.collection(userCollection).doc(uId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      {required String uId}) {
    return FirebaseFirestore.instance.collection(userCollection).doc(uId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDataByAppId(
      {required int appUserId,}) {
    return FirebaseFirestore.instance
        .collection(userCollection)
        .where('appUserId', isEqualTo: appUserId)
        .limit(1)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first;
      } else {
        throw Exception("User not found for appUserId: $appUserId");
      }
    });
  }
}
