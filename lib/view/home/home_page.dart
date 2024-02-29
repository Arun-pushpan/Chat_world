import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:chat_with_friends/controller/services/chat_api.dart';
import 'package:chat_with_friends/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/sizedbox.dart';
import '../../model/user_model.dart';
import '../../widget/usertile.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatApi _chatApi = ChatApi();

  final AuthService _authService = AuthService();

  @override
  void initState() {

    super.initState();
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatApi.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        // Convert snapshot data to List<User>
        List<User> userList = (snapshot.data as List<dynamic>?)
                ?.map((userData) => User.fromJson(userData))
                .toList() ??
            [];

        // return list view
        print("User List: $userList");
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: userList
                .where((user) =>
                    user.email != _authService.getCurrentUser()?.email)
                .map<Widget>((user) => _buildUserListItem(user, context))
                .toList(),
          ),
        );
      },
    );
  }

// build individual list tile for user
  Widget _buildUserListItem(User user, BuildContext context) {
    // display all users except current user

    print("================${user.name}");
    return UserTile(
      text: user.name,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverName: user.name,
              receiverID: user.uid,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "C H A T  W O R L D",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        foregroundColor: Colors.grey.shade700,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }
}
