import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:healing_travelling/login/data/models/user_data_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tUserDataModel = UserDataModel(data: DataModel(id: 1, name: 'budi', email: 'budi@gmail.com', address: 'bandung', role: 'user'), token: '1234');
  
  test('should be a sublcass of a entity', () async {
    //assert
    expect(tUserDataModel, isA<UserDataModel>());
  });

  group('fromJson', () {
    test('should return a valid model when json data called', () async {
      //arrange
      final Map<String, dynamic> jsonMap = 
        jsonDecode(fixture('user_response.json'));
      //act
      final result = UserDataModel.fromJson(jsonMap);
      //assert
      expect(result, tUserDataModel);
    });
  });

  group('toJson', () {
    test('should return json map containing proper data', () async {
      //act
      final result = tUserDataModel.toJson();
      final expectedJsonMap = {
        "data": {
          "id": 1,
          "name": "budi",
          "email": "budi@gmail.com",
          "address": "bandung",
          "role": "user",
        },
        "token": "1234"
      };
      //assert
      expect(result, expectedJsonMap);
    });
  });
}