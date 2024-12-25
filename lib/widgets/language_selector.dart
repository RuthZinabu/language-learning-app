import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String title;
  final List<Map<String, String>> languages;
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const LanguageSelector({
    Key? key,
    required this.title,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 300, // Set a fixed height for the ListView
          child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              return GestureDetector(
                onTap: () => onLanguageSelected(language['name']!),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: selectedLanguage == language['name']
                        ? const Color(0xFF5BA890)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selectedLanguage == language['name']
                          ? const Color(0xFF410FA3)
                          : Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          language['flag']!,
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        language['name']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: selectedLanguage == language['name']
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
