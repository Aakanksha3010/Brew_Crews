import 'package:brew_crew/screens/Authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/Authenticate/sign-in.dart';

class AuthState extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<AuthState> {
  bool showsignIn = true;
  void toggleView() {
      setState(() => showsignIn = !showsignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showsignIn){
      return signIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}