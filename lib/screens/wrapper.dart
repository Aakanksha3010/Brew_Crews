import 'package:brew_crew/screens/Authenticate/authenticate.dart';
import 'package:brew_crew/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<TheUser>(context); //listen for auth changes
    print(user);
    if (user==null){
      return AuthState();
    }else{
      return Home();
    }
  
}
}