import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
    required this.length
  }) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.only(top: 28),
      decoration: BoxDecoration(
        color: Colors.grey[200]
      ),
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (context, index){
          return Container(
            width: 300,
            height: 161,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/banner.png'),
                fit: BoxFit.cover
              )
            ),
          );
        }, 
        separatorBuilder: (_,__) => SizedBox(width: 10,), 
        itemCount: length
      ),
    );
  }
}