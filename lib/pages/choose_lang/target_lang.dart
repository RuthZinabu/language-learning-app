import 'package:flutter/material.dart';
import 'package:language_learning_app/pages/home_page/home_screen.dart';
import 'package:language_learning_app/widgets/language_selector.dart';

class TargetLanguageSelectionScreen extends StatefulWidget {
  final String currentLanguage;

  const TargetLanguageSelectionScreen({Key? key, required this.currentLanguage})
      : super(key: key);

  @override
  _TargetLanguageSelectionScreenState createState() =>
      _TargetLanguageSelectionScreenState();
}

class _TargetLanguageSelectionScreenState
    extends State<TargetLanguageSelectionScreen> {
  String selectedTargetLanguage = 'French';

  final List<Map<String, String>> languages = [
    {"name": "English", "flag": "assets/flags/us.png"},
    {"name": "French", "flag": "assets/flags/fr.png"},
    {"name": "German", "flag": "assets/flags/de.png"},
    {"name": "Hindi", "flag": "assets/flags/in.png"},
    {"name": "Korean", "flag": "assets/flags/kr.png"},
    {"name": "Italian", "flag": "assets/flags/it.png"},
    {"name": "Amharic", "flag": "assets/flags/et.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF410FA3),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Select Target Language',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          LanguageSelector(
            title: 'What language do you want to learn?',
            languages: languages,
            selectedLanguage: selectedTargetLanguage,
            onLanguageSelected: (selected) {
              setState(() {
                selectedTargetLanguage = selected;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      currentLanguage: widget.currentLanguage,
                      targetLanguage: selectedTargetLanguage,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF410FA3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
