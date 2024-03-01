

import 'dart:typed_data';

import 'package:chat_with_friends/controller/auth/auth_services.dart';
import 'package:chat_with_friends/controller/services/api.dart';
import 'package:chat_with_friends/view/home/home_page.dart';
import 'package:chat_with_friends/widget/cusrtom_textfield.dart';
import 'package:chat_with_friends/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/images.dart';
import '../../../constants/sizedbox.dart';

class EditProfile extends StatefulWidget {
   String name;
   String phone;
   String img;
   EditProfile({super.key,required this.name ,required this.phone,required this.img});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
   TextEditingController nameController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
    String? img;
   Uint8List? _image;
   bool isLoading = false;

   @override
  void initState() {

    super.initState();
    nameController.text=widget.name;
    phoneController.text=widget.phone;
    img=widget.img;
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
     if (kDebugMode) {
       print("No Images Selected");
     }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text("Edit Profile",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontWeight: FontWeight.bold),),
      ),
     body: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         s5,
         _image!=null?
         Stack(
           children: [

             CircleAvatar(
               radius: 70,
                 backgroundImage: MemoryImage(_image!),
             ),
             Positioned(
               bottom: -13,
               left: 85,
               child: IconButton(
                 onPressed: () {
                   selectImage();
                 },
                 icon: const Icon(Icons.add_a_photo,size: 40,),),

             )
           ],
         ):
         Stack(
           children: [
             img!=null?
             CircleAvatar(
               radius: 70,
               backgroundImage: NetworkImage(img!),
             ):
             const CircleAvatar(
               radius: 70,
               backgroundColor: Colors.grey,
               backgroundImage: NetworkImage("https://i.pinimg.com/474x/69/63/3a/69633a986c2358c21d82ba1b550df5a4.jpg",),

             ),
             Positioned(
               bottom: -13,
               left: 85,
               child: IconButton(
                 onPressed: () {
                    selectImage();
                 },
                 icon: const Icon(Icons.add_a_photo,size: 40,),),

             )
           ],
         ),
         s5,
         CustomTextField(
             controller: nameController,
             hintText: "Name"),
         s1,
         CustomTextField(
             controller: phoneController,
             hintText: "Phone Number"),
         s3,
         CustomElevatedButton(
             bText: "SAVE",
             onPress: () async {
               setState(()   {
                 isLoading=true;
               });
              await AuthService().upDateDetails(
                   nameController.text,
                   phoneController.text,
                   _image!).then((value) => Navigator.push(context,
                   MaterialPageRoute(builder: (context)=>const HomePage())));
             },
             bColor: Theme.of(context).colorScheme.tertiary, isLoading: isLoading,
         ),
         // CustomElevatedButton(
         //   bText: "SAVE",
         //   onPress: () async {
         //     setState(() {
         //       isLoading = true;
         //     });
         //
         //     if (_image != null) {
         //       await AuthService().upDateDetails(
         //         nameController.text,
         //         phoneController.text,
         //         _image!,
         //       ).then((value) => Navigator.push(
         //           context, MaterialPageRoute(builder: (context) => const HomePage())));
         //     } else if (img != null) {
         //
         //       Uint8List imgBytes = Uint8List.fromList(List<int>.from(img!.codeUnits));
         //
         //       await AuthService().upDateDetails(
         //         nameController.text,
         //         phoneController.text,
         //         imgBytes,
         //       ).then((value) => Navigator.push(
         //           context, MaterialPageRoute(builder: (context) => const HomePage())));
         //     }
         //
         //     setState(() {
         //       isLoading = false;
         //     });
         //   },
         //   bColor: Theme.of(context).colorScheme.tertiary,
         //   isLoading: isLoading,
         // ),

       ],
     ),
    );
  }
}
