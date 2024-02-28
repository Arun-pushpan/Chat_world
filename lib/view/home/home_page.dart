

import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:chat_with_friends/controller/services/chat_api.dart';
import 'package:chat_with_friends/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/sizedbox.dart';
import '../../widget/usertile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final ChatApi _chatApi = ChatApi();
  final AuthService _authService = AuthService();

   // build a list of users except for the current logged in user
   Widget _buildUserList(){

     return  StreamBuilder(
         stream: _chatApi.getUsersStream(),
         builder: (context, snapshot){
           //error
           if(snapshot.hasError){
             return const Text("Error");
           }
           //loading..
           if(snapshot.connectionState == ConnectionState.waiting){
             return const Text("Loading...");
           }
           // return list view
           print("Snapshot Data: ${snapshot.data}");
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: ListView(
               children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context)).toList(),
             ),
           );
         });

   }

   // build individual list tile for user
   Widget _buildUserListItem(Map<String,dynamic> userData,BuildContext context){
     // display all users except current user
     if(userData['email'] != _authService.getCurrentUser()!.email){
       return UserTile(
         text: userData['name'],

         onTap: () {
           Navigator.push(context,
               MaterialPageRoute(builder: (context)=>ChatPage(
                 receiverName: userData['name'], receiverID: userData['uid'],)));
         }, );
     }else{
       return const SizedBox();
     }

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("C H A T  W O R L D",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        foregroundColor: Colors.grey.shade700,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),

    );
  }

}
