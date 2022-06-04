import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:healing_travelling/register/domain/models/register_model.dart';
import 'package:healing_travelling/register/domain/repositories/register_repository.dart';
import 'package:healing_travelling/utils/config.dart';

class RegisterService implements RegisterRepository {
  final Dio _dio = Dio();

  @override
  Future<Either<String, String>> postRegister(Register register) async {
    try {
      final response = await _dio.postUri(
        Uri.http(url, '/api/register'),
        data: register.toJson()
      );
      if(response.statusCode == 200){
        return Right(response.data['message']);
      } else {
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}