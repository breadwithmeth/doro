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
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                title: Row(children: [Text(temp[index]['name']), Text(temp[index]['amount_of_requests'] + "/" + temp[index]['amount_of_customers'])]),
                subtitle: Column(
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(temp[index]['training_start'] +
                            "-" +
                            temp[index]['training_end']),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text("Тренер " +
                            temp[index]['last_name'] +
                            " " +
                            temp[index]['first_name'])
                      ],
                    )
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: null,
                ),
              ),
            );
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: trainings,
    );
  }
}