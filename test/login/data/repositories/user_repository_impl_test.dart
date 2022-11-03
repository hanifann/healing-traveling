import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/core/platform/network_info.dart';
import 'package:healing_travelling/login/data/datasource/user_remote_data_source.dart';
import 'package:healing_travelling/login/data/models/user_data_model.dart';
import 'package:healing_travelling/login/data/repositories/user_repository_impl.dart';
import 'package:healing_travelling/login/domain/entity/user.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UserRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
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
    });
  });
  
}