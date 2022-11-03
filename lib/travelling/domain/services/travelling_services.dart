import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healing_travelling/travelling/domain/models/travelling_model.dart';
import 'package:healing_travelling/travelling/domain/repositories/travelling_repository.dart';
import 'package:healing_travelling/utils/config.dart';

class TravellingService implements TravellingRepository {
  final Dio _dio = Dio();

  @override
  Future<Either<String, List<Travel>>> getTravelling(String page, String? token) async {
    try {
      final response = await _dio.getUri(
        Uri.https(
          url, 
          '/api/travel',
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
        final decoder = await compute(travelFromJson, jsonEncode(response.data), debugLabel: 'travelling');
        return Right(decoder);
      } else {
        throw response.statusMessage.toString();
      }
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
  
}