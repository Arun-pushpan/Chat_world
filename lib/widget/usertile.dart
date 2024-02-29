import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../constants/images.dart';

class UserTile extends StatelessWidget {
  final String text;
  final ImageProvider? img;

  final Function() onTap;
  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
    this.img

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
               CircleAvatar(
                radius: 20,
                backgroundImage:img ?? const AssetImage(profileImage),
              ),
              // const Icon(Icons.person,size: 40,),
              const SizedBox(
                width: 20,
              ),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}
