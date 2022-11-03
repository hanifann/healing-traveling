import 'package:healing_travelling/core/platform/network_info.dart';
import 'package:healing_travelling/login/data/datasource/user_remote_data_source.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:healing_travelling/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, User>>? postAuth(String? email, String? password) async {
    networkInfo.isConnected;
    return Right(await remoteDataSource.getUserData(email, password)!);
  }
  
}