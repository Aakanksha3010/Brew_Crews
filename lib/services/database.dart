import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/brew_model/brew.dart';
import 'package:brew_crew/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection("brews");

  //linking firebase user uid with doc created within firestore database
  Future updateUserData(String name,String sugars,int strength) async{
    return await brewCollection.doc(uid).set({
      'name': name,
      'sugars':sugars,
      'strength': strength,
    });
  } 
  // create brwlist from snapshot
  List<Brew> _BrewListSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((docs){
      return Brew(
        name: docs.data()['name'] ?? '',
        sugars: docs.data()['sugars'] ?? '',
        strength: docs.data()['strength'] ?? ''
      );
    }).toList();
  }
  // set stream
  Stream <List<Brew>> get brews{
    return brewCollection.snapshots()
    .map(_BrewListSnapshot);
  }
  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }
  // get usr doc stream
  Stream <UserData> get userData{
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}