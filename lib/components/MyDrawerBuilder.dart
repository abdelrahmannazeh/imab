import 'package:flash_chat/screens/profile_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/addproduct_screen.dart';
import 'package:flash_chat/screens/cart_screen.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/notyet_screen.dart';
import 'package:flash_chat/screens/order_screen.dart';

class MyDrawerBuilder extends StatelessWidget {
  AuthService _auth = AuthService();
  List<String> drawerTitle = [
    'Home',
    'Profile',
    'Cart',
    'Orders',
    'Add Product',
    'Contact us',
    'Settings',
    'sign out',
  ];

  List<IconData> drawerLeading = [
    Icons.home,
    Icons.person,
    Icons.add_shopping_cart,
    Icons.shopping_cart,
    Icons.add,
    Icons.contact_support,
    Icons.settings,
    Icons.exit_to_app,
  ];
  List sceens = [
    HomeScreen(),
    ProfileScreen(),
    CartScreen(),
    OrderScreen(),
    AddProduct(),
    NotYet(title: 'contact us',),
    NotYet(title: 'setting',),

  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drawerTitle.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(drawerTitle[index]),
            leading: Icon(drawerLeading[index]),
          ),
          onTap: () {
            if (drawerTitle[index] == 'sign out'){
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.id, (route) => false);
            }else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => sceens[index]),
              );
            }
          },
        );
      },
    );
  }
}

