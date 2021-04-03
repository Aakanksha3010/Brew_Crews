import 'package:brew_crew/screens/Home/setting_from.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/Home/brew_list.dart';
import 'package:brew_crew/brew_model/brew.dart';


class Home extends StatelessWidget {
  // create instance
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingForm(),

        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      initialData: null,
      value: DatabaseService().brews,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.brown[200],
          appBar: AppBar(
            backgroundColor: Colors.brown[800],
            title: Text('Brew gang'),
            elevation: 0.0,
            actions: [
              TextButton.icon(
                icon: Icon(Icons.people),
                style: TextButton.styleFrom(primary: Colors.black),
                label: Text(
                  'log-out',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  ),
                onPressed: () async{
                  await _auth.signOut();
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.settings),
                style: TextButton.styleFrom(primary: Colors.black),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.black,),
              ),
              onPressed: () => showSettingPanel(),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()
          ),
        ),
      ),
    );
  }
}