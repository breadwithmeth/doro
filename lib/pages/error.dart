import 'package:doro/pages/bottomMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/colors.dart';

class errorPage extends StatefulWidget {
  const errorPage({super.key, required this.errorCode});
  final int errorCode;
  @override
  State<errorPage> createState() => errorPageState();
}

class errorPageState extends State<errorPage> {
  String errorMessage = '123';
  void setErrorMessage() {
    if (widget.errorCode == 402) {
      errorMessage = "Низкий баланс Низкий баланс Низкий баланс Низкий баланс ";
    } else {
      errorMessage = "Ошибка сервера";
    }
    print(errorMessage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setErrorMessage();
  }

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
              color: primary_text,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(errorMessage,
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
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
