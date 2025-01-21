import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:language_learning_app/pages/login_signUp/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.loginWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Check Firestore for language preferences
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .where("email", isEqualTo: _emailController.text.trim())
            .limit(1)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first);
        if (userDoc.exists) {
          final data = userDoc.data();
          if (data['currentLanguage'] != null &&
              data['targetLanguage'] != null) {
            // If languages are already selected, redirect to HomeScreen
            // ignore: use_build_context_synchronously
            context.go(
              '/home', // Replace '/home' with your actual home route
              extra: {
                'currentLanguage': data['currentLanguage'],
                'targetLanguage': data['targetLanguage'],
              },
            );
          } else {
            // If no languages are selected, redirect to language selection
            context.go('/current-language-selection');
          }
        }
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          default:
            errorMessage = 'An error occurred. Please try again.';
        }
      }
      print("Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithGoogle();
      setState(() {
        _isLoading = false;
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Check Firestore for language preferences
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          final data = userDoc.data();
          if (data != null &&
              data['currentLanguage'] != null &&
              data['targetLanguage'] != null) {
            // If languages are already selected, redirect to HomeScreen
            context.go(
              '/home',
              extra: {
                'currentLanguage': data['currentLanguage'],
                'targetLanguage': data['targetLanguage'],
              },
            );
          } else {
            // If no languages are selected, redirect to language selection
            context.go('/current-language-selection');
          }
        }
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to login with Google. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email Address",
                hintText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                suffixIcon: const Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF410FA3),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Or",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _isLoading ? null : _loginWithGoogle,
                        icon: Image.asset('assets/images/google.png'),
                        iconSize: 40,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          // Add Facebook login functionality here
                        },
                        icon: Image.asset('assets/images/facebook.png'),
                        iconSize: 40,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(
                            color: Color(0xFF410FA3),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/sign-up');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
