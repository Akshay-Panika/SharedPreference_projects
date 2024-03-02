import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
   static const String ISLOGINKEY = 'isLogInKey';
  void whereToGoScreen()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isLogIn =preferences.getBool(ISLOGINKEY);

    // Animate to next screen
    Timer(const Duration(milliseconds:1500), () {
      if(isLogIn != null){
        if(isLogIn){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogInScreen()));
        }
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogInScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    whereToGoScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: Text('Welcome',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),),
      ),
    );
  }
}
