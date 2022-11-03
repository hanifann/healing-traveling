import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:healing_travelling/core/error/failures.dart';
import 'package:healing_travelling/core/usecases/usecase.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/login/domain/repositories/user_repository.dart';

class PostAuthData extends UseCase<User, Params>{
  final UserRepository repository;

  PostAuthData(this.repository);

  @override
  Future<Either<Failure, User>?> call(
    Params params
  ) async {
    return await repository.postAuth(params.email, params.password);
  }
}

class Params extends Equatable{
  final String email;
  final String password;

  const Params({
    required this.email, 
    required this.password
  });
  
  @override
  List<Object?> get props => [email, password];
}