import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:language_learning_app/pages/splash_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyALI7blhv7auaSQhhj5cC3lRqgWMw2vWIg",
            authDomain: "language-learning-app-b3181.firebaseapp.com",
            projectId: "language-learning-app-b3181",
            storageBucket: "language-learning-app-b3181.firebasestorage.app",
            messagingSenderId: "216855887697",
            appId: "1:216855887697:web:f5e5a73fef8200343ddd70",
            measurementId: "G-CBMWWKK566"));
  } else {
    Firebase.initializeApp();
  }

  runApp(const LanguageApp());
}

class LanguageApp extends StatelessWidget {
  const LanguageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
