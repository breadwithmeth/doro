import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key, required this.training_id});
  final String training_id;
  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}