import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:language_learning_app/pages/splash_Page.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: dotenv.env['API_KEY'] ?? '',
            authDomain: dotenv.env['authDomain'] ?? '',
            projectId: dotenv.env['projectId'] ?? '',
            storageBucket: dotenv.env['storageBucket'] ?? '',
            messagingSenderId: dotenv.env['messagingSenderId'] ?? '',
            appId: dotenv.env['appId'] ?? '',
            measurementId: dotenv.env['measurementId'] ?? ''));
  } else {
    await Firebase.initializeApp();
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
