import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:loginapplication/Screens/home_page.dart';

class FirebaseServices extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  String useremail = "";
  String userpassword = "";

  signup() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: useremail,
        password: userpassword,
      )
          .then((value) {
            Get.back();
        Get.defaultDialog(
            title: "Success", middleText: "Your account is registered");
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        Get.defaultDialog(
            title: "Error", middleText: "The password provided is too weak.");
      } else if (error.code == 'email-already-in-use') {
        Get.defaultDialog(
            title: "Error",
            middleText: "The account already exists for that email.");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  signin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: useremail, password: userpassword);
      if (userCredential.user != null) {
        Get.to(() => const HomeScreen());
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        Get.defaultDialog(
            title: "Error", middleText: "No User Found , Enter correct Email");
      } else if (error.code == 'wrong-password') {
        Get.defaultDialog(
            title: "Error",
            middleText: "Wrong password , Try Again");
      }
    }
  }
}
