import 'package:chat_app/View/Home/home_page.dart';
import 'package:chat_app/ViewModel/Auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
        //   user is loged in
          if(snapshot.hasData){
            return HomePage();
          }
          // user isn not Logedin
          else{
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
