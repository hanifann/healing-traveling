import 'package:flutter/material.dart';
import 'package:healing_travelling/artikel/domain/models/rekomendasi_model.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:supercharged/supercharged.dart';

class CardRekomendasiWidget extends StatelessWidget {
  const CardRekomendasiWidget({
    Key? key, 
    required this.rekomendasi,
  }) : super(key: key);
  
  final Rekomendasi rekomendasi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(rekomendasi.image!),
                fit: BoxFit.cover
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(.15)
                )
              ]
            ),
          ),
          SizedBox(height: 15,),
          CustomTextWidget(
            text: rekomendasi.title!,
            color: kTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          SizedBox(height: 3,),
          Row(
            children: [
              Image.asset('assets/images/placeholder.png', height: 12, width: 12, color: Color.fromRGBO(164, 164, 164, 1),),
              SizedBox(width: 6,),
              CustomTextWidget(
              text: rekomendasi.title!.allAfter('di '),
              color: Color.fromRGBO(164, 164, 164, 1),
              fontSize: 12,
            ),
            ],
          )
        ],
      ),
    );
  }
}