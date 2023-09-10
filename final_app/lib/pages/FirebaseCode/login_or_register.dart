import 'package:final_app/pages/FirebaseCode/login_page.dart';
import 'package:final_app/pages/FirebaseCode/register_page.dart';
import 'package:final_app/pages/sqflite/LoginPage_sqlite.dart';
import 'package:final_app/pages/sqflite/RegisterPage_sqlite.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //initally show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        // onTap: (BuildContext context) {
        //   togglePages();
        // },
        onTap: togglePages,
        // onTap: () => togglePages(),
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
