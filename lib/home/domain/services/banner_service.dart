import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healing_travelling/home/domain/models/banner_model.dart';
import 'package:healing_travelling/home/domain/repositories/banner_repository.dart';
import 'package:healing_travelling/utils/config.dart';

class BannerService implements BannerRepository {

  final Dio _dio = Dio();

  @override
  Future<Either<String, List<Banner>>> getBanner(String? token) async {
    try {
      final response = await _dio.getUri(
        Uri.https(url, '/api/banner'),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );
      if(response.statusCode == 200){
        final decoder = await compute(bannerFromJson, jsonEncode(response.data));
        return Right(decoder);
      } else {
        throw Exception('Failed to get banner ${response.statusMessage}');
      }
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
  
}