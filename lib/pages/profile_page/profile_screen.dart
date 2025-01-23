import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:language_learning_app/database/user_model.dart';
import 'package:language_learning_app/database/user_repo.dart';
import 'package:language_learning_app/pages/login_signUp/auth_service.dart';

class ProfilePage extends StatefulWidget {
  final String userFirstName;
  ProfilePage({super.key, required this.userFirstName});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService =
      AuthService(); // Initialize AuthService instance
  late String userFirstName;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userFirstName = widget.userFirstName; // Initialize from the passed value
    _fetchUserDetails(); // Fetch user details
  }

  Future<void> _fetchUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        UserModel? userModel =
            await UserRepository.instance.getUserByEmail(user.email!);
        if (userModel != null) {
          setState(() {
            userFirstName = userModel.first_name; // Update state
          });
        }
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<void> _logoutUser() async {
    try {
      await _authService.logout();
      context.go('/login'); // Redirect to login page
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF410FA3),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.go('/home'),
            ),
            PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                if (value == 'share') {
                  // Function to handle sharing
                } else if (value == 'logout') {
                  _logoutUser(); // Function to handle logout
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'share',
                    child: Text('Share'),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the entire body with SingleChildScrollView
        child: Column(
          children: [
            // Profile Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF410FA3), Color(0xFF7349FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/images/female_avator.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${userFirstName.toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Add Language Button (from second code)
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.white,
            //     side: const BorderSide(color: Color(0xFF410FA3)),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            //   child: const Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Icon(CupertinoIcons.add, color: Color(0xFF410FA3)),
            //       SizedBox(width: 4),
            //       Text(
            //         "Add Language",
            //         style: TextStyle(color: Color(0xFF410FA3)),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 24),

            const SizedBox(height: 24),

            // Achievement Section
            _buildSectionHeader("Achievement", () {}),
            const SizedBox(height: 16),
            SingleChildScrollView(
              // Wrap the Row in a SingleChildScrollView
              scrollDirection:
                  Axis.horizontal, // Set the scroll direction to horizontal
              child: Row(
                children: [
                  _buildAchievementCard(
                      "German Language", "Level 1", "assets/flags/de.png"),
                  _buildAchievementCard(
                      "French Language", "Level 2", "assets/flags/us.png"),
                  _buildAchievementCard(
                      "French Language", "Level 2", "assets/flags/kr.png"),
                  _buildAchievementCard(
                      "French Language", "Level 2", "assets/flags/it.png"),
                  _buildAchievementCard(
                      "French Language", "Level 2", "assets/flags/et.png"),
                  _buildAchievementCard(
                      "French Language", "Level 2", "assets/flags/in.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Header Widget (from second code)
  Widget _buildSectionHeader(String title, VoidCallback onViewAllPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onViewAllPressed,
          child: const Text(
            "View All",
            style: TextStyle(fontSize: 14, color: Color(0xFF410FA3)),
          ),
        ),
      ],
    );
  }

  // Achievement Card Widget (from second code)
  Widget _buildAchievementCard(String title, String level, String flagUrl) {
    return SizedBox(
      width: 150, // Set a fixed width for each achievement card
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12)), // Curved corners for the card
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                flagUrl,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                level,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
