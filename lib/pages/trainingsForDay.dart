import 'dart:io';

import 'package:doro/pages/trainingPage.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class TrainingsForDay extends StatefulWidget {
  const TrainingsForDay({super.key, required this.date});
  final DateTime date;
  @override
  State<TrainingsForDay> createState() => _TrainingsForDayState();
}

class _TrainingsForDayState extends State<TrainingsForDay> {
  Widget trainings = Text("Выберите тренировку");
  Future<void> getTrainings(DateTime date) async {
    Widget _trainings = ListView();
    List<Widget> listOfTrainings = [];
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    print(formatted);
    List? temp = await getTrainigsForDay(formatted);
    if (temp != null && temp.length > 0) {
      _trainings = ListView.builder(
          padding: EdgeInsets.all(5),
          itemCount: temp.length,
          itemBuilder: ((context, index) {
            List<Widget> services = [];
            for (var service in temp[index]['services']) {
              Widget tempCard = Card(
                color: Colors.white,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicePage(
                                schedule_id: service['schedule_id'],
                              )),
                    );
                  },
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service['name'],
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  service['organization_name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            service['is_enrolled'] != null
                                ? Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF087EE1),
                                              Color(0xFF05E8BA)
                                            ],
                                            end: Alignment.center,
                                            begin: Alignment(-3, -0))),
                                    child: Text(
                                      "Вы записаны",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : Text(""),
                          ],
                        ),
                        Row(
                          children: [Text(service['provider_name'])],
                        )
                      ]),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people_outline),
                          Text(
                              service['amount_of_requests'] +
                                  "/" +
                                  service['amount_of_customers'],
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined),
                          Text(
                            service['training_start'],
                            style: TextStyle(fontWeight: FontWeight.w700),
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
                            service['duration'],
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(" минут")
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
              );
              services.add(tempCard);
            }
            return Container(
              margin: EdgeInsets.symmetric(vertical: 9),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(20),
                // color: Colors.white
                gradient: LinearGradient(
                    colors: [Color(0xFF087EE1), Color(0xFF05E8BA)]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "\t\t" + temp[index]['category_name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Column(children: services)
                ],
              ),
            );
            // return Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(20))),
            //   child: ListTile(
            //     onTap: () {
            //       print("object");
            //     },
            //     tileColor: Colors.white,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(20))),
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            //     title: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //               Text(
            //                 temp[index]['name'],
            //                 style: TextStyle(fontWeight: FontWeight.w700),
            //               ),
            //               Text(temp[index]['organization_name'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey),)

            //               ],
            //               ),
            //               temp[index]['is_enrolled'] != null
            //                   ? Container(
            //                       padding: EdgeInsets.all(5),
            //                       decoration: BoxDecoration(
            //                           borderRadius:
            //                               BorderRadius.all(Radius.circular(30)),
            //                           color: Colors.amber),
            //                       child: Text(
            //                         "Вы записаны",
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontWeight: FontWeight.w700),
            //                       ),
            //                     )
            //                   : Text(""),
            //             ],
            //           ),
            //           Row(children: [
            //             Text(temp[index]['provider_name'] )
            //           ],)
            //         ]),
            //     subtitle: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Row(
            //           children: [
            //             Icon(Icons.people_outline),
            //             Text(
            //                 temp[index]['amount_of_requests'] +
            //                     "/" +
            //                     temp[index]['amount_of_customers'],
            //                 style: TextStyle(fontWeight: FontWeight.w700)),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 2,
            //         ),
            //         Row(
            //           children: [
            //             Icon(Icons.watch_later_outlined),
            //             Text(
            //               temp[index]['training_start'],
            //               style: TextStyle(fontWeight: FontWeight.w700),
            //             )
            //           ],
            //         ),
            //         SizedBox(
            //           height: 2,
            //         ),
            //         Row(
            //           children: [
            //             Icon(Icons.timelapse_outlined),
            //             Text(
            //               temp[index]['duration'],
            //               style: TextStyle(fontWeight: FontWeight.w700),
            //             ),
            //             Text(" минут")
            //           ],
            //         ),
            //         SizedBox(
            //           height: 2,
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          }));
      //_trainings = ListView(children: listOfTrainings);
      setState(() {
        trainings = _trainings;
      });
    } else {
      print("object");
      setState(() {
        trainings = Center(
          child: Text("На эту дату нет тренировок"),
        );
      });
    }
    print(temp);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrainings(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Услуги"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: trainings,
    );
  }
}
