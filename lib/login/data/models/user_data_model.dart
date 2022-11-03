import 'package:healing_travelling/login/domain/entity/user.dart';

class UserDataModel extends User {
  const UserDataModel({required DataModel data, required String token}) : super(data: data, token: token);


  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      data: DataModel.fromJson(json['data']),
      token: json['token']
    );
  }

  Map<String, dynamic> toJson() => {
    "data": {
      "id": data.id,
      "name": data.name,
      "email": data.email,
      "address": data.address,
      "role": data.role,
    },
    "token": token
  };
}

class DataModel extends Data {
  const DataModel({required int id, required String name, required String email, required String address, required String role}) : super(id: id, name: name, email: email, address: address, role: role);

  factory DataModel.fromJson(Map<String, dynamic> json){
    return DataModel(
      id: json['id'], 
      name: json['name'], 
      email: json['email'], 
      address: json['address'], 
      role: json['role']
    );
  }
}