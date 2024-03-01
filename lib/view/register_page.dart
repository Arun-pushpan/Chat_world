import 'dart:typed_data';

import 'package:chat_with_friends/view/home/home_page.dart';
import 'dart:io';
import 'package:chat_with_friends/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool obscureText = true;
  bool obscureText1 = true;
  bool isLoading = false;
  Uint8List? _image;



  @override
  void initState() {
    super.initState();

  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return 'Enter Name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value!.isEmpty) {
      return 'Phone No is required';
    } else if (value.length == 9) {
      return 'Enter a valid Phone No';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }




  _submitForm() async {
    if (_formKey.currentState!.validate()) {
        if (_image!= null) {
          // Continue with user registration
          Api().register(
            context,
            emailController.text,
            passwordController.text,
            confirmPasswordController.text,
            nameController.text,
            phoneController.text,
            _image,
          );
        } else {
          // Handle the case where image upload fails
        }

    }
  }


  void selectImage()async{
    Uint8List img  =await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });


  }

  pickImage(ImageSource source)async{
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file =await _imagePicker.pickImage(source: source);
    if(_file != null){
      return await _file.readAsBytes();
    }
    print("No Images Selected");
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    children: [
                      _image!=null?
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: MemoryImage(_image!),
                      ):
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage("https://i.pinimg.com/474x/69/63/3a/69633a986c2358c21d82ba1b550df5a4.jpg",),

                      ),
                      Positioned(
                          bottom: -13,
                        left: 40,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(Icons.add_a_photo),),

                      )
                    ],
                  ),
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
                  validator: _validateName,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  validator: _validateEmail,
                ),
                CustomTextField(
                  controller: phoneController,
                  hintText: "Phone Number",
                  validator: _validatePhone,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: obscureText,
                  validator: _validatePassword,
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
                  validator: _validatePassword,
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
                          setState(() {
                            isLoading == true;
                          });
                          _submitForm();
                        },
                        bColor: Theme.of(context).colorScheme.tertiary,
                       isLoading: isLoading,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: Text("Login now",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
