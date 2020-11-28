import 'package:flash_chat/screens/profile_screen.dart';
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
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.id);
          },
        );
      },
    );
  }
}