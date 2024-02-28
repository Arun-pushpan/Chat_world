import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/sizedbox.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A B O U T"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              s2,
              Text(
                "About Chat World",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              s1,
              Text(
                "Welcome to Chat World the ultimate platform for seamless"
                " communication and connection. Our app is designed to bring "
                "people together, making it easier than ever to stay in touch "
                "with friends, family, and colleagues no matter where they are"
                " in the world.",
                overflow: TextOverflow.clip,
              ),
              s2,
              Text(
                "Key Features:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              s1,
              Text("* Instant Messaging: Enjoy lightning-fast, real-time "
                  "messaging with your contacts. Say goodbye to delays and "
                  "experience smooth and instant communication.  "),
              s1,
              Text(
                  "* Multimedia Sharing: Share photos, videos, and voice messages"
                  " effortlessly. Express yourself with more than just words."),
              s1,
              Text(
                  "* Group Chats: Create and join groups to chat with multiple "
                  "friends at once. Stay connected with your circles, whether "
                  "they're small groups of friends or larger community discussions."),
              s1,
              Text(
                  "* Emojis and Stickers: Add a touch of fun and emotion to your "
                  "conversations with a vast collection of emojis and stickers. "
                  "Express yourself in a way words alone can't convey."),
              s1,
              Text(
                  "* Customizable Themes: Personalize your chat experience with "
                  "a variety of themes and backgrounds. Choose the look that "
                  "suits your style."),
              s3,
              Text(
                "Your Privacy Matters:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              s1,
              Text("We understand the importance of privacy in your online "
                  "interactions. Chat World prioritizes user security,"
                  " offering end-to-end encryption for all messages to ensure "
                  "that your conversations remain private and secure."),
              s2,
              Text(
                "Stay Connected, Anytime, Anywhere:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              s1,
              Text("With Chat World, distance is no longer a barrier."
                  " Our app is available on multiple platforms, allowing you to "
                  "stay connected on your smartphone, tablet, or desktop. "
                  "Seamlessly switch between devices without missing a beat."),
              s2,
              Text(
                "Contact Us:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              s1,
              Text("We value your feedback! If you have any questions, "
                  "suggestions, or encounter any issues, please feel free to "
                  "reach out to our support team at [chatworld@gmail.com]. "
                  "Your input helps us improve and enhance your chat experience."),
              s2,
              Text(
                  "Thank you for choosing Chat World. Let the conversations begin!"),
              s5,
            ],
          ),
        ),
      ),
    );
  }
}
