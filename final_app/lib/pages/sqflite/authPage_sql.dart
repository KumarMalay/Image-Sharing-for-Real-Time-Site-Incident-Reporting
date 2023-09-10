import 'package:flutter/material.dart';
import 'HomePageNew.dart';
import 'LoginOrRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPageSql extends StatefulWidget {
  const AuthPageSql({super.key});

  @override
  State<AuthPageSql> createState() => _AuthPageSqlState();
}

class _AuthPageSqlState extends State<AuthPageSql> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final prefs = snapshot.data as SharedPreferences;
          final bool? isLoggedIn = prefs.getBool('isLoggedIn');
          if (isLoggedIn ?? false) {
            // User is logged in, navigate to HomePageNew
            return HomePageNew();
          } else {
            // User is not logged in, show login/register page
            return LoginOrRegisterPageSql();
          }
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}