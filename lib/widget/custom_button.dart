import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String bText;
  final Function() onPress;
  final Color bColor;
  const CustomElevatedButton({
    super.key,
    required this.bText,
    required this.onPress,
    required this.bColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SizedBox(
        height: screenHeight * 0.06,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
              backgroundColor: bColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Text(bText,
              style: TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
