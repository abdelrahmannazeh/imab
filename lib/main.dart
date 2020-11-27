import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/wrapper.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'user.dart';



void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
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

        },
      ),

    );
  }
}


// MaterialApp(

//

//     );