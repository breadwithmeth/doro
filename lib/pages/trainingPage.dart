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
  Map<String, dynamic> service_info = {};
  NetworkImage image1 =
      NetworkImage("https://source.unsplash.com/random/?sport");
  Future<void> getInfo() async {
    Map<String, dynamic> temp =
        await getServiceByScheduleId(widget.schedule_id);
    print(temp);
    setState(() {
      service_info = temp;
      image1 = NetworkImage("https://source.unsplash.com/random/?sport");
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
        body: 
        service_info != null ?
        Stack(
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
            ListTile(
              title: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                              service_info['organization_name']?? "123",
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
                                        service_info['amount_of_requests']?? "123" +
                                            "/" +
                                            service_info['amount_of_customers']?? "123",
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
                                      service_info['training_start']?? "123",
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
                                      service_info['duration']?? "123",
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
                    Row(
                      children: [Text(service_info['provider_name']?? "123")],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                service_info['is_enrolled'] != null
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
                              gradient: LinearGradient(colors: [
                                Color(0xFF9DFBC8),
                                Color(0xFF788CB6)
                              ])),
                        ))
                    : TextButton(
                        onPressed: (() {
                          enrollTraining(widget.schedule_id);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          
                        }),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Записаться",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(colors: [
                                Color(0xFFF9D976),
                                Color(0xFFF5D020)
                              ])),
                        ))
              ],
            )
          ],
        )
      ],
    )  :Text("123")
);
  }
}
