// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

class Wishlist {
    Wishlist({
        this.success,
        this.data,
    });

    bool? success;
    List<Datum>? data;

    factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );
}

class Datum {
    Datum({
        this.id,
        this.travelId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.travel,
    });

    int? id;
    int? travelId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Travel? travel;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        travelId: json["travel_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        travel: Travel.fromJson(json["travel"]),
    );
}

class Travel {
    Travel({
        this.id,
        this.title,
        this.price,
        this.description,
        this.startDate,
        this.endDate,
        this.lodging,
        this.transportation,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? title;
    String? price;
    String? description;
    DateTime? startDate;
    DateTime? endDate;
    String? lodging;
    String? transportation;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Travel.fromJson(Map<String, dynamic> json) => Travel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        lodging: json["lodging"],
        transportation: json["transportation"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}
