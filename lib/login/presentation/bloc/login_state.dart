part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class Loaded extends LoginState {
  final User user;

  const Loaded({
    required this.user
  });
}

class Error extends LoginState {
  final String message;

  const Error({required this.message});
}
