import 'package:doro/pages/trainingsForDay.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingCalendar extends StatefulWidget {
  const TrainingCalendar({super.key});

  @override
  State<TrainingCalendar> createState() => _TrainingCalendarState();
}

class _TrainingCalendarState extends State<TrainingCalendar> {
  DateTime _selectedDay = DateTime.now();
  List? events = [];
  List<dynamic> _getEventsForDay(DateTime day) {
    List<dynamic> eventsForDay = [];
    if (events != null) {
      events?.forEach((element) {
        DateTime tempDate = DateTime.parse(element['training_date']);
        // print(tempDate);
        // if (date1.year == date2.year && date1.month == date2.month && date1.day == date2.day) {

        // }
        if (tempDate.year == day.year &&
            tempDate.month == day.month &&
            tempDate.day == day.day) {
          eventsForDay.add(day);
        }
      });
    }
    return eventsForDay;
    // print(day);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvents();
  }

  Future<void> getEvents() async {
    List? temp = await getTrainigsScheduleCustomer();
    // print(temp);

    setState(() {
      events = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Календарь тренировок",
        ),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              canMarkersOverflow: false,
              markersMaxCount: 5,
              markerDecoration:
                  BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              selectedTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              selectedDecoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.amber, Colors.amberAccent]),
                  shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 5),
                  shape: BoxShape.circle),
              todayTextStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            locale: 'ru_RU',
            focusedDay: _selectedDay,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2023, 12, 30),
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: ((selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainingsForDay(date: selectedDay),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
