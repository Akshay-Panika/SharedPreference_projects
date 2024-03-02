import 'package:flutter/material.dart';

import 'LogIn_folder/splash_screen.dart';

void main(){
  runApp(const SharedPreferenceProject());
}

class SharedPreferenceProject extends StatelessWidget {
  const SharedPreferenceProject({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
