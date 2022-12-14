import 'dart:convert';
import 'dart:io';

import 'package:doro/pages/bottomMenu.dart';
import 'package:doro/pages/buyService.dart';
import 'package:doro/pages/joinTraining.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../utils/colors.dart';

class QRLogin extends StatefulWidget {
  const QRLogin({Key? key}) : super(key: key);

  @override
  State<QRLogin> createState() => _QRLoginState();
}

class _QRLoginState extends State<QRLogin> {
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                debugPrint('Barcode found! $code');
                bool isLoggedIn = await loginClientQR(code);
                if (isLoggedIn) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => BottomMenu())));
                }
              }
            }),
        Container(
          margin: EdgeInsets.only(bottom: 100),
          child: TextButton(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(60))),
              padding: EdgeInsets.all(30),
              child: Icon(
                Icons.arrow_back,
                size: 50,
                color: Colors.white,
              ),
            ),
            onPressed: (() {
              Navigator.pop(context);
            }),
          ),
        )
      ],
    ));
  }
}
