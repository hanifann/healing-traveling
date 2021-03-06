import 'package:flutter/material.dart';
import 'package:healing_travelling/artikel/domain/models/rekomendasi_model.dart';
import 'package:healing_travelling/utils/config.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:supercharged/supercharged.dart';

class CardRekomendasiWidget extends StatelessWidget {
  const CardRekomendasiWidget({
    Key? key, 
    required this.rekomendasi,
  }) : super(key: key);
  
  final Datum rekomendasi;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
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
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage('assets/images/wisata.jpg'),
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
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
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