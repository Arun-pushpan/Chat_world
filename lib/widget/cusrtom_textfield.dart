import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final IconButton? sIcon;

  const CustomTextField({super.key,
    required this.controller,
    required this.hintText,
    this.validator,
     this.obscureText,
    this.sIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        autofocus: true,
        obscureText:obscureText??false ,
        cursorColor: Theme.of(context).colorScheme.primary,
        style:  TextStyle(color:Theme.of(context).colorScheme.primary, fontSize: 16),
        controller: controller,
        decoration: InputDecoration(

          hintText: hintText,
          suffixIcon: sIcon,
          hintStyle:  TextStyle(
              color: Theme.of(context).colorScheme.primary, fontSize: 16, fontWeight: FontWeight.w400),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2.0)),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
          ),
          border: const OutlineInputBorder(),
          fillColor: Colors.grey.shade300,
          filled: true
        ),

        validator: validator, // Pass the validator function here
      ),
    );
  }
}


class AttractiveTextFormField extends StatelessWidget {
  const AttractiveTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.obscureText = false,
    this.autocorrect = false,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool autocorrect;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          controller: controller,
          style:  TextStyle(color:Theme.of(context).colorScheme.primary, fontSize: 16),
          decoration: InputDecoration(

            hintText: hintText,
            hintStyle:const TextStyle(color:Colors.black, fontSize: 16),
            labelText: labelText,
            filled: true,
            fillColor: Colors.grey[200], // Adjust for light/dark theme
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            //   borderSide: BorderSide(color: Colors.white, width: 2.0), // Adjust for light/dark theme
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white, ),
            ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            //   borderSide: const BorderSide(color: Colors.red, width: 2.0),
            // ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          ),
          obscureText: obscureText,
          autocorrect: autocorrect,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}

