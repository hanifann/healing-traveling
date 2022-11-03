import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healing_travelling/artikel/domain/models/rekomendasi_model.dart';
import 'package:healing_travelling/artikel/domain/repositories/rekomendasi_repository.dart';
import 'package:healing_travelling/utils/config.dart';

class RekomendasiService implements RekomendasiRepository {

  final Dio _dio = Dio();

  @override
  Future<Either<String, List<Rekomendasi>>> getRekomendasi(String page, String? token) async {
    try {
      final response = await _dio.getUri(
        Uri.https(
          url, 
          '/api/recomendation',
          {
            'page': page
          },
        ),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );
      if(response.statusCode == 200){
        final decoder = await compute(rekomendasiFromJson, jsonEncode(response.data));
        return Right(decoder);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
}