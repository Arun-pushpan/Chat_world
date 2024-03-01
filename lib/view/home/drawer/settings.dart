import 'package:chat_with_friends/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/sizedbox.dart';
import '../../../widget/list_tile.dart';
import 'about.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text("Settings",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          s6,
          Container(
            height: 57,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)
            ),
            child: Row(
              children: [
                const SizedBox(width: 14,),
                Icon(Icons.color_lens_outlined,color: Theme.of(context).colorScheme.inversePrimary),
                const SizedBox(width: 15,),
                Text(
                  "Dark Mode",
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                CupertinoSwitch(

                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme()),const SizedBox(width: 15,),
              ],
            ),
          ),s2,
          CustomListTile(
              tText: "Privacy",
              cColor:  Theme.of(context).colorScheme.secondary.withOpacity(0.4),
              sIcon: Icons.privacy_tip_outlined,
              onTap: () {
              }),s2,
          CustomListTile(
              tText: "Change Password",
              cColor:  Theme.of(context).colorScheme.secondary.withOpacity(0.4),
              sIcon: Icons.lock_open_outlined,
              onTap: () {}

              ),s2,
          CustomListTile(
              tText: "Contact Us",
              cColor:  Theme.of(context).colorScheme.secondary.withOpacity(0.4),
              sIcon: Icons.contact_support_outlined,
              onTap: () {}),
        ],
      ),
    );
  }
}
