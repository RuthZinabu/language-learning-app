import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  Future<void> saveTargetLang(String userId, String targetLanguage) async {
    try {
      // Use the set method to create or update the document
      await FirebaseFirestore.instance.collection('Users').doc(userId).set(
        {
          'targetLanguage': targetLanguage,
        },
        SetOptions(
            merge:
                true), // Merge updates the existing fields without overwriting the entire document
      );
      print('Target language saved: $targetLanguage');
    } catch (e) {
      print('Error saving target language: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save target language. Please try again.'),
        ),
      );
    }
  }

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
            context.go('/current-language-selection');
          },
        ),
        title: const Text(
          'Select Target Language',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LanguageSelector(
              title: 'What language do you want to learn?',
              languages: languages,
              selectedLanguage: selectedTargetLanguage,
              onLanguageSelected: (selected) {
                setState(() {
                  selectedTargetLanguage = selected;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                // Get the logged-in user's ID
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  // Save the current language to Firestore
                  await saveTargetLang(user.uid, selectedTargetLanguage);

                  // ignore: use_build_context_synchronously
                  context.go('/home');
                } else {
                  // Show an error if the user is not logged in
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User not logged in. Please log in again.'),
                    ),
                  );
                }
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
