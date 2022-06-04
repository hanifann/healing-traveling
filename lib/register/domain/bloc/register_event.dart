part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEventPost extends RegisterEvent{
  final Register register;

  const RegisterEventPost({required this.register});

  @override
  List<Object> get props => [register];
}
