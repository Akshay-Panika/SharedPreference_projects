import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreference_projects/LogIn_folder/login_screen.dart';
import 'package:sharedpreference_projects/LogIn_folder/splash_screen.dart';

import '../Note_folder/add_note_screen.dart';
import '../Note_folder/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  var userName;
  var userPass;

  // getLogInData
  getLogInData()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Retrieve username and password from shared preferences
    var user =preferences.getString('userName');
     var pass =preferences.getString('userPass');

    // Assign default values if data is not available
    userName = user ?? 'User Name';
     userPass = pass ?? 'User Pass';
     setState(() { });    // Trigger a rebuild to update the UI with new values

  }


  // getData
  List<NoteModel> noteList =[];
  late SharedPreferences sharedPreferences;
  getData()async{
    sharedPreferences = await SharedPreferences.getInstance();
    List<String>? stringList = sharedPreferences.getStringList('list');
    if(stringList != null){
      noteList = stringList.map((item) => NoteModel.fromMap(json.decode(item))).toList();
    }
  }
  @override
  void initState() {
    super.initState();
    getLogInData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(elevation: 1,
        backgroundColor: Colors.white,
        title:  Text(userName.toString(),style: const TextStyle(color: Colors.blue),),
        actions:[

          // Logout button
          IconButton(onPressed: ()async{
            SharedPreferences preference = await SharedPreferences.getInstance();
            preference.setBool(SplashScreenState.ISLOGINKEY, false);

            // Navigator screen
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
          },icon: const Icon(Icons.logout,color: Colors.black54,)),
        ]
      ),

      // NoteScreen
      body: noteList.isEmpty ? const Center(child: Text('No data',style: TextStyle(fontSize: 19),),):
      ListView.builder(
        itemCount:noteList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text(index.toString()),),
            title: Text(noteList[index].title.toString()),
            subtitle:Text(noteList[index].descriptions.toString()),
            trailing: IconButton(onPressed: () {
              setState(() {
                noteList.remove(noteList[index]);
                List<String> stringList = noteList.map((item) => json.encode(item.toMap())).toList();
                sharedPreferences.setStringList('list', stringList);
              });
            }, icon: const Icon(Icons.delete),),
          );
        },),

      // floatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          String refresh = await
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNoteScreen()));
          if(refresh == 'loadData'){
            setState(() {
              getData();
            });
          }

        },child: Icon(Icons.add),
      ),
    );
  }
}
