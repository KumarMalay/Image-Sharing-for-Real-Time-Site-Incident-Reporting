import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DatabaseHelper.dart';
import 'authPage_sql.dart';
import 'package:http/http.dart' as http;

class HomePageNew2 extends StatefulWidget {
  const HomePageNew2({Key? key}) : super(key: key);

  @override
  State<HomePageNew2> createState() => _HomePageNew2State();
}

class _HomePageNew2State extends State<HomePageNew2> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  String formattedDate = DateFormat('yyyy, dd MMMM').format(DateTime.now());
  String formattedDay = DateFormat('EEEE').format(DateTime.now());
  List<ImageInfo> images = [];

  @override
  void initState() {
    super.initState();
    fetchImagesFromServer();
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

  Future<void> fetchImagesFromServer() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.139.17:3000/images')); // Replace with your server URL
      if (response.statusCode == 200) {
        // Images fetched successfully
        final List<dynamic> imageList = json.decode(response.body);
        setState(() {
          images = imageList.map((data) => ImageInfo.fromJson(data)).toList();
          images = images.reversed.toList(); // Reverse the order
        });
      } else {
        // Handle the error when fetching images
        print(
            'Failed to fetch images with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching images from server: $e');
    }
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Post",
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
              for (final imageInfo in images)
                ImageAndDescriptionCard(imageInfo: imageInfo),
            ],
          ),
        ),
      ),
    );
  }
}

// Define a class to represent the image and description
class ImageInfo {
  final String fileName;
  final String description;
  final String image;

  ImageInfo({
    required this.fileName,
    required this.description,
    required this.image,
  });

  // Create an instance from JSON data
  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      fileName: json['fileName'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
}

class ImageAndDescriptionCard extends StatelessWidget {
  final ImageInfo imageInfo;

  const ImageAndDescriptionCard({Key? key, required this.imageInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
            // height: 570,
            color: Colors.blue.shade800,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("New Posts",
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
                    SizedBox(height: 10),
                    Image.memory(
                      // Decode base64 image data
                      base64.decode(imageInfo.image),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                    Text(
                      imageInfo.description,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}