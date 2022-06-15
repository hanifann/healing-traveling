// To parse this JSON data, do
//
//     final banner = bannerFromJson(jsonString);

import 'dart:convert';

List<Banner> bannerFromJson(String str) => List<Banner>.from(json.decode(str).map((x) => Banner.fromJson(x)));

class Banner {
    Banner({
        this.id,
        this.title,
        this.caption,
        this.author,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? title;
    String? caption;
    String? author;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        title: json["title"],
        caption: json["caption"],
        author: json["author"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}
