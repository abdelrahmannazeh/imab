import 'package:flash_chat/screens/addproduct_screen.dart';
import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/wrapper.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}




class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Wrapper(),
        // theme: ThemeData.dark().copyWith(
        //   textTheme: TextTheme(
        //     body1: TextStyle(color: Colors.black54),
        //   ),
        // ),

        routes: {
          WelcomeScreen.id: (context)=> WelcomeScreen(),
          LoginScreen.id : (context) => LoginScreen(),
          RegistrationScreen.id : (context) => RegistrationScreen(),
          Wrapper.id : (context) => Wrapper(),
          HomeScreen.id : (context) => HomeScreen(),
          ProfileScreen.id : (context) => ProfileScreen(),
          AddProduct.id : (context) => AddProduct()

        },


    );
  }
}
