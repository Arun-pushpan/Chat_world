import 'package:chat_with_friends/view/home/home_page.dart';
import 'dart:io';
import 'package:chat_with_friends/view/login.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:flutter/cupertino.dart';
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
  bool obscureText = true;
  bool obscureText1 = true;
  bool isLoading = false;

  late ImagePicker _imagePicker;
  File? _pickedFile;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
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

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String uid = prefs.getString('uid') ?? '';
      String fileName = 'user_images/$uid/${DateTime.now().millisecondsSinceEpoch}.png';

      firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.ref(fileName);

      firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);

      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }


   _submitForm() async {
    if (_formKey.currentState!.validate()) {

      if (_pickedFile != null) {
        String? imageUrl = await uploadImageToFirebaseStorage(_pickedFile!);

        if (imageUrl != null) {
          Api().register(
            context,
            emailController.text,
            passwordController.text,
            confirmPasswordController.text,
            nameController.text,
            phoneController.text,
            _pickedFile,
          );
        } else {
          // Handle the case where image upload fails
        }
      }
    }
  }
  Future<void> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Do something with the picked image file
      setState(() {
        _pickedFile = File(image.path);
      });
      print('Image path: ${image.path}');
    } else {
      // User canceled the picker
      print('Image picking canceled.');
    }
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
                s2,
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage:_pickedFile != null
                      ? FileImage(_pickedFile!)
                      : null,

                  child: IconButton(
                    onPressed: () {
                        pickImageFromGallery();
                    },
                    icon: Icon(Icons.camera_alt,color: Colors.black,size: 35,),
                    
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
                isLoading == true
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : CustomElevatedButton(
                        bText: "REGISTER",
                        onPress: () {
                          setState(() {
                            isLoading == true;
                          });
                          _submitForm();
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
