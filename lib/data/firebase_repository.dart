import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admin/firebase_admin.dart' hide FirebaseException;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:mobyte_auth/data/auth_repository.dart';

class FirebaseRepository extends AuthRepository {
  FirebaseRepository();
  final _instance = FirebaseAuth.instance;
  final _storeInstance = FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn();
  final _adminInstance = FirebaseAdmin.instance;

  String _email = '';
  String _username = '';

  @override
  Future<String> logIn({required String login, required String password}) async {
    final emailRegex = RegExp(r'^\w+@\w+\.\w+$');
      try {
        if (!emailRegex.hasMatch(login)) {
          var data = await _storeInstance.collection('users').doc(login).get();
          _username = login;
          login = await data.get("email");
          _email = login;
        }
        else {
          _email = login;
          var data = await _storeInstance.collection('users').doc(login).get();
          _username = await data.get("username");
        }
      }
      on FirebaseException catch (e) {
        return e.message ?? "Unnamed error";
      }



    try {
      await _instance.signInWithEmailAndPassword(
          email: login, password: password);
      return "OK";
    }
    on FirebaseAuthException catch (e) {
      return e.message ?? "Unnamed auth error";
    }
  }

  @override
  Future<void> logOut() async {
    _email = "";
    _username = "";
    await _instance.signOut();
  }

  @override
  Future<String> signUp(
      {required String username, required String email, required String password}) async {
    try {
      await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
      await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      
      await _storeInstance.collection('users').doc(username).set({'email':email});
      await _storeInstance.collection('users').doc(email).set({'username':username});

      _email = email;
      _username = username;
      return "OK";
    }
    on FirebaseAuthException catch (e) {
      return e.message ?? "Unnamed auth error";
    }
    on FirebaseException catch (e) {
      return e.message ?? "Unnamed error";
    }
  }

  @override
  Future<String> sendReset({required String login}) async {
    final emailRegex = RegExp(r'^\w+@\w+\.\w+$');

    try {
      if (emailRegex.hasMatch(login)) {
      await _instance.sendPasswordResetEmail(email: login);
      }
      else {
        var data = await _storeInstance.collection('users').doc(login).get();
        login = await data.get("email");

        //await _instance.sendPasswordResetEmail(email: login);
        var random = Random();
        final Email email = Email(
          body: 'Your reset code is ${random.nextInt(9)*1000+random.nextInt(9)*100+random.nextInt(9)*10+random.nextInt(9)}',
          subject: 'Mobyte auth password reset',
          recipients: [login],
          isHTML: false,
        );

        await FlutterEmailSender.send(email);
      }
      return "OK";
    }
    on FirebaseAuthException catch(e) {
      return e.message ?? "Unnamed auth error";
    }
  }

  @override
  Future<String> googleLogIn() async {
    final user = await _googleSignIn.signIn();
    if (user == null) {
      return "CANCEL";
    }

    final googleAuth = await user.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _instance.signInWithCredential(credential);
    }
    on FirebaseAuthException catch (e) {
      return e.message ?? "Unknown auth error";
    }

    _email = _instance.currentUser?.email ?? "";
    _username = _instance.currentUser?.displayName ?? "";
    return "OK";
  }

  @override
  String get userEmail => _email;

  @override
  String get username => _username;




}