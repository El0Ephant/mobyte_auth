import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mobyte_auth/data/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.repository) : super(const AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is ErrorEvent) {
        emit (AuthFail(event.message));
      }

      else if (event is LogInEvent) {
        emit(const AuthLoading());
        final String response = await repository.logIn(login: event.login, password: event.password);
        response == "OK" ? emit(const AuthSuccess()): emit(AuthFail(response));
      }

      else if (event is SignUpEvent) {
        emit(const AuthLoading());
        final String response = await repository.signUp(username: event.username, email: event.email, password: event.password);
        response == "OK" ? emit(const AuthSuccess()): emit(AuthFail(response));
      }

      else if (event is SendResetEvent) {
        emit(const AuthLoading());
        final String response = await repository.sendReset(login: event.login);
        response == "OK" ? emit(const AuthSuccess()): emit(AuthFail(response));
      }

      else if (event is GoogleLogInEvent) {
        final String response = await repository.googleLogIn();

        if (response == "OK") {
          emit(const AuthSuccess());
        }
        else if (response != "CANCEL") {
          emit(AuthFail(response));
        }
      }

      else if (event is LogOutEvent) {
        emit(const AuthLoading());
        await repository.logOut();
        emit(const AuthSuccess());
      }
    });
  }

  final AuthRepository repository;

}
