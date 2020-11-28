import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'profile_screen';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  StorageService _storageService = StorageService();
  File image;
  String name = '';
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    name = FirebaseAuth.instance.currentUser.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: FirebaseAuth.instance.currentUser.photoURL != null || image != null ?
                    (image == null?
                    NetworkImage(FirebaseAuth.instance.currentUser.photoURL) : FileImage(image))
                        : AssetImage('assets/Products/a.png'),
                    fit: BoxFit.fill
                ),
              ),
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.add_a_photo,size: 40.0,),
                color: Colors.black,
                highlightColor: Colors.grey[100],
                iconSize: 20.0,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          children: [
                            Text(
                              'Select Image',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            ListTile(
                              title: Text(
                                'Camera',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                  Icons.camera,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                              ),
                            ListTile(
                              title: Text(
                                'Gallery',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.photo_album,
                                  color: Colors.black, size: 15.0),
                              onTap: () {
                                pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            item('Orders',  Icons.add_shopping_cart),
            item('My Wishlist',  Icons.favorite),
            Opacity(
              opacity: opacity,
              child: ElevatedButton(
                child: Text('Save'),
                onPressed: () async {
                  await _storageService.uploadFile(image, 'Users/${FirebaseAuth.instance.currentUser.uid}/profile_pic');
                  String urL = await _storageService.downloadURL('Users/${FirebaseAuth.instance.currentUser.uid}/profile_pic') as String;
                  FirebaseAuth.instance.currentUser.updateProfile(photoURL: urL);
                  Navigator.pushNamed(context, HomeScreen.id);
                  },
            ),
            )
          ],
        ),
      ),
    );
  }

  item(String title,  IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        onTap: (){

        },
          title: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          
          leading: Icon(icon, color: Colors.black, size: 20.0)),
    );
  }

  pickImage(ImageSource source) async {
    var _image = await ImagePicker.pickImage(source: source);
    setState(() {
      image = _image;
      opacity = 1.0;
    });
  }
}
