import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Cameras/Camera.dart';
import 'DatabaseHelper.dart';
import 'RegisterPage_sqlite.dart';
import 'authPage_sql.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({Key? key}) : super(key: key);

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  String formattedDate = DateFormat('yyyy, dd MMMM').format(DateTime.now());
  String formattedDay = DateFormat('EEEE').format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  void signUserOut() async {
    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPageSql(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDay,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: signUserOut,
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 25,
                          semanticLabel: "Logout",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 15),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Actions",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Colors.white, // Specify the border color here
                      width: 1, // Adjust the border width as needed
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      height: 570,
                      color: Colors.blue.shade800,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Upload",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.white)),
                                  Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue.shade600,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CameraPage(),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        color: Colors.white,
                                        Icons.linked_camera_outlined,
                                        size: 35,
                                      ),
                                      title: Text(
                                        "Capture",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      subtitle: Text(
                                        "Take a Picture",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
