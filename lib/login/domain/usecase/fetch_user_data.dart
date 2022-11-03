import 'package:healing_travelling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:healing_travelling/core/usecases/usecase.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/login/domain/repositories/user_repository.dart';

class FetchUserData extends UseCase<User, NoParams> {
  final UserRepository repository;

  FetchUserData(this.repository);

  @override
  Future<Either<Failure, User>?> call(NoParams params) async {
    return await repository.fetchUserData();
  }
  
}