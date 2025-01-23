import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:language_learning_app/pages/home_page/home_screen.dart';
import 'package:language_learning_app/pages/learning_levels/language_utils.dart';
import 'package:translator/translator.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final translator = GoogleTranslator();

  String _inputText = '';
  String _translatedText = '';

  void _translate() async {
    if (_inputText.isEmpty) return;

    String targetLanguageCode = getLanguageCode(targetLanguage!);

    Translation translation =
        await translator.translate(_inputText, to: targetLanguageCode);
    setState(() {
      _translatedText = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: const Text('Translator'),
        backgroundColor: const Color(0xFF410FA3),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                //get input from the user to translate
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter text to translate',
                    labelStyle: TextStyle(),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 20, 217, 231), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 18),
                  onChanged: (value) {
                    setState(() {
                      _inputText = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            //button to translate the text
            ElevatedButton(
              onPressed: _translate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 20, 217, 231),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Translate',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30.0),
            if (_translatedText.isNotEmpty)
              Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Translated Text:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 20, 217, 231),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        _translatedText,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
