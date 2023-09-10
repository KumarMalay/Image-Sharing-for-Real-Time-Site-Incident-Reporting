import 'package:final_app/pages/sqflite/HomePageSql.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Home_page.dart';
import 'login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder : (context, snapshot){
          //User logged in
          if(snapshot.hasData){
            return const HomePage();
          }
          //Not Logged in
          else{
            return const LoginOrRegisterPage();
          }
        }
      ),
    );
  }
}
