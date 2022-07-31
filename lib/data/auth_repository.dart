import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  AuthRepository();

  Future<String> logIn({required String login, required String password});
  Future<void> logOut();
  Future<String> signUp({required String username, required String email, required String password});
  Future<String> sendReset({required String login});

  Future<String> googleLogIn();

  String get userEmail;

  String get username;

  /*Future<String> sendCode({required String code});
  Future<String> sendNewPassword({required String password});

  ???*/

}