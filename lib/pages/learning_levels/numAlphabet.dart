import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumberScreen extends StatefulWidget {
  final String title;
  final String currentLanguage;
  final String targetLanguage;

  NumberScreen({
    Key? key,
    required this.currentLanguage,
    required this.targetLanguage,
    required this.title,
  }) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  int currentNumber = 1;  
  final List<String> numberWords = [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten"
  ];

  final GoogleTranslator _translator = GoogleTranslator();
  final FlutterTts _flutterTts = FlutterTts();

  String translatedNumber = "one";

  final Map<String, String> languageCodeMapping = {
    'English': 'en',
    'French': 'fr',
    'Spanish': 'es',
    'German': 'de',
    'Hindi': 'hi',
    'Korean': 'ko',
    'Italian': 'it',
    'Amharic': 'am',
  };

  @override
  void initState() {
    super.initState();
    _translateNumber();
  }

  void incrementNumber() {
    setState(() {
      if (currentNumber < 10) {
        currentNumber++;
        _translateNumber();
      }
    });
  }

  void decrementNumber() {
    setState(() {
      if (currentNumber > 1) {
        currentNumber--;
        _translateNumber();
      }
    });
  }

  String getLanguageCode(String languageName) {
    return languageCodeMapping[languageName] ?? 'en'; 
  }

  Future<void> _translateNumber() async {
    final targetLanguageCode = getLanguageCode(widget.targetLanguage);
    final word = numberWords[currentNumber - 1];

    try {
      final translation = await _translator.translate(
        word,
        from: 'en',
        to: targetLanguageCode,
      );
      setState(() {
        translatedNumber = translation.text;
      });
    } catch (e) {
      setState(() {
        translatedNumber = "Translation not available";
      });
    }
  }

  Future<void> _speak() async {
    final targetLanguageCode = getLanguageCode(widget.targetLanguage);
    await _flutterTts.setLanguage(targetLanguageCode);
    await _flutterTts.speak(translatedNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC), // Light blue background color
      body: Stack(
        children: [
          // Back button
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/back-cloud.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
          // Home button
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/home-cloud.png',
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Number in red
                Text(
                  "$currentNumber",
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                // Translated word
                Text(
                  translatedNumber,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50),
                // Arrows and Music Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: decrementNumber,
                      child: Image.asset(
                        'assets/images/back-arrow.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GestureDetector(
                      onTap: _speak,
                      child: Image.asset(
                        'assets/images/music.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    GestureDetector(
                      onTap: incrementNumber,
                      child: Image.asset(
                        'assets/images/forward-arrow.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
