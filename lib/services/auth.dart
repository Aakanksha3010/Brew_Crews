import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  //creating instance of user obj
  final FirebaseAuth _auth = FirebaseAuth.instance;
   // create user obj from firebase user 
   TheUser _fromFirebaseUser(User user){
     return user != null ? TheUser(uid: user.uid) : null;
   }

   // auth change user stream
   Stream<TheUser> get user{
     return _auth.authStateChanges().map(_fromFirebaseUser);
   }

  
    //sign in with email & pswd
    Future signInWithEmailAndPassword(String email,String password)async{
      try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _fromFirebaseUser(user);
      } catch (e) {
        print(e.toString());
        return null;
      }
      
    }
    
    // register with email & pswd
    Future registerWithEmailAndPassword(String email,String password) async{
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User user = userCredential.user;
        //crate document for user with uid
        await DatabaseService(uid: user.uid).updateUserData('new crew member', '0', 100);
        return _fromFirebaseUser(user);
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
   
    // log  out 
    Future signOut() async{
      try {
        return await _auth.signOut();
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
    

}