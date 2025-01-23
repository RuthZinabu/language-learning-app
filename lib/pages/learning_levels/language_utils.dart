final Map<String, String> languageCodeMapping = {
  'English': 'en',
  'French': 'fr',
  'Spanish': 'es',
  'German': 'de',
  'Hindi': 'hi',
  'Korean': 'ko',
  'Italian': 'it',
  'Amharic': 'am',
  // Add more languages as needed
};

/// Retrieves the language code for a given language name.
String getLanguageCode(String? languageName) {
  return languageCodeMapping[languageName] ?? 'en';
}
