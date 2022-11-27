import 'package:doro/pages/bottomMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/colors.dart';

class successPage extends StatefulWidget {
  const successPage({super.key, required this.successMessage});
  final String successMessage;
  @override
  State<successPage> createState() => successPageState();
}

class successPageState extends State<successPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.green,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.successMessage,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                          Divider(height: 10,)
                ],
              ),
            ),
            Spacer(),
            TextButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomMenu(),
                    ),
                  );
                }),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.amber),
                  padding: EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Вернуться в меню",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
