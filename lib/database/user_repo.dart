import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_learning_app/database/user_model.dart';


class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;

  Future<void> createUser(BuildContext context, UserModel user, String password) async {
    try {
      // Check if the email already exists
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(user.email);

      if (signInMethods.isNotEmpty) {
        // Email already exists, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "The email address is already in use. Please use a different email.",
            ),
            backgroundColor: Colors.red,
          ),
        );
        return; // Stop further execution
      }

      // Create the user using Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // Get the authenticated user's UID
      String uid = userCredential.user!.uid;

      // Set the user data in Firestore using the UID as the document ID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .set(user.toJson())
          .whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your account has been created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    } catch (error) {
      // Handle any errors during authentication or Firestore operations
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong: ${error.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Fetch user by email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final querySnapshot =
          await db.collection("Users").where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.fromJson(querySnapshot.docs.first.data());
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user data",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(e.toString());
    }

    return null;
  }
}
