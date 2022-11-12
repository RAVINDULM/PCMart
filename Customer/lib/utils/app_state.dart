import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

enum ApplicationLogInState { loggedin, loggedout }

class ApplicationState extends ChangeNotifier {
  User? user;
  ApplicationLogInState loginState = ApplicationLogInState.loggedout;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((userFir) {
      if (userFir != null) {
        loginState = ApplicationLogInState.loggedin;
        user = userFir;
      } else {
        loginState = ApplicationLogInState.loggedout;
      }
      notifyListeners();
    });
  }

  String GetCurrentUserID()  {
    return  auth.currentUser!.uid;
  }

  Future<void> SignIn(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print(FirebaseAuth.instance.currentUser);
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
    }
  }

  Future<void> SignUp(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      print("email firebase called: " + email);
      print("password firebase called" + password);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      errorCallBack(e);
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
