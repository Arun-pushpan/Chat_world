import 'package:chat_with_friends/view/home/drawer/about.dart';
import 'package:chat_with_friends/view/home/drawer/settings.dart';
import 'package:chat_with_friends/widget/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/sizedbox.dart';
import '../controller/services/api.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: [
          DrawerHeader(
            curve: Curves.bounceIn,
              child: Center(
            child: Icon(
              Icons.group,
              color: Theme.of(context).colorScheme.primary,
              size: 50,
            ),
          )),
          s4,
          CustomListTile(
              tText: "H O M E",
              sIcon: Icons.home,
              onTap: (){
                Navigator.pop(context);
              }),
          CustomListTile(
              tText: "S E T T I N G S",
              sIcon: Icons.settings,
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const Settings()));
              }),
          CustomListTile(
              tText: "A B O U T",
              sIcon: Icons.edit,
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const About()));
              }),
          const Spacer(),
          CustomListTile(
              tText: "L O G O U T",
              sIcon: Icons.logout,
              onTap: (){
                Api().logout();
              }),
        ],
      ),
    );
  }
}
