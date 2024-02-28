import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Api{

  // sign in

   login(BuildContext context,email,password) async {
    final authService = AuthService();

    try{
      await authService.signInWithEmailPassword(email, password);

    }
    catch(e){
      showDialog(context: context,
          builder: (context)=>AlertDialog(
            title: Text(e.toString()),
          ));
    }
  }

  // sign up

   register(BuildContext context,email,password,cPassword,name,phoneNo){

     final _auth = AuthService();
     if(password == cPassword){
       try{
         _auth.signUpWithEmailPassword(email, password,name,phoneNo);
       }catch(e){
         showDialog(context: context,
             builder: (context)=>AlertDialog(
               title: Text(e.toString()),
             ));
       }
     }else{
       showDialog(context: context,
           builder: (context)=>const AlertDialog(
             title: Text("Password don't match"),
           ));
     }

   }

  // sign Out

  logout() {
     final _auth = AuthService();
     _auth.signOut();
  }


}