import 'dart:ui';

import 'package:ai_chatbot/features/chatbot/chatbot_screen.dart';
import 'package:ai_chatbot/features/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MyHomePage(),
    AiChatbotScreen(),
    Center(child: Text('Profile Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _screens[_selectedIndex],
      bottomNavigationBar: GlassBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GlassBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GlassBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(200),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.7),
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.7),
            ),
            unselectedFontSize: 24,
            selectedFontSize: 28,
            backgroundColor: Color.fromARGB(255, 71, 233, 133),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            iconSize: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            currentIndex: currentIndex,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.transparent),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.transparent),
                label: 'Chatbot',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.transparent),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
