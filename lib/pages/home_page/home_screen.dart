import 'package:flutter/material.dart';
import 'package:language_learning_app/pages/learning_levels/courses.dart';
import 'package:language_learning_app/pages/translator_page/translation.dart';
import 'package:language_learning_app/pages/home_page/favorites_screen.dart';
import 'package:language_learning_app/pages/profile_page/profile_screen.dart';
import 'package:language_learning_app/pages/home_page/home_content.dart';

class HomeScreen extends StatefulWidget {
  final String currentLanguage;
  final String targetLanguage;

  const HomeScreen({
    Key? key,
    required this.currentLanguage,
    required this.targetLanguage,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeContent(
                  currentLanguage: widget.currentLanguage,
          targetLanguage: widget.targetLanguage
      ), // Home content widget
      Courses(
          currentLanguage: widget.currentLanguage,
          targetLanguage: widget.targetLanguage),
      Translator(),
      Favorites(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background
      appBar: _selectedIndex != 4
          ? AppBar(
              backgroundColor: const Color(0xFF410FA3), // Purple color
              elevation: 0,
              toolbarHeight: 100,
              automaticallyImplyLeading: false,
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back, color: Colors.white),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              // ),
              flexibleSpace: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/img5.png',
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Kebron',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'What would you like to learn today?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined),
                          color: Colors.white,
                          iconSize: 28,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF410FA3),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Translate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
