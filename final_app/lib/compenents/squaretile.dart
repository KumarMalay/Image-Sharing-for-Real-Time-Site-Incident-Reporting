import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  // const SquareTile({super.key, required.this.imagePath});

  const SquareTile({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),

        child: Image.asset(imagePath, height: 40),
      ),
    );
  }
}
