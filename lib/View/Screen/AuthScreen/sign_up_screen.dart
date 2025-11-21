import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_message/Utils/AppColors/app_colors.dart';
import 'package:sky_message/Utils/AppString/app_string.dart';
import 'package:sky_message/View/Screen/AuthScreen/login_screen.dart';

import '../../../Controller/auth_controller.dart';
import '../BottomNav/user_list_screen.dart';

class SignUpScreen extends StatelessWidget {
  final emailTEController = TextEditingController();
  final passTEController = TextEditingController();
  final retypePassTEController = TextEditingController();
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    Get.to(LoginPage());
                  },
                  child: Text("Login",
                    style: TextStyle(
                      color: AppColors.readColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Text(
                  AppString.signUpText,
                  style: TextStyle(
                    color: AppColors.readColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              SizedBox(height: 18),

              Align(
                alignment: Alignment.center,
                child: Text(
                  AppString.loginWellComeText,
                  style: TextStyle(color: AppColors.blackColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: buildInputSection(),
              ),
              SizedBox(height: 15),

              Text(
                AppString.forgotPasswordText,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: onTapSignUpButton,
                  child: Container(

                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Sign-Up",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(right: 16,left: 16),
                child: buildContinueSocialSection(),
              ),
              // children: [
              //   TextField(controller: emailC, decoration: InputDecoration(labelText: "Email")),
              //   TextField(controller: passC, decoration: InputDecoration(labelText: "Password"), obscureText: true),
              //   SizedBox(height: 20),
              //   ElevatedButton(
              //     onPressed: () async {
              //       final err = await auth.signUp(emailC.text.trim(), passC.text.trim());
              //       if (err != null)
              //       {Get.snackbar("Error", err);
              //       print("error is ${err.toString()}");
              //       }
              //       else Get.off(() => UserListPage());
              //     },
              //     child: Text("Register"),
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }

  Form buildInputSection() {
    return Form(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppString.userNameText,
              style: TextStyle(color: AppColors.readColor),
            ),
          ),
          SizedBox(height: 5),
          Card(elevation: 5, child: TextFormField(
            controller: emailTEController,
          )),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppString.passwordText,
              style: TextStyle(color: AppColors.readColor),
            ),
          ),
          SizedBox(height: 5),
          Card(elevation: 5, child: TextFormField(
            controller: passTEController,
          )),


          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppString.confirmPasswordText,
              style: TextStyle(color: AppColors.readColor),
            ),
          ),
          SizedBox(height: 5),
          Card(elevation: 5, child: TextFormField(
            controller: retypePassTEController,
          )),
        ],
      ),
    );
  }

  Column buildContinueSocialSection() {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.g_mobiledata, color: Colors.blue, size: 40),
                ),

                SizedBox(width: 15),
                Text(
                  AppString.continueWithFacebookText,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 60,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(Icons.g_mobiledata, color: Colors.blue, size: 40),
                ),

                SizedBox(width: 15),
                Text(
                  AppString.continueWithGoogleText,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void>onTapSignUpButton()async{

    final err = await auth.signUp(emailTEController.text.trim(), passTEController.text.trim());
          if (err != null)
          {Get.snackbar("Error", err);
          print("error is ${err.toString()}");
          }
          else {
            Get.off(() => UserListPage());
          }

  }
}
