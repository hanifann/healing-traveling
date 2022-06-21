import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healing_travelling/login/domain/repositories/login_repository.dart';
import 'package:healing_travelling/login/models/user_model.dart';
import 'package:healing_travelling/utils/config.dart';

class LoginService implements LoginRepository {
  final Dio _dio = Dio();

  @override
  Future<Either<String, User>> postLogin(String email, String password) async {
    try {
      final response = await _dio.postUri(
        Uri.https(url, '/api/login'),
        data: {
          'email': email,
          'password': password
        }
      );
      if(response.statusCode == 200){
        final decoder = await compute(userFromJson, jsonEncode(response.data));
        return Right(decoder);
      } else {
        throw response.statusMessage.toString();
      }
    } on DioError catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}