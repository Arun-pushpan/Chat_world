import 'dart:io';

import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/home/home_page.dart';

class Api {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in

  login(BuildContext context, email, password) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  // sign up

  register(BuildContext context, email, password, cPassword, name, phoneNo, img,) {
    final _auth = AuthService();
    if (password == cPassword) {
      try {
        _auth
            .signUpWithEmailPassword(email, password, name, phoneNo,img)
            .then((value) => Future.delayed(const Duration(milliseconds: 500)))
            .then((value) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage())));
      } catch (e) {
        print(e.toString());
        // showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //           title: Text(e.toString()),
        //         ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Password don't match"),
              ));
    }
  }

  // sign Out
  logout()async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear SharedPreferences data on logout
    await prefs.clear();
    await _auth.signOut();
    _auth.signOut();
  }







}
