import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:healing_travelling/utils/config.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';
import 'package:healing_travelling/wishlist/domain/models/wishlist_model.dart';
import 'package:healing_travelling/wishlist/domain/repositories/wishlist_repository.dart';

class WishListService implements WishListRepository {

  final Dio _dio = Dio();
  final String token = SharedPreferenceSingleton.getString('token')!;


  @override
  Future<Either<String, String>> deleteWishlist(String id) async {
    try {
      final response = await _dio.deleteUri(
        Uri.https(
          url, 
          '/api/wishlist/$id',
        ),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );
      if(response.statusCode == 200){
        return Right(response.statusMessage!);
      } else {
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, Wishlist>> getWishlist(String id) async {
    try {
      final response = await _dio.getUri(
        Uri.https(
          url, 
          '/api/wishlist/$id',
        ),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );
      if(response.statusCode == 200){
        final decoder = await compute(wishlistFromJson, jsonEncode(response.data), debugLabel: 'wishlist');
        return Right(decoder);
      } else {
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, String>> postWishlist(String travelId) async {
    try {
      final response = await _dio.postUri(
        Uri.https(
          url, 
          '/api/wishlist',
        ),
        data: {
          'user_id': SharedPreferenceSingleton.getString('id'),
          'travel_id': travelId
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );
      if(response.statusCode == 200){
        return Right(response.statusMessage!);
      } else {
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
}