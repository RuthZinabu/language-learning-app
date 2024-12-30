import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// final GoogleSignIn _googleSignIn = GoogleSignIn(
//   clientId: dotenv.env['client_id'] ?? '',
// );

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the currently signed-in user
  User? get currentUser => _auth.currentUser;

  /// Sign up with email and password
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message ?? 'An unknown error occurred during sign-up.',
      );
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Log in with email and password
  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message ?? 'An unknown error occurred during login.',
      );
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Log out the currently signed-in user
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message ??
            'An unknown error occurred while sending the reset email.',
      );
    }
  }

  /// Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Initialize Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: dotenv.env['client_id'] ?? '',
      );

      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in process
        throw Exception('Google Sign-In was cancelled.');
      }

      // Get the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
  }
}
