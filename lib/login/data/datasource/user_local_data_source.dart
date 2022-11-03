import 'dart:convert';

import 'package:healing_travelling/core/error/exception.dart';
import 'package:healing_travelling/login/data/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource  {
  Future<UserDataModel>? getLocalUserData();
  Future<void>? cachedUserData(UserDataModel userDataModel);
}

const USER_DATA_KEY = 'user_data';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void>? cachedUserData(UserDataModel userDataModel) {
    return sharedPreferences.setString(
      USER_DATA_KEY,
      jsonEncode(userDataModel)
    );
  }

  @override
  Future<UserDataModel>? getLocalUserData() {
    final jsonString = sharedPreferences.getString(USER_DATA_KEY);
    if(jsonString != null) {
      return Future.value(UserDataModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}