import 'dart:developer';

import 'package:authentication/model/authmodel.dart';
import 'package:authentication/service/authentication/auth_service.dart';
import 'package:authentication/view/bottom_bar/bottombar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel? currentUser;
  UserModel? sortedUser;
  final AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  Country selectCountry = Country(
      phoneCode: '91',
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "INDIA",
      example: "INDIA",
      displayName: "INDIA",
      displayNameNoCountryCode: "IN",
      e164Key: "");
  bool showOtpField = false;

  Future<UserCredential> signUpEmail(String email, String password) async {
    return await authService.signUpEmail(email, password);
  }

  Future<UserCredential> signInEmail(String email, String password) async {
    return await authService.signInEmail(email, password);
  }

  Future<void> signOutEmail() async {
    return await authService.signOutEmail();
  }

  addUser() async {
    final user = UserModel(
        email: emailController.text,
        phoneNumber: phoneController.text,
        firstname: firstnamecontroller.text,
        uId: firebaseAuth.currentUser!.uid,
        lastname: lastnamecontroller.text);
    await authService.addUser(user);
    getUser();
  }

  getUser() async {
    currentUser = await authService.getCurrentUser();
    log(currentUser?.phoneNumber ?? "");
    notifyListeners();
  }

  Future<void> googleSignIn(context) async {
    try {
      User? guser = await authService.googleSignIn();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBar(),
        ),
        (route) => false,
      );
      final user = UserModel(
          email: guser!.email ?? "",
          phoneNumber: guser.phoneNumber ?? "",
          firstname: guser.displayName ?? "",
          uId: guser.uid,
          lastname: "",
          image: guser.photoURL);
      await authService.addUser(user);
      getUser();
      notifyListeners();
    } catch (e) {
      log('Google not signed in ');
    }
  }

  Future<void> googleSignout() async {
    await authService.googleSignOut();
    notifyListeners();
  }

  clearControllers() {
    firstnamecontroller.clear();
    lastnamecontroller.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneController.clear();
    otpController.clear();
    notifyListeners();
  }

  Future<void> getOtp(phoneNumber) async {
    await authService.getOtp(phoneNumber);
    notifyListeners();
  }

  Future<void> verifyOtp(otp, context) async {
    await authService.verifyOtp(otp, context);
    notifyListeners();
  }

  showOtp() {
    showOtpField = true;
    notifyListeners();
  }

  countrySelection(value) {
    selectCountry = value;
  }

  updateUser(userid, UserModel data) async {
    await authService.updateUser(userid, data);
    clearControllers();
    notifyListeners();
  }

  getProductUser(String uId) async {
    List<UserModel> allUsers = await authService.getAllUser();
    sortedUser = allUsers.firstWhere((element) => element.uId == uId);
    notifyListeners();
  }
}
