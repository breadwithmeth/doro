import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TrainingPage extends StatefulWidget {
  TrainingPage({super.key, required this.Training});
  dynamic Training;
  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      NetworkImage(widget.Training["photo"] ?? "https://"),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.Training["first_name"] ?? "unknown",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      widget.Training["last_name"] ?? "unknown",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  widget.Training['name'] ?? "rrr",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                )
              ],
            ),
            SizedBox(height: 10,),
            Flexible(
                child: Text(
              widget.Training['description'] ?? "rrr",
              softWrap: true,
            )),
            Row(
              children: [
                Icon(Icons.people_alt),
                Text(
                  widget.Training['amount_of_customers'] ?? "rrr",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                )
              ],
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}
