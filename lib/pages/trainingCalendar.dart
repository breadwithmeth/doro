import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingCalendar extends StatefulWidget {
  const TrainingCalendar({super.key});

  @override
  State<TrainingCalendar> createState() => _TrainingCalendarState();
}

class _TrainingCalendarState extends State<TrainingCalendar> {
  List? events = [];
  List<dynamic> _getEventsForDay(day) {
    return [
      DateTime.utc(2022, 12, 30),
      DateTime.utc(2022, 12, 30),
      DateTime.utc(2022, 12, 30),
      DateTime.utc(2022, 12, 30),
      DateTime.utc(2022, 12, 30),
      DateTime.utc(2022, 12, 30),
      DateTime.utc(2022, 12, 30),
      DateTime.utc(2022, 12, 30),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvents();
  }

  Future<void> getEvents() async {
    List? temp = await getTrainigsScheduleCustomer();
    print(temp);
    setState(() {
      events = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            locale: 'ru_RU',
            focusedDay: DateTime.now(),
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2022, 12, 30),
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
          )
        ],
      ),
    );
  }
}
