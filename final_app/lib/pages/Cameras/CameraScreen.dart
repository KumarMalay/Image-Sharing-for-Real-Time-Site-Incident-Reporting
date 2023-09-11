import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'CameraView.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool flash = false;
  bool iscamerafront = false;
  double transform = 0;
  int pictureCounter = 0; // Counter to keep track of captured pictures

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  Future<void> takePhoto(BuildContext context) async {
    try {
      final XFile picture = await _cameraController.takePicture();
      pictureCounter++;

      final DateTime now = DateTime.now();
      final String formattedDateTime =
          DateFormat('yyyyMMdd_HHmmss').format(now);
      final String fileName = 'IMG_${formattedDateTime}_$pictureCounter.png';

      final appDir = await getApplicationDocumentsDirectory();
      final permanentImagePath = '${appDir.path}/$fileName';
      final File permanentImageFile = File(permanentImagePath);

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        picture.path,
        quality: 85, // Adjust the quality as needed (0 - 100)
      );

      // Write the compressed bytes to the permanent location
      await permanentImageFile.writeAsBytes(compressedBytes?.toList() ?? []);
      // Navigate to the CameraViewPage with the permanent image path
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CameraViewPage(path: permanentImagePath),
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Pop the current screen to go back
          },
        ),
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the shadow
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 135,
                          left: 6,
                          right: 6,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CameraPreview(_cameraController),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      width: 100, // Set the desired width for the container
                      height: 50, // Set the desired height for the container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.transparent),
                        color:
                            Colors.white, // Set the background color to white
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              }),
          Positioned(
            bottom: 5,
            child: SafeArea(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon: Icon(
                              flash ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                              size: 35,
                            ),
                            onPressed: () {
                              setState(() {
                                flash = !flash;
                              });
                              flash
                                  ? _cameraController
                                      .setFlashMode(FlashMode.torch)
                                  : _cameraController
                                      .setFlashMode(FlashMode.off);
                            }),
                        InkWell(
                          onTap: () {
                            takePhoto(context);
                          },
                          child: Icon(
                            Icons.panorama_fish_eye,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                        IconButton(
                            icon: Transform.rotate(
                              angle: transform,
                              child: const Icon(
                                Icons.flip_camera_android,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                iscamerafront = !iscamerafront;
                                transform = transform + pi;
                              });
                              int cameraPos = iscamerafront ? 0 : 1;
                              _cameraController = CameraController(
                                  cameras[cameraPos], ResolutionPreset.high);
                              cameraValue = _cameraController.initialize();
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    const Text(
                      "Capture",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
