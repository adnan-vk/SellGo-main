import 'dart:developer';

import 'package:authentication/model/authmodel.dart';
import 'package:authentication/service/authentication/auth_service.dart';
import 'package:authentication/view/bottom_bar/bottombar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<UserModel> allUsers = [];
  UserModel? currentUser;
  final AuthService authService = AuthService();
  TextEditingController usernameController = TextEditingController();
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
    // final user = UserModel(
    //     email: firebaseAuth.currentUser!.email,
    //     phoneNumber: firebaseAuth.currentUser.p,
    //     firstname: firstnamecontroller.text,
    //     uId: firebaseAuth.currentUser!.uid,
    //     lastname: lastnamecontroller.text);
    // authService.addUser(user);
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
    allUsers = await authService.getAllUsers();
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
    usernameController.clear();
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

  updateProduct(userid, UserModel data) async {
    await authService.updateUser(userid, data);
    clearControllers();
    notifyListeners();
  }

  getCurrentUser() async {
    await getUser();
    currentUser = allUsers
        .firstWhere((element) => element.uId == firebaseAuth.currentUser!.uid);
    notifyListeners();
  }
}
