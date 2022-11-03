// To parse this JSON data, do
//
//     final travel = travelFromJson(jsonString);

import 'dart:convert';

List<Travel> travelFromJson(String str) => List<Travel>.from(json.decode(str).map((x) => Travel.fromJson(x)));

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
        this.isWishlist = false
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
    bool? isWishlist;

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
