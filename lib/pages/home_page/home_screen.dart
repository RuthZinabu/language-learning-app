import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_learning_app/pages/learning_levels/courses.dart';
import 'package:language_learning_app/pages/translator_page/translation.dart';
import 'package:language_learning_app/pages/home_page/favorites_screen.dart';
import 'package:language_learning_app/pages/profile_page/profile_screen.dart';
import 'package:language_learning_app/pages/home_page/home_content.dart';
import 'package:language_learning_app/widgets/custom_bottom_navigation.dart';
import 'package:language_learning_app/widgets/home_app_bar.dart';

String? currentLanguage;
String? targetLanguage;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions;
  String userFirstName = "Guest"; // Default name

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _widgetOptions = <Widget>[
      HomeContent(),
      Courses(),
      TranslationPage(),
      Favorites(),
      ProfilePage(userFirstName: userFirstName),
    ];
  }

  Future<void> _fetchUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Retrieve user details from Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final data = userDoc.data();
          if (data != null) {
            setState(() {
              userFirstName = data['first_name'] ?? 'Guest';
              currentLanguage = data['currentLanguage'] ?? 'English';
              targetLanguage = data['targetLanguage'] ?? 'French';
            });
          }
        }
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _selectedIndex == 0
          ? HomeAppBar(
              userFirstName: userFirstName,
              onNotificationsPressed: () {
                // Handle notifications press
                print('Notifications pressed');
              },
            )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
