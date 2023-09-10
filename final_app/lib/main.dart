import 'package:camera/camera.dart';
import 'package:final_app/pages/Cameras/CameraScreen.dart';
import 'package:final_app/pages/sqflite/DatabaseHelper.dart';
import 'package:final_app/pages/sqflite/authPage_sql.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initializeDatabase();
  final prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null) ? false : prefs.getBool('isLoggedIn');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: "MontaguSlab"),
      home: AuthPageSql(),
      // home: CameraScreen(),
    );
  }
}
