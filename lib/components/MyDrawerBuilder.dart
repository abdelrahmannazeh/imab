import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

List<String> drawerTitle = [
      'Home',
      'Profile',
      'Contact us',
      'Settings',
      'sign out'
    ];

    List<IconData> drawerLeading = [
      Icons.home,
      Icons.person,
      Icons.contact_support,
      Icons.settings,
      Icons.exit_to_app,
    ];
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: drawerTitle.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(drawerTitle[index]),
            leading: Icon(drawerLeading[index]),
          ),
          onTap: () async{
            switch(index){
              case 0: break;
              case 1:
                Navigator.pushNamed(context, ProfileScreen.id);
                break;
              case 2: break;
              case 3: break;
              case 4:
                await _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.id, (route) => false);
                break;
            }
          },
        );
      },
    );
  }
}