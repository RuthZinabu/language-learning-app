import 'package:flutter/material.dart';
import 'package:language_learning_app/pages/learning_levels/wordPhrase.dart';
import 'package:language_learning_app/pages/learning_levels/numAlphabet.dart';

class Courses extends StatefulWidget {
  final String currentLanguage;
  final String targetLanguage;

  const Courses({
    Key? key,
    required this.currentLanguage,
    required this.targetLanguage,
  }) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  int selectedLevel = 0;

  final Map<int, List<String>> levelOptions = {
    1: [
      'Common Expressions',
      'Greetings',
      'Travel/Directions',
      'Numbers and Money'
    ],
    2: ['Accommodation', 'Phone/Internet', 'Time & Date', 'Location'],
    3: ['Dining', 'Making Friends', 'Entertainment', 'Shopping'],
    4: ['Work', 'Emergency & Health', 'General Questions', 'Weather'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${widget.currentLanguage} to ${widget.targetLanguage}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.blue[50]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLevelButton(1),
              _buildLevelButton(2),
              _buildLevelButton(3),
              _buildLevelButton(4),
            ],
          ),
          Expanded(
            child: _buildLevelContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelButton(int level) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedLevel = level;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedLevel == level ? const Color(0xFF410FA3) : Colors.grey,
        ),
        child: Text('Level $level'),
      ),
    );
  }

  Widget _buildLevelContent() {
    if (selectedLevel == 0) {
      return const Center(
        child: Text('Select a level'),
      );
    }

    return Container(
      color: Colors.blue[50], // Change the background color
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: levelOptions[selectedLevel]!
            .map((option) => _buildOptionCard(option))
            .toList(),
      ),
    );
  }

  Widget _buildOptionCard(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        onTap: () {
          _showBottomDrawer(title);
        },
      ),
    );
  }

  void _showBottomDrawer(String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          child: Container(
            color: const Color.fromARGB(
                255, 82, 23, 201), // Set the background color to blue
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildWordPhraseCard(
                    'Words and Phrases',
                    'Practice your words and phrases with comparing and listening',
                    context,
                  ),
                  const SizedBox(height: 10),
                  _buildWordPhraseCard(
                    'Alphabet and Numbers',
                    'Practice your alpabets with comparing and listening',
                    context,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWordPhraseCard(
      String title, String description, BuildContext context) {
    return Card(
      color: Colors.white, // Set the card background color to white
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (title == 'Alphabet and Numbers') {
                  // Navigate to NumberScreen if the second button is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NumberScreen(
                         title: title,
                        currentLanguage: widget.currentLanguage,
                        targetLanguage: widget.targetLanguage,
                      ),
                    ),
                  );
                } else {
                  // Navigate to WordPhrasePage for other buttons
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WordPhrasePage(
                        title: title,
                        currentLanguage: widget.currentLanguage,
                        targetLanguage: widget.targetLanguage,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
