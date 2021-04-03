import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constance.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/loading.dart';

class signIn extends StatefulWidget {
  final Function toggleView;
  signIn({this.toggleView});

  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  // create text string to store value of email and pswd
    String email = '';
    String password = '';
    String error = '';
    bool loading = false;

  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: Text('Sign-in for Brew Crew'),
        elevation: 0.0,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            style: TextButton.styleFrom(primary: Colors.black),
            label: Text(
              'Register',
              style:TextStyle(color: Colors.black),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter valid email':null,
                onChanged: (val) {
                  setState(()=> email= val );
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length< 6 ? 'Enter pswd upto 6+ chrs long':null,
                onChanged: (val){
                  setState(()=> password= val );
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text(
                  'Sign-in',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.pink),
                onPressed: () async {
                  if(_formkey.currentState.validate()){
                    setState(() => loading =true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                                              error = 'Could not sign in with those credentials';
                                              loading= false;
                                            });
                    }
                  
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
      );
      
    
  }
}