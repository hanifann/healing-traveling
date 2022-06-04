import 'package:flutter/material.dart';
import 'package:healing_travelling/home/screens/home_screen.dart';
import 'package:healing_travelling/themes/color_themes.dart';
import 'package:healing_travelling/travelling/screens/travelling_screen.dart';
import 'package:healing_travelling/wishlist/screens/wishlist_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({ Key? key }) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final List<BottomNavigationBarItem> _navbarItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.luggage_outlined),
      label: 'Travelling'
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      label: 'Wishlist'
    ),
  ];

  final List _navbarScreen = [
    HomeScreen(),
    TravellingScreen(),
    WishlishtScreen(),
  ];

  int _index = 0;

  void _onItemTapped(int index){
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navbarScreen[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 9,
              color: Colors.black.withOpacity(.15)
            )
          ]
        ),
        child: BottomNavigationBar(
          items: _navbarItem,
          currentIndex: _index,
          onTap: _onItemTapped,
          selectedItemColor: kPrimaryColor,
          elevation: 0,
        ),
      ),
    );
  }
}