import 'package:flutter/material.dart';
import 'package:language_learning_app/pages/choose_lang/target_lang.dart';
import 'package:language_learning_app/widgets/language_selector.dart';

class CurrentLanguageSelectionScreen extends StatefulWidget {
  const CurrentLanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _CurrentLanguageSelectionScreenState createState() =>
      _CurrentLanguageSelectionScreenState();
}

class _CurrentLanguageSelectionScreenState
    extends State<CurrentLanguageSelectionScreen> {
  String selectedCurrentLanguage = 'English';

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
          'Select Current Language',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          LanguageSelector(
            title: 'What is your current language?',
            languages: languages,
            selectedLanguage: selectedCurrentLanguage,
            onLanguageSelected: (selected) {
              setState(() {
                selectedCurrentLanguage = selected;
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
                    builder: (context) => TargetLanguageSelectionScreen(
                      currentLanguage: selectedCurrentLanguage,
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
