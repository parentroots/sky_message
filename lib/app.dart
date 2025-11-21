import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetMaterialApp;
import 'package:sky_message/Utils/AppColors/app_colors.dart';
import 'package:sky_message/View/Screen/AuthScreen/sign_up_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationThemeData(
          fillColor: AppColors.whiteColor,
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(

              color: Colors.transparent,
              width: 1
            )
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color:AppColors.readColor,
                  width: 1
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1
              )
          ),
        ),

      ),
    );
  }
}
