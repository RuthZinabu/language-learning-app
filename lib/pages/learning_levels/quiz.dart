import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:language_learning_app/pages/home_page/home_screen.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LanguageLearningQuiz extends StatefulWidget {
  const LanguageLearningQuiz({super.key});

  @override
  _LanguageLearningQuizState createState() => _LanguageLearningQuizState();
}

class _LanguageLearningQuizState extends State<LanguageLearningQuiz> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  late List<Map<String, Object>> _questions;
  final FlutterTts _flutterTts = FlutterTts();
  final GoogleTranslator _translator = GoogleTranslator();

  // Set to track favorite questions
  final Set<int> favoriteSet = {};

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    // Replace with real translations for dynamic questions
    _questions = [
      {
        "question": "Translate 'Hello' into French:",
        "options": ["Bonjour", "Hola", "Hallo", "Ciao"],
        "answer": 0,
        "target": "Bonjour",
      },
      {
        "question": "Translate 'Thank you' into Spanish:",
        "options": ["Gracias", "Merci", "Danke", "Grazie"],
        "answer": 0,
        "target": "Gracias",
      },
      {
        "question": "What is the plural of 'apple' in English?",
        "options": ["Apples", "Apple", "Appeless", "Applez"],
        "answer": 0,
        "target": "Apples",
      },
    ];
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.speak(text);
  }

  void _answerQuestion(int selectedOption) {
    if (selectedOption == _questions[_currentQuestionIndex]["answer"]) {
      _score++;
    }

    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Quiz"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: _currentQuestionIndex < _questions.length
          ? _buildQuizContent()
          : _buildResultContent(),
    );
  }

  Widget _buildQuizContent() {
    final question = _questions[_currentQuestionIndex] as Map<String, dynamic>;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Question ${_currentQuestionIndex + 1} of ${_questions.length}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            question["question"] as String,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            (question["options"] as List<String>).length,
            (index) {
              String option = question["options"]![index];
              return ElevatedButton(
                onPressed: () => _answerQuestion(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(option, textAlign: TextAlign.center),
              );
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () => _speak(question["target"] as String),
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: favoriteSet.contains(_currentQuestionIndex)
                      ? Colors.red
                      : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (favoriteSet.contains(_currentQuestionIndex)) {
                      favoriteSet.remove(_currentQuestionIndex);
                    } else {
                      favoriteSet.add(_currentQuestionIndex);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Quiz Completed!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Your Score: $_score/${_questions.length}",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
                favoriteSet.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Restart Quiz",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
