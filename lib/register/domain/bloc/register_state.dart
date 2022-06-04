part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String errorValue;

  const RegisterFailed(this.errorValue);

  @override
  List<Object> get props => [errorValue];
}

class RegisterSuccess extends RegisterState {}
