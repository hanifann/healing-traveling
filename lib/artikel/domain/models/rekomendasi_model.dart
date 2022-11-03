// To parse this JSON data, do
//
//     final rekomendasi = rekomendasiFromJson(jsonString);

import 'dart:convert';

List<Rekomendasi> rekomendasiFromJson(String str) => List<Rekomendasi>.from(json.decode(str).map((x) => Rekomendasi.fromJson(x)));

class Rekomendasi {
    Rekomendasi({
        this.id,
        this.title,
        this.content,
        this.author,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? title;
    String? content;
    String? author;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Rekomendasi.fromJson(Map<String, dynamic> json) => Rekomendasi(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        author: json["author"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}
