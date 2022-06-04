import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppbarWidget extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppbarWidget({ Key? key, required this.appBar, required this.title }) : super(key: key);
  final AppBar appBar;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 8,
            color: Color.fromRGBO(37, 37, 37, 1).withOpacity(.1)
          )
        ]
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(31, 28, 28, 1)),
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromRGBO(31, 28, 28, 1)
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}