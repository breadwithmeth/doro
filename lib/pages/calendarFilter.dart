import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CalendarFilter extends StatefulWidget {
  const CalendarFilter({super.key});

  @override
  State<CalendarFilter> createState() => _CalendarFilterState();
}

class _CalendarFilterState extends State<CalendarFilter> {
  String dropdownValue = "1";
  double _currentSliderValue = 0;
  List<DropdownMenuItem<String>> serviceCategories = [DropdownMenuItem(
          child: Text("Показать все"),
          value: "0",
        )];
  @override
  void initState() {
    super.initState();
    getFilters();
  }

  Future<void> getFilters() async {
    List<DropdownMenuItem<String>> serviceCategoriesTemp = [];
    List<dynamic>? temp = await getServiceCategories();
    temp?.forEach(
      (element) {
        print(element);
        serviceCategoriesTemp.add(DropdownMenuItem(
          child: Text(element['name']),
          value: element['category_id'],
        ));
      },
    );
    setState(() {
      serviceCategories = serviceCategoriesTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("Фильтрация"),
      ),
      body: ListView(children: [
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text(
            "Вид",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue.isNotEmpty ? dropdownValue : null,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.amber,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                  print(dropdownValue);
                });
              },
              items: serviceCategories),
        ),
        Slider(
        activeColor: Colors.amber,
        inactiveColor: Colors.indigo.shade100,
          value: _currentSliderValue,
          max: 500,
          divisions: 20,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
      ]),
    );
  }
}
