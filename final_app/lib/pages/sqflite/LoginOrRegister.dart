import 'package:flutter/material.dart';
import 'LoginPage_sqlite.dart';
import 'RegisterPage_sqlite.dart';

class LoginOrRegisterPageSql extends StatefulWidget {
  const LoginOrRegisterPageSql({super.key});

  @override
  State<LoginOrRegisterPageSql> createState() => _LoginOrRegisterPageSqlState();
}

class _LoginOrRegisterPageSqlState extends State<LoginOrRegisterPageSql> {
  //initially show login page
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
      return LoginPageSql(
        onTap: togglePages,
      );
    } else {
      return RegisterPageSql(
        onTap: togglePages,
      );
    }
  }
}
