import 'dart:ui';

import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key, required this.schedule_id});
  final String schedule_id;
  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  Widget enrollButton = Container();

  Widget serviceInfo = Center(
    child: CircularProgressIndicator(
      color: Colors.yellow,
    ),
  );
  Widget reasons = Container();
  Widget reasonsTemporary = Container();

  Map<String, dynamic> service_info = {};
  NetworkImage image1 =
      NetworkImage("https://source.unsplash.com/random/?sport");
  Future<void> getInfo() async {
    Map<String, dynamic> temp =
        await getServiceByScheduleId(widget.schedule_id);
    print(temp);

    List reasonsT = temp['reasons'];
    List<Widget> tempReasons = [];
    reasonsT.forEach((element) {
      tempReasons.add(TextButton(
          onPressed: (() {
            enrollTraining(widget.schedule_id, element["order_id"], element["type"]);
            Navigator.pop(context);
            Navigator.pop(context);
          }),
          child: Container(
              margin: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        element['name'] + "#" + element['order_id'],
                        style: TextStyle(color: Colors.black),
                      ),
                      element['unlimited'] == "1"
                          ? Text("Безлимитный")
                          : Container()
                    ],
                  ),
                  Row(
                    children: [Text("до " + element['exploration_date'])],
                  )
                ],
              ))));
    });
    setState(() {
      reasonsTemporary = Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: SingleChildScrollView(
              child: Column(children: tempReasons),
            )),
      );
      service_info = temp;
      image1 = NetworkImage("https://source.unsplash.com/random/?sport");
      enrollButton = service_info['is_enrolled'] != null
          ? TextButton(
              onPressed: (() {
                cancelEnrollTraining(widget.schedule_id);
                Navigator.pop(context);
                Navigator.pop(context);
              }),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Отменить",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        colors: [Color(0xFF9DFBC8), Color(0xFF788CB6)])),
              ))
          : TextButton(
              onPressed: (() {
                setState(() {
                  reasons = reasonsTemporary;
                });

                
              }),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Записаться",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        colors: [Color(0xFFF9D976), Color(0xFFF5D020)])),
              ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: image1, fit: BoxFit.cover),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xF1FB7BA2), Color(0xF1FCE043)])),
        ),
        ListView(
          children: [
            ListTile(
              title: Container(
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [enrollButton],
            ),
            ListTile(
              title: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              service_info['name'] ?? "123",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 30),
                            ),
                            Text(
                              (service_info['organization_name'] ?? "123") +
                                  " > " +
                                  (service_info['area_name'] ?? "123"),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.people_outline),
                                    Text(
                                        (service_info['amount_of_requests'] ??
                                                "0") +
                                            "/" +
                                            (service_info[
                                                    'amount_of_customers'] ??
                                                "0"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.watch_later_outlined),
                                    Text(
                                      service_info['training_start'] ?? "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.timelapse_outlined),
                                    Text(
                                      service_info['duration'] ?? "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(" минут")
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              service_info['provider_photo'] ?? ""),
                          radius: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(
                          service_info['provider_name'] ?? "0",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        reasons
      ],
    ));
  }
}
