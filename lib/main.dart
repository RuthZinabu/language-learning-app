import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:language_learning_app/database/user_repo.dart';
import 'package:language_learning_app/pages/choose_lang/current_lang.dart';
import 'package:language_learning_app/pages/home_page/home_screen.dart';
import 'package:language_learning_app/pages/learning_levels/courses.dart';
import 'package:language_learning_app/pages/learning_levels/numAlphabet.dart';
import 'package:language_learning_app/pages/login_signUp/login.dart';
import 'package:language_learning_app/pages/login_signUp/signup.dart';
import 'package:language_learning_app/pages/onboarding_Page.dart';
import 'package:language_learning_app/pages/profile_page/profile_screen.dart';
import 'package:language_learning_app/pages/splash_Page.dart';
import 'package:go_router/go_router.dart';
import 'package:language_learning_app/pages/translator_page/translation.dart';

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
  Get.put(UserRepository());
  runApp(const LanguageApp());
}

class LanguageApp extends StatelessWidget {
  const LanguageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: '/sign-up',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/courses',
          builder: (context, state) => const Courses(),
        ),
        GoRoute(
          path: '/number-alpha',
          builder: (context, state) => NumberScreen(),
        ),
        GoRoute(
          path: '/translate',
          builder: (context, state) => const TranslationPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfilePage(
            userFirstName: '',
          ),
        ),
        GoRoute(
          path: '/current-language-selection',
          builder: (context, state) => const CurrentLanguageSelectionScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
