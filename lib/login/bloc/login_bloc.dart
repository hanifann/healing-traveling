import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/login/domain/services/login_service.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.service) : super(LoginInitial()) {
    on<LoginEventPost>(_onLoginEventPost);
  }

  final LoginService service;

  _onLoginEventPost(
    LoginEventPost event,
    Emitter<LoginState> emit
  ) async {
    emit(LoginLoading());
    final result = await service.postLogin(event.email, event.password);
    await result.fold(
      (l) {
        log('login failed $l', name: 'login');
        emit(LoginFailed(l));
      }, 
      (r) async {
        log('Login Success', name: 'login');
        await SharedPreferenceSingleton.setString('token', r.token!);
        await SharedPreferenceSingleton.setString('name', r.data!.name!);
        emit(LoginSuccess(r.token!));
      }
    );
  }
}
