import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../sqflite/CustomBottomNavigation.dart';
import '../sqflite/HomePageNew.dart';

class CameraViewPage extends StatelessWidget {
  CameraViewPage({Key? key, required this.path}) : super(key: key);
  final String path;
  TextEditingController _descriptionController = TextEditingController();

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: Colors.white, // Transparent border color
              width: 2.0, // Border width
            ),
          ),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Future<void> sendImageToServer(
      BuildContext context, File imageFile, String description) async {
    try {
      // Replace with your server URL
      final Uri serverUri = Uri.parse(
          'http://192.168.139.17:3000/upload'); // Replace with your actual server URL

      // Create a multipart request to send both the image and description
      final http.MultipartRequest request =
          http.MultipartRequest('POST', serverUri);

      // Add the image file to the request
      final http.MultipartFile imageMultipartFile =
          await http.MultipartFile.fromPath(
        'image', // The field name for the image on the server
        imageFile.path, // Path to the image file
      );

      request.files.add(imageMultipartFile);

      // Add the description as a field in the request
      request.fields['description'] = description;

      // Send the request
      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Request was successful, handle the server's response here
        // You can display a success message or navigate to a new screen as needed.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CustomBottomNaviagtion(), // Replace with the actual name of your HomePageNew widget
          ),
        );
        showErrorMessage(context, 'Image uploaded successfully');
      } else {
        // Request failed, handle the error here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CustomBottomNaviagtion(), // Replace with the actual name of your HomePageNew widget
          ),
        );
        showErrorMessage(context,
            'Image upload failed with status code: ${response.statusCode}! Try Again');
      }
    } catch (e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CustomBottomNaviagtion(), // Replace with the actual name of your HomePageNew widget
        ),
      );
      // Handle any exceptions or errors here
      showErrorMessage(context, 'Error sending image to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 100,
                      left: 5,
                      right: 5,
                      child: Image.file(
                        File(path),
                      ),
                    )
                  ],
                )),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLength: 300,
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Description...(300 Words)",
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: Colors.white,
                      size: 25,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    suffixIcon: IconButton(
                      icon: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      onPressed: () async {
                        String description = _descriptionController.text;
                        File imageFile = File(path);
                        sendImageToServer(context, imageFile, description);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
