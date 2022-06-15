import 'package:flutter/material.dart';
import 'package:healing_travelling/auth/screens/auth_screen.dart';
import 'package:healing_travelling/profile/widgets/detail_profile_widget.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/utils/shared_preference_singleton.dart';
import 'package:healing_travelling/widget/custom_appbar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: CustomAppbarWidget(
        appBar: AppBar(), 
        title: 'Profil'
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ContainerDetailProfileWidget(),
          ),
          Spacer(),
          Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 8.0,),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  color: Colors.black.withOpacity(.15)
                )
              ]
            ),
            child: ElevatedButton.icon(
              onPressed: () async {
                await SharedPreferenceSingleton.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_)=> AuthScreen()
                  ),
                  (route) => false
                );
              }, 
              icon: Icon(Icons.logout), 
              label: Text('Keluar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                alignment: Alignment.centerLeft
              ),
            )
          )
        ],
      ),
    );
  }
}