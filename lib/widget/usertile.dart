

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;

  final Function() onTap;
  const UserTile({super.key, required this.text, required this.onTap, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20,),
              const Icon(Icons.person,size: 40,),
              SizedBox(width: 20,),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}
