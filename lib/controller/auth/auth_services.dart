import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class AuthService {
 /// instance of auth

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? uid;



  /// get current user

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// sign in

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

  /// sign up

  Future<UserCredential> signUpWithEmailPassword(
      String email, password, name, phoneno, Uint8List file,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await prefs.setString('email', email);
      await prefs.setString('name', name);
      await prefs.setString('phoneNo', phoneno);
      await prefs.setString('uid', userCredential.user!.uid);

      // save user info in a separate doc
      if (file != null) {
        // Upload image to Firebase Storage
        String imageUrl= await uploadImageToStore("profileImage", file);

          // Save the user info to Firestore with the image URL
          await _firestore.collection("Users").doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'email': email,
            'name': name,
            'phoneNo': phoneno,
            'imageLink': imageUrl
            // Store the image URL instead of the image itself
          });

      } else {
        // Save user info to Firestore without image
        await _firestore.collection("Users").doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'name': name,
          'phoneNo': phoneno,
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message); // Provide a more descriptive error message
    }
  }

  /// update user details

  Future<void> upDateDetails(String name,phone,Uint8List img)async{
    try{
      User? user = FirebaseAuth.instance.currentUser;
      if(img !=null){
        String imageUrl= await uploadImageToStore("profileImage", img);
        await FirebaseFirestore.instance.collection("Users").doc(user?.uid).update({
          'name': name,
          'phoneNo': phone,
          'imageLink': imageUrl,
        });
      }else {
        await FirebaseFirestore.instance.collection("Users")
            .doc(user?.uid)
            .update({
          'name': name,
          'phoneNo': phone,
        });
      }
    }on FirebaseAuthException catch (e) {
      throw Exception(e.message); // Provide a more descriptive error message
    }
  }





  /// sign out

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
  /// store image

 Future<String> uploadImageToStore(String childName,Uint8List file) async {

    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
 }

  /// errors
}
