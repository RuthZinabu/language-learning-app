import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:language_learning_app/pages/home_page/home_screen.dart';

class HomeContent extends StatefulWidget {
  HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late List<Map<String, dynamic>> courses;

  @override
  void initState() {
    super.initState();
    courses = [
      {
        "title": "${targetLanguage} Language",
        "progress": 0.75,
        "color": Color(0xFF5BA890),
        "totalClasses": 20,
        "completedClasses": 15
      },
      {
        "title": "Italian Language",
        "progress": 0.33,
        "color": Color(0xFFE28743),
        "totalClasses": 30,
        "completedClasses": 10
      },
      {
        "title": "German Language",
        "progress": 0.5,
        "color": Color(0xFF4A1D92),
        "totalClasses": 20,
        "completedClasses": 10
      },
    ];
  }

  void _navigateToCourseDetail(
      BuildContext context, Map<String, dynamic> course) {
    context.go('/courses', extra: {
      'currentLanguage': currentLanguage,
      'targetLanguage': targetLanguage,
    });
  }

  void _showComingSoonSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Coming Soon!!!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Continue Course Section
              const Text(
                "Continue Course",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: courses.map((course) {
                    return GestureDetector(
                      onTap: () => _navigateToCourseDetail(context, course),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: course['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Progress Indicator
                            Text(
                              "${course['completedClasses']}/${course['totalClasses']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: course['color'],
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Course Title
                            Text(
                              course['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Difficulty
                            const Text(
                              "Level 1",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),
              // Featured Courses Section
              const Text(
                "Featured Courses",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Grammar Quiz Card
                  GestureDetector(
                    onTap: () => _showComingSoonSnackbar(context),
                    child: _buildFeaturedCourseCard(
                      title: "Grammar Quiz",
                      subtitle: "Business English",
                      duration: "2 hours",
                      icon: Icons.quiz,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Set Weekly Goal Card
                  GestureDetector(
                    onTap: () => _showComingSoonSnackbar(context),
                    child: _buildFeaturedCourseCard(
                      title: "Set Weekly Goal!",
                      subtitle:
                          "Who set a weekly goal are more likely to stay motivated.",
                      icon: Icons.star,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCourseCard({
    required String title,
    required String subtitle,
    String? duration,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 15),

          // Text Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                if (duration != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
