import 'package:doro/pages/error.dart';
import 'package:doro/pages/success.dart';
import 'package:doro/utils/api.dart';
import 'package:doro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class JoinTraining extends StatefulWidget {
  const JoinTraining({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<JoinTraining> createState() => _JoinTrainingState();
}

class _JoinTrainingState extends State<JoinTraining> {
  Widget RowNameValue(name, value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
          ),
          Text(value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        ],
      ),
    );
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
                  Text(widget.data['name'] ?? "213",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                ],
              ),
            ),
            RowNameValue("Название услуги", widget.data["name"] ?? ""),
            RowNameValue("name", widget.data["training_id"] ?? ""),
            Spacer(),
            TextButton(
                onPressed: (() async {
                  int status = await joinTraining(widget.data["training_id"]);
                  if (status != 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => errorPage(
                          errorCode: status,
                        ),
                      ),
                    );
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => successPage(
                          successMessage: "Приятной тренировки",
                        ),
                      ),
                    );
                  }
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
                          "Подтвердить",
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
