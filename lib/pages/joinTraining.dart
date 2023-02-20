import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class JoinTraining extends StatefulWidget {
  const JoinTraining({super.key, required this.schedule_id});
  final int schedule_id;
  @override
  State<JoinTraining> createState() => _JoinTrainingState();
}

class _JoinTrainingState extends State<JoinTraining> {



  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Спасибо за посещение тренировки", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),),);
  }
}
