import 'package:equatable/equatable.dart';

class User extends Equatable {
  final Data data;
  final String token;

  const User({required this.data, required this.token});


  @override
  List<Object?> get props => [data, token];
  
}

class Data extends Equatable{
  final int id;
  final String name;
  final String email;
  final String address;
  final String role;

  const Data({
    required this.id, 
    required this.name, 
    required this.email, 
    required this.address, 
    required this.role
  });
  
  @override
  List<Object?> get props => [id, name, email, address, role];
}