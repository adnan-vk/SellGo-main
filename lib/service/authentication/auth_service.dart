// // ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:authentication/model/authmodel.dart';
import 'package:authentication/view/bottom_bar/bottombar.dart';
import 'package:authentication/widgets/snack_bar_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  String? verificationid;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String collection = 'User';
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<UserModel> user;

  AuthService() {
    user = FirebaseFirestore.instance
        .collection(collection)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(
          snapshot.data()!,
        );
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  Future<void> addUser(UserModel data) async {
    try {
      await user.doc(firebaseAuth.currentUser!.uid).set(data);
    } catch (e) {
      log('Error adding post :$e');
    }
  }

  getCurrentUser() async {
    final snapshot = await firestore
        .collection(collection)
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    return UserModel.fromJson(snapshot.data()!);
  }
  // Future<List<UserModel>> getAllUsers() async {
  //   final snapshot = await user.get();
  //   return snapshot.docs.map((doc) => doc.data()).toList();
  // }

  Future<UserCredential> signUpEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('Account created');
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User loged in');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOutEmail() async {
    await firebaseAuth.signOut();
  }

  googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        log('Google authentication failed');
        throw Exception('Google authentication failed');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? guser = userCredential.user;
      log("user display Name : ${guser?.displayName}");
      return guser;
    } catch (e) {
      print('Google Sign-In Error: $e');
      throw e;
    }
  }

  Future googleSignOut() async {
    return await GoogleSignIn().signOut();
  }

  Future<void> getOtp(String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await user.updatePhoneNumber(phoneAuthCredential);
          }
        },
        verificationFailed: (error) {
          log("verification failed error : $error");
        },
        codeSent: (verificationId, forceResendingToken) {
          verificationid = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          verificationid = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      log("sign in error : $e");
    }
  }

  Future<PhoneAuthCredential?> verifyOtp(String otp, context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationid!, smsCode: otp);
      await firebaseAuth.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBar(),
          ),
          (route) => false);
      snackBarWidget().iconSnackSuccess(context, label: "OTP Validated");
    } catch (e) {
      snackBarWidget().iconSnackFail(context, label: "Invalid OTP");
      log("verify otp error $e");
      return null;
    }
    return null;
  }

  updateUser(userid, UserModel data) async {
    try {
      await user.doc(userid).update(data.toJson());
    } catch (e) {
      log("error in updating product : $e");
    }
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection(collection).get();

      List<UserModel> data =
          snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
      log("data leangth : ${data.length}");
      return data;
    } catch (e) {
      log('get error: $e');
      throw e;
    }
  }
}
