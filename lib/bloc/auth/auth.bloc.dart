import 'package:crm_android/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // Use the repository to login
      bool loginSuccess = await authRepo.login(
        userId: event.userId,
        password: event.password,
      );

      if (loginSuccess) {
        emit(const AuthSuccess('Login Successful!'));
      } else {
        emit(const AuthFailure('Invalid credentials'));
      }
    } catch (error) {
      emit(AuthFailure('An error occurred: $error'));
    }
  }
}
