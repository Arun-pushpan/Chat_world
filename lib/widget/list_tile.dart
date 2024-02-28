import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String tText;
  final IconData sIcon;
  final Color? cColor;
  final Function() onTap;

  const CustomListTile({super.key, required this.tText, required this.sIcon, required this.onTap, this.cColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: cColor,
        shape:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary
          )

        ),
        onTap: onTap,
        title: Text(
          tText,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        leading: Icon(
          sIcon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
