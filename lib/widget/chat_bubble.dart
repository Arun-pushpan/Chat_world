import 'package:chat_with_friends/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context,listen :false).isDarkMode;

    return Container(
      decoration: BoxDecoration(

        color:
        isCurrentUser
            ?(isDarkMode? Colors.white.withOpacity(0.9):Colors.grey.withOpacity(0.8))
            : (isDarkMode? Colors.grey.withOpacity(0.2):Colors.grey.withOpacity(0.2))
       ,
        borderRadius: BorderRadius.circular(16)
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
      child: Text(message,style: TextStyle(

          color:isCurrentUser? (isDarkMode? Colors.black.withOpacity(0.8):Colors.black):( isDarkMode? Colors.white.withOpacity(0.9):Colors.black)
          ,fontWeight: FontWeight.w400),),
    );
  }
}
