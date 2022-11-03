import 'dart:convert';

import 'package:healing_travelling/core/error/exception.dart';
import 'package:healing_travelling/login/data/models/user_data_model.dart';
import 'package:healing_travelling/utils/config.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserDataModel>? getUserData(String? email, String? password);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserDataModel>? getUserData(String? email, String? password) async {
    final response = await client.post(
      Uri.https(url, 'api/login'), 
      body: {
        'email': email,
        'password': password
      }
    );
    if(response.statusCode == 200){
      return UserDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}