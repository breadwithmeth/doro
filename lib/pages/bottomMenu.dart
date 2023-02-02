import 'package:doro/pages/news.dart';
import 'package:doro/pages/profile.dart';
import 'package:doro/pages/qr.dart';
import 'package:doro/pages/rating.dart';
import 'package:doro/pages/storePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../utils/colors.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static List<Map<String, dynamic>> _pages = <Map<String, dynamic>>[
    {"widget": News(), "title": "Новости"},
    {"widget": Rating(), "title": "Рейтинг"},

    {
      "widget": QR(),
    },
    {
      "widget": StorePage(),
      "title": "Магазин",
      // "actions": [IconButton(onPressed: null, icon: Icon(Icons.shopping_cart))]
    },
    {
      "widget": Profile(),
      "title": "Мой профиль",
      "actions": [IconButton(onPressed: null, icon: Icon(Icons.settings))]
    },
  ];
  int _selectedIndex = 0; //New
  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QR()));
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: _pages[_selectedIndex]["actions"]??[],
          automaticallyImplyLeading: false,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          // backgroundColor: Color(0xFFf3f3f3),
          backgroundColor: Colors.white,
          title: Container(
            child: Text(
              _pages[_selectedIndex]["title"],
              style: TextStyle(color: Colors.black),
            ),
          )),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.indigo.withOpacity(0.1),
          //     spreadRadius: 1,
          //     blurRadius: 1,
          //     offset: Offset(0, 0), // changes position of shadow
          //   ),
          // ],
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
          //gradient:LinearGradient(colors: [Color(0xFFff6e7f), Color(0xFFbfe9ff)])
        ),
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          iconSize: 26,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey[600],
          selectedItemColor: Colors.black,
          // selectedIconTheme: IconThemeData(shadows: <Shadow>[
          //   Shadow(color: Colors.deepOrangeAccent, blurRadius: 1.0)
          // ]),
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: 'Новости',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.star_rounded),
              icon: Icon(Icons.star_outline_rounded),
              label: 'Рейтинг',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(child: Icon(Icons.qr_code_rounded, color: Colors.white,), backgroundColor: Colors.amber,),
              label: 'qr',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.store),
              icon: Icon(Icons.store_outlined),
              label: 'Магазин',
            ),
            // BottomNavigationBarItem(
            //   icon: IconButton(
            //     style: ButtonStyle(),
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => QR()));
            //     },
            //     icon: Icon(Icons.qr_code_sharp),
            //   ),
            //   label: 'qr',
            //),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Профиль',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black.withOpacity(0.1),
      //           spreadRadius: 1,
      //           blurRadius: 2,
      //           offset: Offset(0, 0), // changes position of shadow
      //         ),
      //       ],
      //       borderRadius: new BorderRadius.only(
      //         topLeft: const Radius.circular(60.0),
      //         topRight: const Radius.circular(60.0),
      //         bottomLeft: const Radius.circular(0.0),
      //         bottomRight: const Radius.circular(0.0),
      //       )),
      //   child: BottomNavigationBar(
      //     iconSize: 26,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     type: BottomNavigationBarType.fixed,
      //     backgroundColor: primary_background,
      //     unselectedItemColor: Colors.grey[600],
      //     selectedItemColor: Colors.black,
      //     // selectedIconTheme: IconThemeData(shadows: <Shadow>[
      //     //   Shadow(color: Colors.deepOrangeAccent, blurRadius: 1.0)
      //     // ]),
      //     currentIndex: _selectedIndex, //New
      //     onTap: _onItemTapped,
      //     items: <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         activeIcon: Icon(Icons.home_rounded),
      //         icon: Icon(Icons.home_outlined),
      //         label: 'Новости',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.qr_code_rounded),
      //         label: 'qr',
      //       ),
      //       // BottomNavigationBarItem(
      //       //   icon: IconButton(
      //       //     style: ButtonStyle(),
      //       //     onPressed: () {
      //       //       Navigator.push(context,
      //       //           MaterialPageRoute(builder: (context) => QR()));
      //       //     },
      //       //     icon: Icon(Icons.qr_code_sharp),
      //       //   ),
      //       //   label: 'qr',
      //       //),
      //       BottomNavigationBarItem(
      //         activeIcon: Icon(Icons.person),
      //         icon: Icon(Icons.person_outline),
      //         label: 'Профиль',
      //       ),
      //     ],
      //   ),
      // ),
      // ElevatedButton(
      //   onPressed: () {},
      //   child: Icon(Icons.menu, color: Colors.white),
      //   style: ElevatedButton.styleFrom(
      //     fixedSize: Size(80, 80),
      //     shape: CircleBorder(),
      //     padding: EdgeInsets.all(20),
      //     backgroundColor: Color(0xFFf3f3f3), // <-- Button color
      //     foregroundColor: Colors.red, // <-- Splash color
      //   ),
      // )

      body: _pages[_selectedIndex]["widget"],
      backgroundColor: Colors.white,
    );
  }
}
