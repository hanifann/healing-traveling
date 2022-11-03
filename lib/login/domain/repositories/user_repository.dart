import 'package:dartz/dartz.dart';
import 'package:healing_travelling/core/error/failures.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>>? postAuth(String? email, String? password);
  Future<Either<Failure, User>>? fetchUserData();
}