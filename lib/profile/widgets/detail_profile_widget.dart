import 'package:flutter/material.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';
import 'package:healing_travelling/widget/custom_text_widget.dart';

class ContainerDetailProfileWidget extends StatelessWidget {
  const ContainerDetailProfileWidget({
    Key? key, 
    this.shadowOffset = const Offset(0,2),
  }) : super(key: key);

  final Offset shadowOffset;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 23, 23, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: shadowOffset,
            blurRadius: 20,
            color: Colors.black.withOpacity(.2)
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sideContainer(),
          SizedBox(width: 12,),
          _containerPicture(),
          SizedBox(width: 21,),
          _columnDataPengguna(),
        ],
      ),
    );
  }

  Column _columnDataPengguna() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: SharedPreferenceSingleton.getString('name')!,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: kSecondaryColor,
        ),
        CustomTextWidget(
          text: 'budi@gmail.com',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: kPrimaryColor,
        ),
      ],
    );
  }


  Stack _containerPicture() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/user.png')
            ),
            borderRadius: BorderRadius.circular(41)
          ),
        ),
        Container(
          width: 22,
          height: 22,
          margin: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(122, 211, 122, 1),
            border: Border.all(
              width: 1.5,
              color: Colors.white
            )
          ),
        )
      ],
    );
  }

  Container _sideContainer() {
    return Container(
      height: 116,
      width: 9,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5)
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(1,2),
            blurRadius: 3,
            color: Colors.black.withOpacity(.15)
          )
        ]
      ),
    );
  }
}