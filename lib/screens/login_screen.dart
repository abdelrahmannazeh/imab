import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/services/auth.dart';
import 'package:flash_chat/screens/home_screen.dart';



class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthService _auth = AuthService();
  bool obsecure = true;
  String label1 ='Enter Your Password';





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


                controller: _passwordController,



                ),
              SizedBox(
                height: 24.0,
              ),
             RoundedButton(title: 'Log In',color: Colors.lightBlueAccent,onpressed: () async {
               if (_emailController.text.isEmpty ||
                   _passwordController.text.isEmpty) {
                 showDialog(context: context,
                     child: buildDialog(context, 'please put some data')
                 );
               }
               else if (!RegExp(
                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                   .hasMatch(_emailController.text)) {
                 showDialog(context: context,
                     child: buildDialog(
                         context, 'email address is badly formatted')
                 );
               }
               else if (_emailController.text.isNotEmpty &&
                   _passwordController.text.isNotEmpty) {
                 dynamic result = await _auth.signInWithEmailAndPassword(
                     _emailController.text, _passwordController.text);
                 if (result == null) {
                   Navigator.pushNamedAndRemoveUntil(
                       context, HomeScreen.id, (r) => false);
                 } else if (result != null) {
                   showDialog(context: context,
                       child: buildDialog(context, result.toString()));
                 }
               }
             }
             )

            ],
          ),
        ),
      ),
    );
  }
}
