import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';


class Wrapper extends StatelessWidget{
  static String id = 'wrapper';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null){
      return WelcomeScreen();
    } else {
      return HomeScreen();
    }
  }
}