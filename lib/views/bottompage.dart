import 'package:flutter/material.dart';
import 'package:yiyo/views/anasayfa.dart';
import 'package:yiyo/views/sepet_yemekler_detay.dart';
import 'package:yiyo/views/siparis_ve_odeme.dart';


class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int _selectedIndex = 0;
  static const  List<Widget> _widgetOptions = <Widget>[
    Anasayfa(),
    SepetYemekDetay(),
    SiparisOdeme(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Sepet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle),
            label: 'Sipariş Detay',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
