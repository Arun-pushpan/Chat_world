
import 'package:chat_with_friends/view/home/home_page.dart';
import 'package:chat_with_friends/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/sizedbox.dart';
import '../controller/services/api.dart';
import '../widget/cusrtom_textfield.dart';
import '../widget/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscureText = true;
  bool obscureText1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.group,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            s2,
            Text(
              "Let's create an account for you",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16),
            ),
            s4,
            CustomTextField(
              controller: nameController,
              hintText: "Name",
            ),
            CustomTextField(
              controller: emailController,
              hintText: "Email",
            ),
            CustomTextField(
              controller: phoneController,
              hintText: "Phone Number",
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
            CustomTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: obscureText1,
              sIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText1 = !obscureText1;
                    });
                  },
                  icon: Icon(
                    obscureText1 ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ),
            s2,
            CustomElevatedButton(
              bText: "REGISTER",
              onPress: () {
                Api().register(context, emailController.text,
                    passwordController.text, confirmPasswordController.text,nameController.text,phoneController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
              bColor: Theme.of(context).colorScheme.tertiary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Text("Login now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
