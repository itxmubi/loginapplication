import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginapplication/Screens/signup_screen.dart';
import 'package:loginapplication/Services/firebase_services.dart';
import 'package:loginapplication/utils/app_images.dart';

import '../utils/app_colors.dart';
import '../utils/sized_boxes.dart.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseServices firebaseServices = Get.put(FirebaseServices());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppImages().loginBackgroundImage,
              ),
            ),
          ),
          child: Column(children: [
            SizedBoxes().height150,
            Container(
              height: 400,
              width: 340,
              color: AppColors().kblack38,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBoxes().height10,
                    Center(
                      child: Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 40, color: AppColors().kwhite),
                      ),
                    ),
                    SizedBoxes().height30,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        "Email",
                        style:
                            TextStyle(fontSize: 20, color: AppColors().kwhite),
                      ),
                    ),
                    SizedBoxes().height10,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Textfieldwidget(emailController: emailController,obscure: false,),
                    ),
                    SizedBoxes().height20,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        "Password",
                        style:
                            TextStyle(fontSize: 20, color: AppColors().kwhite),
                      ),
                    ),
                    SizedBoxes().height10,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child:
                          Textfieldwidget(emailController: passwordController,obscure: true,),
                    ),
                    SizedBoxes().height40,
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          firebaseServices.useremail = emailController.text;
                          firebaseServices.userpassword =
                              passwordController.text;
                          firebaseServices.update();
                          firebaseServices.signin();
                        },
                        child: const Text("Sign In"),
                      ),
                    )
                  ]),
            ),
            SizedBoxes().height80,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ? ",
                  style: TextStyle(color: AppColors().kwhite, fontSize: 15),
                ),
                SelectableText(
                  " Sign up ",
                  onTap: () {
                    Get.to(() => const SignUpScreen());
                  },
                  style: TextStyle(color: AppColors().kblue, fontSize: 15),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class Textfieldwidget extends StatelessWidget {
   Textfieldwidget({
    Key? key,
    required this.emailController,required this.obscure,
  }) : super(key: key);

  final TextEditingController emailController;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, bottom: 5),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors().kwhite70),
            borderRadius: BorderRadius.circular(20)),
        height: 40,
        width: 260,
        child: TextField(
          obscureText: obscure,
          style: TextStyle(color: AppColors().kwhite),
          controller: emailController,
          decoration:  InputDecoration(border: InputBorder.none,),
        ));
  }
}
