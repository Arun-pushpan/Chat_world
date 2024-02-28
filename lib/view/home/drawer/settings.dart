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
        title:  Text("SETTINGS",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
      ),
      body: Column(
        children: [
          s6,
          Container(
            height: 57,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.secondary
            ),
            child: Row(
              children: [
                const SizedBox(width: 14,),
                Icon(Icons.color_lens_outlined,color: Theme.of(context).colorScheme.inversePrimary),
                const SizedBox(width: 15,),
                Text(
                  "D A R K M O D E",
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 100,),
                CupertinoSwitch(

                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme())
              ],
            ),
          ),s2,
          CustomListTile(
              tText: "P R I V A C Y",
              cColor:  Theme.of(context).colorScheme.secondary,
              sIcon: Icons.privacy_tip_outlined,
              onTap: () {
              }),s2,
          CustomListTile(
              tText: "C H A N G E    P A S S W O R D",
              cColor:  Theme.of(context).colorScheme.secondary,
              sIcon: Icons.lock_open_outlined,
              onTap: () {}

              ),s2,
          CustomListTile(
              tText: "C O N T A C T  U S",
              cColor:  Theme.of(context).colorScheme.secondary,
              sIcon: Icons.contact_support_outlined,
              onTap: () {}),
        ],
      ),
    );
  }
}
