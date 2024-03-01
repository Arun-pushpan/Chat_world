import 'package:chat_with_friends/constants/images.dart';
import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:chat_with_friends/view/home/drawer/about.dart';
import 'package:chat_with_friends/view/home/drawer/edit_profile.dart';
import 'package:chat_with_friends/view/home/drawer/settings.dart';
import 'package:chat_with_friends/widget/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/sizedbox.dart';
import '../controller/services/api.dart';
import '../model/user_model.dart';

class MyDrawer extends StatelessWidget {

   MyDrawer({
    super.key,
  });
  String? name;
  String? phone;
  String? img;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.9),
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
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
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
                  name = user['name'] ?? '';  // If 'name' is null, assign an empty string
                  phone = user['phoneNo'] ?? '';  // If 'phoneNo' is null, assign an empty string
                  img = user['imageLink'] ?? '';  // If 'imageLink' is null, assign an empty string

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user['imageLink'] != null && user['imageLink'].toString().isNotEmpty
                          ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user['imageLink'].toString()),
                      )
                          : const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(profileImage),
                      ),
                      s1,
                      Text(user['name'] != null && user['name'].toString().isNotEmpty
                          ? user['name']
                          : ""),
                      s1,
                      Text(user['email'] != null && user['email'].toString().isNotEmpty
                          ? user['email']
                          : ""),
                    ],
                  );

                },
              ),
            ),
          ),

          s4,
          CustomListTile(
              tText: "Home",
              sIcon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              }),
          CustomListTile(
              tText: "Edit Profile",
              sIcon: Icons.edit,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  EditProfile(name:name!,phone:phone!,img:img!)));
              }),
          CustomListTile(
              tText: "Settings",
              sIcon: Icons.settings,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              }),
          CustomListTile(
              tText: "About",
              sIcon: Icons.note_alt_outlined,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const About()));
              }),
          const Spacer(),
          CustomListTile(
              tText: "Logout",
              sIcon: Icons.logout,
              onTap: () {
                Api().logout();
              }),
        ],
      ),
    );
  }
}
