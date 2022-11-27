import 'dart:convert';
import 'dart:io';

import 'package:doro/pages/buyService.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../utils/colors.dart';

class QR extends StatefulWidget {
  const QR({Key? key}) : super(key: key);

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
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
                Map<String, dynamic> data = await sendQR(code);
                if (data['qr_type'] == "sell_service") {
                  cameraController.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyService(
                        data: data,
                      ),
                    ),
                  );
                }
              }
            }),
        Container(
          margin: EdgeInsets.only(bottom: 100),
          child: TextButton(
            child: Container(
              decoration: BoxDecoration(
                  color: doro_yellow,
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
