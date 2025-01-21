import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_learning_app/database/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;
  

  createUser(UserModel user) async {
    try {
      // First, create the user using Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user
            .email, // assuming you are using an email and password for authentication
        password: user.password, // assuming this field is present
      );

      // Now, get the authenticated user's UID
      String uid = userCredential.user!.uid;

      // Set the user data in Firestore using the UID as the document ID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid) // Use UID as document ID
          .set(user
              .toJson()) // Convert user model to JSON and store in Firestore
          .whenComplete(() {
        // Show a success message
        Get.snackbar(
          "Success",
          "Your account has been created.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      });
    } catch (error) {
      // Handle any errors during authentication or Firestore operations
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error: ${error.toString()}");
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
