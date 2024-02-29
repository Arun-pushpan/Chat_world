import 'package:chat_with_friends/constants/images.dart';
import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:chat_with_friends/view/home/drawer/about.dart';
import 'package:chat_with_friends/view/home/drawer/settings.dart';
import 'package:chat_with_friends/widget/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/sizedbox.dart';
import '../controller/services/api.dart';
import '../model/user_model.dart';

class MyDrawer extends StatelessWidget {
  // final String name;
  // final String email;
  const MyDrawer({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              curve: Curves.bounceIn,
              child:StreamBuilder(
                stream: AuthService().getCurrentUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No user data available');
                  }

                  final user = snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:  const AssetImage(profileImage),
                      ),
                      s1,
                      Text(user['name']),
                      s1,
                      Text(user['email']),
                    ],
                  );
                },
              ),
            ),
          ),
          // Icon(
          //   Icons.group,
          //   color: Theme.of(context).colorScheme.primary,
          //   size: 50,
          // )),
          s4,
          CustomListTile(
              tText: "H O M E",
              sIcon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              }),
          CustomListTile(
              tText: "S E T T I N G S",
              sIcon: Icons.settings,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              }),
          CustomListTile(
              tText: "A B O U T",
              sIcon: Icons.edit,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const About()));
              }),
          const Spacer(),
          CustomListTile(
              tText: "L O G O U T",
              sIcon: Icons.logout,
              onTap: () {
                Api().logout();
              }),
        ],
      ),
    );
  }
}
