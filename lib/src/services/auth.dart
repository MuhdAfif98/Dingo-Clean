import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_clean/src/model/user.dart';
import 'package:dingo_clean/src/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userList = FirebaseFirestore.instance.collection('user');

  //Create user object based on FirebaseUser
  MyUser? _userFromFirebase(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebase);
  }

  //Sign In Anonymous
  Future signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Register with email and password
  Future registerAccount(String name, String image, String address, String city, String contactNo, String postcode, String state, String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //Create document
      await DatabaseService().createUserData(name, image, address, city, contactNo, postcode, state, user!.uid);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

//Sign in for user with email and password
  Future loginIntoAccount(String emailAddress, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }
//Sign in for admin
  Future loginAdminAccount(String emailAddress, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }
//Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}