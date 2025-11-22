import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get auth => _auth;
  Future<User?> signInWithGoogle() async {
    if (FirebaseAuth.instance.app.options.projectId == null) return null;

   
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final userCredential = await _auth.signInWithPopup(googleProvider);
      return userCredential.user;
  }
   Future<User?> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    githubProvider.addScope("read:user");
    githubProvider.setCustomParameters({'allow_signup': 'false'});

    final credential = await _auth.signInWithPopup(githubProvider);
    return credential.user;
  }
}
