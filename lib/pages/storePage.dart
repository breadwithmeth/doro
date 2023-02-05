import 'package:doro/pages/error.dart';
import 'package:doro/pages/shoppingCarts.dart';
import 'package:doro/pages/success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  Widget getContainerForStoreMainPage(String title, List<Color> colors, String imageUrl) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomRight,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            image:DecorationImage(image: NetworkImage(imageUrl), opacity: 0.3, fit: BoxFit.cover, alignment: Alignment.centerLeft),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                offset: Offset(3, 3),
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
            gradient: RadialGradient(
                radius: 1,
                center: Alignment.bottomRight,
                colors: colors)),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                
                onPressed: (() {
                  
                }),
                child: getContainerForStoreMainPage(
                    "Абонементы", [Color(0xFFF07654), Color(0xFFF5DF2E)], "https://source.unsplash.com/random/?sport")),
            TextButton(
                onPressed: null,
                child: getContainerForStoreMainPage(
                    "Услуги", [Color(0xFF9FA4C4), Color(0xFFB3CDD1)], "https://source.unsplash.com/random/?gym")),
          ],
        ),
        
      ],
    );
  }
}
