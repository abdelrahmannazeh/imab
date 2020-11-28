import 'package:flutter/material.dart';
class NotYet extends StatelessWidget {
  String title;
  NotYet({this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
    );
  }
}