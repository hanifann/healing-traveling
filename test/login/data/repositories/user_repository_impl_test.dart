import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/core/error/exception.dart';
import 'package:healing_travelling/core/error/failures.dart';
import 'package:healing_travelling/core/platform/network_info.dart';
import 'package:healing_travelling/login/data/datasource/user_local_data_source.dart';
import 'package:healing_travelling/login/data/datasource/user_remote_data_source.dart';
import 'package:healing_travelling/login/data/models/user_data_model.dart';
import 'package:healing_travelling/login/data/repositories/user_repository_impl.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late UserRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource
    );
  });

  group('getUserData', () {
    const tEmail = 'budi@gmail.com';
    const tPassword = 'bangkong';
    const tDataModel = DataModel(id: 1, name: 'budi', email: tEmail, address: 'bandung', role: 'user');
    const tUserModel = UserDataModel(data: tDataModel, token: '1234');
    const User tUser = tUserModel;

    test('should check if the device is online', () async {
      //arrange
      when(()=>mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.postAuth(tEmail, tPassword);
      //assert
      verify(()=>mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp((){
        when((() => mockNetworkInfo.isConnected)).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successfull', () async {
        //arrange
        when(() => mockRemoteDataSource.getUserData(tEmail, tPassword))
          .thenAnswer((_) async => tUserModel);
        //act
        final result = await repository.postAuth(tEmail, tPassword);
        //assert
        verify(() => mockRemoteDataSource.getUserData(tEmail, tPassword));
        expect(result, equals(Right(tUser)));
      });

      test('should return ServerException when the call to remote data source is failed', () async {
        //arrange
        when(() => mockRemoteDataSource.getUserData(tEmail, tPassword))
          .thenThrow(ServerException());
        //act
        final result = await repository.postAuth(tEmail, tPassword);
        //assert
        verify(() => mockRemoteDataSource.getUserData(tEmail, tPassword));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('device is offline', () {

      setUp((){
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should get cached user data when cached data present', () async {
        //arange
        when(() => mockLocalDataSource.getLocalUserData())
          .thenAnswer((_) async => tUserModel);
        //act
        final response = await repository.fetchUserData();
        //assert
        verify((() => mockLocalDataSource.getLocalUserData()));
        expect(response, equals(Right(tUser)));
      });

      test('should return ServerException when the call to remote data source is failed', () async {
        //arrange
        when(() => mockLocalDataSource.getLocalUserData())
          .thenThrow(CacheException());
        //act
        final result = await repository.fetchUserData();
        //assert
        verify(() => mockLocalDataSource.getLocalUserData());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
  
}