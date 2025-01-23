import 'package:flutter/material.dart';
import 'package:language_learning_app/pages/home_page/favorites_screen.dart';
import 'package:language_learning_app/pages/home_page/home_screen.dart';
import 'package:language_learning_app/pages/learning_levels/language_utils.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordPhrasePage extends StatefulWidget {
  final String title;
  final String? currentLanguage;
  final String? targetLanguage;

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
  String currentLanguageCode = 'en';
  String targetLanguageCode = 'fr';
  final FlutterTts _flutterTts = FlutterTts();
  final GoogleTranslator _translator = GoogleTranslator();

  final List<String> englishWords = [
    'Hello',
    'Goodbye',
    'Please',
    'Thank you',
    'Yes',
    'No',
  ];

  final List<String> englishPhrases = [
    'Be careful',
    'Good idea',
    'I feel good',
    'I am hungry',
    'Never mind',
    'Try it',
  ];

  List<Map<String, String>> translatedWords = [];
  List<Map<String, String>> translatedPhrases = [];

  // Set to track favorite items
  final Set<String> favoriteSet = {};

  @override
  void initState() {
    super.initState();
    currentLanguageCode = getLanguageCode(currentLanguage!);
    targetLanguageCode = getLanguageCode(targetLanguage!);
    _fetchTranslations();
  }

  Future<void> _fetchTranslations() async {
    final fromLanguageCode = getLanguageCode('English');

    for (var word in englishWords) {
      try {
        final currentTranslation = widget.currentLanguage == 'English'
            ? word
            : (await _translator.translate(
                word,
                from: fromLanguageCode,
                to: currentLanguageCode,
              ))
                .text;

        final targetTranslation = await _translator.translate(
          currentTranslation,
          from: widget.currentLanguage == 'English'
              ? fromLanguageCode
              : currentLanguageCode,
          to: targetLanguageCode,
        );

        setState(() {
          translatedWords.add({
            'word': currentTranslation,
            'translation': targetTranslation.text,
          });
        });
      } catch (e) {
        setState(() {
          translatedWords.add({
            'word': word,
            'translation': 'Translation not available',
          });
        });
        print('Error translating word "$word": $e');
      }
    }

    for (var phrase in englishPhrases) {
      try {
        final currentTranslation = widget.currentLanguage == 'English'
            ? phrase
            : (await _translator.translate(
                phrase,
                from: fromLanguageCode,
                to: currentLanguageCode,
              ))
                .text;

        final targetTranslation = await _translator.translate(
          currentTranslation,
          from: widget.currentLanguage == 'English'
              ? fromLanguageCode
              : currentLanguageCode,
          to: targetLanguageCode,
        );

        setState(() {
          translatedPhrases.add({
            'word': currentTranslation,
            'translation': targetTranslation.text,
          });
        });
      } catch (e) {
        setState(() {
          translatedPhrases.add({
            'word': phrase,
            'translation': 'Translation not available',
          });
        });
        print('Error translating phrase "$phrase": $e');
      }
    }
  }

  Future<void> _speak(String text) async {
    final languageCode = getLanguageCode(widget.targetLanguage!);
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: translatedWords.length + translatedPhrases.length,
        itemBuilder: (context, index) {
          if (index < translatedWords.length) {
            final wordPhrase = translatedWords[index];
            return _buildWordPhraseCard(
                wordPhrase['word']!, wordPhrase['translation']!);
          } else {
            final phraseIndex = index - translatedWords.length;
            final wordPhrase = translatedPhrases[phraseIndex];
            return _buildWordPhraseCard(
                wordPhrase['word']!, wordPhrase['translation']!);
          }
        },
      ),
    );
  }

  Widget _buildWordPhraseCard(String word, String translation) {
    final isFavorite = favoriteSet.contains(word);
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
            const Spacer(), // Push icons to the far right
            IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {
                _speak(translation);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoriteSet.remove(word);
                    favoriteItems.value.removeWhere((item) =>
                        item['word'] == word &&
                        item['translation'] == translation);
                  } else {
                    favoriteSet.add(word);
                    favoriteItems.value
                        .add({'word': word, 'translation': translation});
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isFavorite
                        ? '$word removed from favorites'
                        : '$word added to favorites'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
