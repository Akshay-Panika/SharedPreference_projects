import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreference_projects/LogIn_folder/home_screen.dart';
import 'package:sharedpreference_projects/LogIn_folder/splash_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}
class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // TextFormField
              TextFormField(controller: userController, decoration: const InputDecoration(hintText: 'User name'),
              validator: (value) {
                if(value!.isEmpty){
                  return 'Enter your User name';
                }
              },),

              //TextFormField
              TextFormField(controller: passController, decoration: const InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter your Password';
                    }
                  }),


                // LogIn button
                const SizedBox(height: 50,),
                Card(child: InkWell(onTap: ()async{
                  if(_formKey.currentState!.validate()){
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.setBool(SplashScreenState.ISLOGINKEY, true);
                      preferences.setString('userName', userController.text);
                      preferences.setString('userPass', userController.text);

                      // showSnackBar
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You are login')));
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  }
                },child: const SizedBox(height: 50,width: double.infinity,
                  child: Center(child: Text('LogIn',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),),),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
