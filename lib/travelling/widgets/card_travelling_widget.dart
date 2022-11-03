import 'package:flutter/material.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/travelling/domain/models/travelling_model.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';

class CardTravellingWidget extends StatelessWidget {
  const CardTravellingWidget({
    Key? key, 
    required this.onTap, 
    required this.isFavorite,
    required this.travel
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isFavorite;
  final Travel travel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
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
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(travel.image!),
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
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 24,
                height: 24,
                margin: EdgeInsets.only(top: 2, right: 5),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: isFavorite == true ? Icon(Icons.favorite, color: Color.fromRGBO(252, 71, 85, 1),size: 18,) : Icon(Icons.favorite_border, size: 18,),
              ),
            ),
          ),
          SizedBox(height: 16,),
          CustomTextWidget(
            text: travel.title!,
            color: kTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          SizedBox(height: 3,),
          Row(
            children: [
              Image.asset('assets/images/placeholder.png', height: 12, width: 12, color: Color.fromRGBO(164, 164, 164, 1),),
              SizedBox(width: 6,),
              CustomTextWidget(
                text: travel.title!.allAfter('di '),
                color: Color.fromRGBO(164, 164, 164, 1),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ],
          ),
          SizedBox(height: 6,),
          CustomTextWidget(
            text: NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(travel.price!)),
            color: kTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}