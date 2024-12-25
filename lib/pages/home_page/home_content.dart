import 'package:flutter/material.dart';
import 'package:language_learning_app/pages/learning_levels/courses.dart';

class HomeContent extends StatefulWidget {
  final String currentLanguage;
  final String targetLanguage;

  HomeContent({
    Key? key,
    required this.currentLanguage,
    required this.targetLanguage,
  }) : super(key: key);

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
        "title": "${widget.targetLanguage} Language",
        "progress": 0.75,
        "color": Color(0xFF5BA890)
      },
      {
        "title": "Italian Language",
        "progress": 0.33,
        "color": Color(0xFFE28743)
      },
      {
        "title": "German Language",
        "progress": 0.50,
        "color": Color(0xFF4A1D92)
      },
    ];
  }

  void _navigateToCourseDetail(
      BuildContext context, Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Courses(
            currentLanguage: widget.currentLanguage,
            targetLanguage: widget.targetLanguage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          itemCount: courses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final course = courses[index];
            return GestureDetector(
              onTap: () => _navigateToCourseDetail(context, course),
              child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Title
                    Text(
                      course['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A1D92),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Custom Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: course['progress'], // Progress value
                        minHeight: 12,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(course['color']),
                      ),
                    ),

                    // Progress Label
                    const SizedBox(height: 8),
                    Text(
                      "${(course['progress'] * 100).toInt()}% Completed",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
