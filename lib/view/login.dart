
import 'package:chat_with_friends/view/register_page.dart';
import 'package:chat_with_friends/widget/cusrtom_textfield.dart';
import 'package:flutter/material.dart';

import '../constants/sizedbox.dart';
import '../controller/services/api.dart';
import '../widget/custom_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.group,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          s2,
          Text(
            "Welcome back , you've been missed!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16),
          ),
          s4,
          CustomTextField(
            controller: usernameController,
            hintText: "UserName",
          ),
          CustomTextField(
            controller: passwordController,
            hintText: "Password",
            obscureText: obscureText,
            sIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
          s2,
          CustomElevatedButton(
            bText: "LOGIN",
            onPress: () {
              Api().login(
                  context, usernameController.text, passwordController.text);
            },
            bColor: Theme.of(context).colorScheme.tertiary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: Text("Register now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              )
            ],
          )
        ],
      ),
    );
  }
}
