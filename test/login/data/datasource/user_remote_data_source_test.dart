import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/core/error/exception.dart';
import 'package:healing_travelling/login/data/datasource/user_remote_data_source.dart';
import 'package:healing_travelling/login/data/models/user_data_model.dart';
import 'package:healing_travelling/utils/config.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client{}

void main() {
  late UserRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get user data by sign in to app', () {
    const tEmail = 'budi@gmail.com';
    const tPassword = 'bangkong';
    final tUserModel = UserDataModel.fromJson(jsonDecode(fixture('user_response.json')));

    test('should perform post requst on a URL with email and password as body', () async {
      //arrange
      when(() => mockHttpClient.post(Uri.https(url, 'api/login'), body: {
        'email': tEmail,
        'password': tPassword
      })).thenAnswer((_) async => http.Response(fixture('user_response.json'), 200));

      //act
      dataSource.getUserData(tEmail, tPassword);

      //assert
      verify(() => mockHttpClient.post(Uri.https(url, 'api/login'), 
      body: {
        'email': tEmail,
        'password': tPassword
      }));
    });

    test('should return User when the response code is 200 (success)', () async {
      //arrange
      when(() => mockHttpClient.post(Uri.https(url, 'api/login'), body: {
        'email': tEmail,
        'password': tPassword
      })).thenAnswer((_) async => http.Response(fixture('user_response.json'), 200));

      //act
      final result = await dataSource.getUserData(tEmail, tPassword);

      //assert
      expect(result, equals(tUserModel));
    });

    test('should throw serverException when the response code is 404 or other', () async {
      //arange
      when(() => mockHttpClient.post(Uri.https(url, 'api/login'), body: {
        'email': tEmail,
        'password': tPassword
      })).thenAnswer((_) async => http.Response('Something went wrong', 404));

      //act
      final call = dataSource.getUserData;

      //assert
      expect(()=>call(tEmail, tPassword), throwsA(isA<ServerException>()));
    });
  });
}