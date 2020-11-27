import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registeration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool obsecure = true;
  String label1 ='Enter Your Password';
  String label2 ='Confirm Your Password';
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  AuthService _auth = AuthService();

  Widget buildDialog(BuildContext context, String msg){
    return AlertDialog(
      content: Text(msg),
      actions: [
        FlatButton(
          child: Text('Ok'),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }

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
                controller: _nameController,
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
                controller: _emailController,
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
                controller: _passwordController,
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
                onpressed: () async {
                 if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty){
                   showDialog(context: context, child: buildDialog(context,'Please put some Data'));

                 }else if (_passwordController.text.length < 6){
                   showDialog(context: context, child: buildDialog(context, 'Password must be at least 6 characters'));
                 }
                 else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text)){
                   showDialog(context: context,
                       child: buildDialog(context, 'Email address is badly formatted')
                   );
                 }
                 else if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _nameController.text.isNotEmpty){
                   dynamic result = await _auth.registerWithEmailAndPassword(_emailController.text, _passwordController.text);
                   if(result is FirebaseUser){
                     FirebaseAuth.instance.currentUser().then((value) {
                       UserUpdateInfo updateUser = UserUpdateInfo();
                       updateUser.displayName = _nameController.text;
                       value.updateProfile(updateUser);
                     });
                     Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (r) => false);
                   }else {
                     showDialog(context: context, child: buildDialog(context, result.toString()));
                   }
                 }
                })
            ],
          ),
        ),
      ),
    );
  }
}
