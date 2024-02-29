import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class AuthService {
  // instance of auth

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? uid;



  // get current user

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in

  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // save user info if it doesn't already exist
      _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, "email": email});
      prefs.setString('email', email);
      prefs.setString('uid', userCredential.user!.uid);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up

  Future<UserCredential> signUpWithEmailPassword(
      String email, password, name, phoneno, img,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await prefs.setString('email', email);
      await prefs.setString('name', name);
      await prefs.setString('phoneNo', phoneno);
      await prefs.setString('uid', userCredential.user!.uid);
      // save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        "email": email,
        "name": name,
        "phone no": phoneno,
        "img":img,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear SharedPreferences data on logout
    await prefs.clear();
    // Sign out from Firebase
    await _auth.signOut();
  }


  Stream<DocumentSnapshot> getCurrentUserDetails() {
    String? uid=_auth.currentUser!.uid;
    return _firestore.collection('Users').doc(uid).snapshots();
  }

  // errors
}
