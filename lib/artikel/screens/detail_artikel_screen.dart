import 'package:flutter/material.dart';
import 'package:healing_travelling/artikel/domain/models/rekomendasi_model.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/widget/custom_appbar_widget.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailArtikelScreen extends StatelessWidget {
  const DetailArtikelScreen({ Key? key, required this.rekomendasi }) : super(key: key);
  final Rekomendasi rekomendasi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        appBar: AppBar(), 
        title: 'Detail Artikel'
      ),
      body: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: [
            _imageArtikel(),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: rekomendasi.title!,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: rekomendasi.author!,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      CustomTextWidget(
                        text: timeago.format(rekomendasi.updatedAt!, locale: 'id'),
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(rekomendasi.content!,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _imageArtikel() {
    return Container(
      height: 333,
      padding: EdgeInsets.fromLTRB(16, 13, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 8,
              color: Colors.black.withOpacity(.25)
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(rekomendasi.image!),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}