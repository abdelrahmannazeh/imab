import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registeration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool obsecure = true;
  String label1 ='Enter Your Password';
    String label2 ='Conferm Your Password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFeildDecoration.copyWith(
                    labelText: 'Full Name',
                    hintText: 'User Name',
                    prefixIcon:
                        Icon(Icons.account_box, color: Colors.black, size: 20.0)),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFeildDecoration.copyWith(
                    labelText: 'Enter Your Email',
                    hintText: 'example@something.com',
                    prefixIcon:
                        Icon(Icons.email, color: Colors.black, size: 20.0)),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: obsecure,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kTextFeildDecoration.copyWith(
                  labelText: label1,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.black, size: 20.0),
                  suffixIcon: label1 == 'Enter Your Password' ? IconButton(
          icon: Icon(Icons.remove_red_eye),
          color: Colors.black,
          iconSize: 20.0,
          onPressed: () {
            setState(() {
              obsecure = !obsecure;
            });
          },
        ) : null
      ),
                ),
                SizedBox(
                height: 8.0,
              ),
              RoundedButton(
                  title: 'Register',
                  color: Colors.lightBlueAccent,
                  onpressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
