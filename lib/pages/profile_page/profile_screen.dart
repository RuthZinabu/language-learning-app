import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF410FA3), // Purple color
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            tooltip: 'More',
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Open the end drawer
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF410FA3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF410FA3)),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);  
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Color(0xFF410FA3)),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);  
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF410FA3)),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);  
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
                child: Image.asset(
                  'assets/images/female_avator.png',
                  fit: BoxFit.fill,
                  width: 70,
                  height: 70,
                ),
              ),
              const SizedBox(height: 16),
              // Profile Name and Join Date
              const Text(
                "Kebron",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Joined March 2024",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // Add Language Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF410FA3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Color(0xFF410FA3)),
                    SizedBox(width: 4),
                    Text(
                      "Add Language",
                      style: TextStyle(color: Color(0xFF410FA3)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // My Activity Section
              _buildSectionHeader("My Activity", () {}),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActivityCard("Total hours", "8h : 20 min"),
                  _buildActivityCard("This Week", ""),
                ],
              ),
              const SizedBox(height: 24),
              // Achievement Section
              _buildSectionHeader("Achievement", () {}),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAchievementCard(
                      "German Language", "Level 1", "assets/flags/de.png"),
                  _buildAchievementCard(
                      "French Language", "Level 2", "assets/flags/fr.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section Header Widget
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

  // Activity Card Widget
  Widget _buildActivityCard(String title, String subtitle) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Achievement Card Widget
  Widget _buildAchievementCard(String title, String level, String flagUrl) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
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
