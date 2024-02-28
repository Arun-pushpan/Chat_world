

import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:chat_with_friends/controller/services/chat_api.dart';
import 'package:chat_with_friends/widget/chat_bubble.dart';
import 'package:chat_with_friends/widget/cusrtom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/sizedbox.dart';

class ChatPage extends StatelessWidget {
  final String receiverName;
  final String receiverID;
    ChatPage({super.key,required this.receiverName, required this.receiverID});

   // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatApi _chatApi = ChatApi();
  final AuthService _authService = AuthService();


  //send message
  void sendMessage()async {
    // if there is something inside the text-field
    if(_messageController.text.isNotEmpty){
      //send the message
      await _chatApi.sendMessage(receiverID, _messageController.text);
      //clear text controller
      _messageController.clear();
    }
  }


  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatApi.getMessages(receiverID, senderID),
        builder: (context,snapshot){
          //error
          if(snapshot.hasError){
            return const Text("Error");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: Text("Loading....."));
          }
          return ListView(
            children:snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        });
  }
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic > data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser  = data ['senderID'] == _authService.getCurrentUser()!.uid;
    //align message to the right if sender is the current user, otherwise left
    var alignment = isCurrentUser?Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
        child: ChatBubble(
            message: data['message'],
            isCurrentUser: isCurrentUser)
        //Text(data['message'])
    );
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
                child: AttractiveTextFormField(
                  controller: _messageController,
                  hintText: 'Type a message',
                ),
              // child: CustomTextField(
              //     controller: _messageController,
              //     hintText: "Type a message")
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8)
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.send,size: 20,color: Colors.black,)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 15,
              child: Icon(Icons.person), // Replace with your desired icon
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(receiverName,
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontSize: 18,fontWeight: FontWeight.w700),),
                 Text(
                  'last seen today at 12:34 PM',
                  style: TextStyle(fontSize: 8,color: Theme.of(context).colorScheme.inversePrimary,),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              // Handle video call button pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Handle voice call button pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options button pressed
            },
          ),
        ],
      ),
      // appBar: AppBar(
      //
      //   title: const Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'John Doe',
      //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //       ),
      //       Text(
      //         'last seen today at 12:34 PM',
      //         style: TextStyle(fontSize: 12),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.videocam),
      //       onPressed: () {
      //         // Handle video call button pressed
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.call),
      //       onPressed: () {
      //         // Handle voice call button pressed
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.more_vert),
      //       onPressed: () {
      //         // Handle more options button pressed
      //       },
      //     ),
      //   ],
      // ),
        // Text(receiverName,
        //   style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontSize: 18,fontWeight: FontWeight.w700),),
      body:Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
           Expanded(
               child:_buildMessageList()),
            _buildUserInput(),
          ],
        ),
      ) ,
    );
  }

}
