import 'package:healing_travelling/core/error/exception.dart';
import 'package:healing_travelling/core/platform/network_info.dart';
import 'package:healing_travelling/login/data/datasource/user_local_data_source.dart';
import 'package:healing_travelling/login/data/datasource/user_remote_data_source.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:healing_travelling/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:healing_travelling/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource, 
    required this.networkInfo,
    required this.localDataSource
  });

  @override
  Future<Either<Failure, User>>? postAuth(String? email, String? password) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getUserData(email, password);
        return Right(response!);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, User>>? fetchUserData() async {
    try {
      final response = await localDataSource.getLocalUserData();
      return Right(response!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}