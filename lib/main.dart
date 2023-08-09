import 'package:firebase_api_task/api_task/api_home_page.dart';
import 'package:firebase_api_task/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    title: "API Fetch Data",
    home: HomePage(),
  ));
}


class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ApiHomePage();
          } else {
            return LoginPage();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}



