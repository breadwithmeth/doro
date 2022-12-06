import 'dart:ui';

import 'package:doro/pages/servicePage.dart';
import 'package:doro/pages/settings.dart';
import 'package:doro/pages/trainingCalendar.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget trainings = Text("");
  Widget services = Text("Нет абониментов");

  Map<String, dynamic> data = {};
  Widget photo = CircleAvatar(
    child: Icon(Icons.photo_camera_outlined),
  );
  bool isTrainingsEmpty = true;
  @override
  void initState() {
    // TODO: implement initState
    getCustomerInfo();
    buildTrainings();
    buildServices();
    super.initState();
  }

  Future<void> getCustomerInfo() async {
    Map<String, dynamic> response = await getCustomer();

    setState(() {
      data = response;
      if (response['photo'] != null) {
        photo = CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(response['photo']),
        );
      }
      print(data);
    });
  }

  Future<void> buildTrainings() async {
    List<dynamic>? res = await getTrainings();
    List<Widget> listOfTrainings = [];

    if (res != null) {
      res.forEach((element) {
        listOfTrainings.add(Container(
            height: 60,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.center, colors: <Color>[
                  Color.fromARGB(24, 222, 231, 247),
                  Color.fromARGB(49, 202, 219, 247),
                ]),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.all(7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      element["name"],
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    Row(
                      children: [
                        Text(element["training_start"] +
                            "-" +
                            element["training_end"]),
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TrainingPage(Training: element)),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            )));
      });
      setState(() {
        if (listOfTrainings.length != 0) {
          isTrainingsEmpty = false;
          trainings = Column(
            children: listOfTrainings,
          );
        }
      });
    }
  }

  Future<void> buildServices() async {
    List<dynamic>? res = await getServices();
    List<Widget> listOfServices = [];
    print(res);
    if (res != null) {
      res.forEach((element) {
        print(element);
        listOfServices.add(Container(
            height: 60,
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.center, colors: <Color>[
                  Color.fromARGB(24, 222, 231, 247),
                  Color.fromARGB(49, 202, 219, 247),
                ]),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.all(7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      element["name"],
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TrainingPage(Training: element)),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            )));
      });
      setState(() {
        if (listOfServices.length != 0) {
          services = Column(
            children: listOfServices,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(shrinkWrap: true, padding: EdgeInsets.all(10), children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // photo,
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data['last_name'] ?? "",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Text(data['first_name'] ?? "",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Предстоящие тренировки",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.edit_calendar_outlined))
                  ],
                ),
                isTrainingsEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "🐛",
                                style: TextStyle(
                                  fontSize: 90,
                                  fontFamily: "Noto Emoji",
                                ),
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TrainingCalendar()),
                                    );
                                  },
                                  child: Text("Календарь тренировок"))
                            ],
                          )
                        ],
                      )
                    : trainings,
                Divider()
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ваши Абонименты",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                services
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: Colors.grey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.settings_sharp,
                color: Colors.white,
              ),
              Text(
                " Настройки",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )
            ],
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        )
      ]),
    );
  }
}
