import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Cameras/Camera.dart';
import 'DatabaseHelper.dart';
import 'authPage_sql.dart';

class HomePageSql extends StatefulWidget {
  const HomePageSql({super.key});

  @override
  State<HomePageSql> createState() => _HomePageSqlState();
}

class _HomePageSqlState extends State<HomePageSql> {
  bool isLoggedIn = false;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  void signUserOut() async {
    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPageSql(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'P',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 30, // Increase the font size for 'H'
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'rofile',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 30, // Font size for the rest of the text
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                signUserOut();
              },
              icon: Icon(
                Icons.logout,
                size: 25,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/cam.png'),
                          radius: 70.0,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // Make the text bold
                            fontSize: 30.0, // Set the font size
                          ),
                        ),
                        Text(
                          'Back!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // Make the text bold
                            fontSize: 30.0, // Set the font size
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      // '${user.email}',
                      'Username',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          // Make the text bold
                          fontSize: 15.0,
                          color: Colors.blue // Set the font size
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 200.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                'images/C1.png',
                                width: 150.0,
                                height: 200.0,
                                // Adjust the height to occupy the whole card
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              color: Colors.black.withOpacity(0.3),
                              // Transparent black background
                              child: const Text(
                                'Capture',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0), // Add spacing between cards
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                'images/C2.png',
                                width: 150.0,
                                height: 200.0,
                                // Adjust the height to occupy the whole card
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              color: Colors.black.withOpacity(0.3),
                              // Transparent black background
                              child: const Text(
                                'Pick from Gallery',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
