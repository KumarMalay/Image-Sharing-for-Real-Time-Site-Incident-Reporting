import 'package:flutter/material.dart';
import 'CustomBottomNavigation.dart';
import 'LoginOrRegister.dart';

class AuthPageSql extends StatefulWidget {
  @override
  State<AuthPageSql> createState() => _AuthPageSqlState();
}

class _AuthPageSqlState extends State<AuthPageSql> {
  // Replace this boolean with your actual login state logic
  bool isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    // Perform any initialization logic here if needed
    // Example: Check if the user is logged in and set the isLoggedIn variable
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      // User is logged in, navigate to HomePageNew
      return CustomBottomNaviagtion();
    } else {
      // User is not logged in, show login/register page
      return LoginOrRegisterPageSql();
    }
  }
}
