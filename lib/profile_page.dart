import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? image;
  Future pickImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    }on PlatformException catch (e){
      print('Failed to pick image: $e');

  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("ProfilePage"),
      ),

      body: Container(
        child: ListView(
          children: [

            image != null ?
                ClipOval(
                  child: Image.file(
                    image!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                )
            : FlutterLogo(size: 160),
            buildButton(
                title: 'Pick Gallery',
                icon: Icons.image_outlined,
                onClicked: () => pickImage(ImageSource.gallery),),
            buildButton(
                title: 'Pick Camera',
                icon: Icons.camera,
                onClicked:()=> pickImage(ImageSource.camera),
            )],
        ),
      ),
    );
  }
}

Widget buildButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(56),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title),
          ],
        ));
