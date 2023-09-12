import 'package:alpha/pages/Cameras/CameraScreen.dart';
import 'package:alpha/pages/sqflite/DatabaseHelper.dart';
import 'package:alpha/pages/sqflite/authPage_sql.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initializeDatabase();
  final prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPageSql(),
    );
  }
}
