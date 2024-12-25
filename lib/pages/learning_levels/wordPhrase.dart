import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordPhrasePage extends StatefulWidget {
  final String title;
  final String currentLanguage;
  final String targetLanguage;

  WordPhrasePage({
    Key? key,
    required this.currentLanguage,
    required this.targetLanguage,
    required this.title,
  }) : super(key: key);

  @override
  _WordPhrasePageState createState() => _WordPhrasePageState();
}

class _WordPhrasePageState extends State<WordPhrasePage> {
  final List<Map<String, String>> words = [
    {'word': 'Hello', 'translation': ''},
    {'word': 'Goodbye', 'translation': ''},
    {'word': 'Please', 'translation': ''},
    {'word': 'Thank you', 'translation': ''},
    {'word': 'Yes', 'translation': ''},
    {'word': 'No', 'translation': ''},
    // more words
  ];
  final List<Map<String, String>> phrases = [
    {'word': 'Be careful', 'translation': ''},
    {'word': 'Good idea', 'translation': ''},
    {'word': 'I feel good', 'translation': ''},
    {'word': 'I am hungry', 'translation': ''},
    {'word': 'Never mind', 'translation': ''},
    {'word': 'Try it', 'translation': ''},
    // more phrases
  ];

  final FlutterTts _flutterTts = FlutterTts();
  final GoogleTranslator _translator = GoogleTranslator();

  final Map<String, String> languageCodeMapping = {
    'English': 'en',
    'French': 'fr',
    'Spanish': 'es',
    'German': 'de',
    'Hindi': 'hi',
    'Korean': 'ko',
    'Italian': 'it',
    'Amharic': 'am',
    // Add more mappings as needed
  };

  String getLanguageCode(String languageName) {
    return languageCodeMapping[languageName] ?? 'en'; // Default to English
  }

  @override
  void initState() {
    super.initState();
    _fetchTranslations();
  }

  Future<void> _fetchTranslations() async {
    final fromLanguageCode = getLanguageCode(widget.currentLanguage);
    final toLanguageCode = getLanguageCode(widget.targetLanguage);

    for (var word in words) {
      try {
        final translation = await _translator.translate(
          word['word']!,
          from: fromLanguageCode,
          to: toLanguageCode,
        );
        setState(() {
          word['translation'] = translation.text;
        });
      } catch (e) {
        setState(() {
          word['translation'] = 'Translation not available';
        });
        print('Error translating word "${word['word']}": $e');
      }
    }

    for (var phrase in phrases) {
      try {
        final translation = await _translator.translate(
          phrase['word']!,
          from: fromLanguageCode,
          to: toLanguageCode,
        );
        setState(() {
          phrase['translation'] = translation.text;
        });
      } catch (e) {
        setState(() {
          phrase['translation'] = 'Translation not available';
        });
        print('Error translating phrase "${phrase['word']}": $e');
      }
    }
  }

  Future<void> _speak(String text) async {
    final languageCode = getLanguageCode(widget.targetLanguage);
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.title} - ${widget.currentLanguage} to ${widget.targetLanguage}'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: words.length + phrases.length,
        itemBuilder: (context, index) {
          if (index < words.length) {
            final wordPhrase = words[index];
            return _buildWordPhraseCard(
                wordPhrase['word']!, wordPhrase['translation']!);
          } else {
            final phraseIndex = index - words.length;
            final wordPhrase = phrases[phraseIndex];
            return _buildWordPhraseCard(
                wordPhrase['word']!, wordPhrase['translation']!);
          }
        },
      ),
    );
  }

  Widget _buildWordPhraseCard(String word, String translation) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  translation,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {
                _speak(translation);
              },
            ),
          ],
        ),
      ),
    );
  }
}
