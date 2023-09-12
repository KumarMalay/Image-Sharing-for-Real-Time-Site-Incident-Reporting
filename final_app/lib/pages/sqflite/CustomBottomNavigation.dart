import 'package:alpha/pages/sqflite/HomePageNew.dart';
import 'package:flutter/material.dart';

import 'HomePageNew_2.dart';

class CustomBottomNaviagtion extends StatefulWidget {
  const CustomBottomNaviagtion({super.key});

  @override
  State<CustomBottomNaviagtion> createState() => _CustomBottomNaviagtionState();
}

class _CustomBottomNaviagtionState extends State<CustomBottomNaviagtion> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _buildPage(0, HomePageNew()), // Index 0: Home Page
            _buildPage(1, HomePageNew2()), // Index 1: Received Page
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          iconSize: 25,
          
          backgroundColor: Colors.blue.shade700,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.send,
              ),
              label: 'Send',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add,
              ),
              label: 'Received',
            ),
          ],
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          fixedColor: Colors.red,
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int pageIndex, Widget pageContent) {
    return AnimatedOpacity(
      opacity: _currentIndex == pageIndex ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: _currentIndex != pageIndex,
        child: pageContent,
      ),
    );
  }
}
