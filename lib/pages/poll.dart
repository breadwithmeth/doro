import 'package:doro/main.dart';
import 'package:doro/pages/bottomMenu.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Poll extends StatefulWidget {
  const Poll({super.key, required this.poll});
  final Map<String, dynamic> poll;
  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {
  Widget currentPage = Container();
  List<Widget> questions = [];
  int questionNumber = 0;
  List<String> answers = [];

  void initPoll() {
    setState(() {
      currentPage = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.poll["name"],
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 30),
          ),
          Text(widget.poll["description"]),
          TextButton(
              onPressed: (() {
                startTest();
              }),
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset.fromDirection(0.5, 10),
                            color: Colors.orange.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 5)
                      ]),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Начать",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ],
                  )))
        ],
      );
    });
  }

  void startTest() {
    List<Widget> tempQuestions = [];
    List? questionsTemp = widget.poll["questions"];
    questionsTemp!.forEach((value) {
      List<Widget> tempAnswers = [];
      value["answers"].forEach((value) {
        tempAnswers.add(TextButton(
            onPressed: (() {
              answerQuestion(value["answer_id"]);
            }),
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset.fromDirection(0.5, 10),
                          color: Colors.orange.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 5)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value["title"],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w900),
                        ),
                        Row(
                          children: [
                            Text(
                              value["description"],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ))));
      });
      tempQuestions.add(Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(children: [
              Spacer(),
              Text(
                value["title"],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
              Divider(),
              Text(value["description"]),
              Spacer()
            ]),
          ),
          Column(
            children: tempAnswers,
          )
        ],
      )));
    });
    setState(() {
      questions = tempQuestions;
      currentPage = questions[questionNumber];
    });
  }

  Future<void> answerQuestion(String answer_id) async {
    setState(() {
      answers.add(answer_id);
    });
    if (questionNumber == questions.length - 1) {
      setState(() {
        currentPage = Center(
          child: Column(children: [Text("Ваши ответы загружаются", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),), CircularProgressIndicator()]),
        );
      });
      if (await sendAnswers()) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyApp()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        questionNumber++;
        currentPage = questions[questionNumber];
      });
    }
  }

  Future<bool> sendAnswers() async {
    int status = await sendPollAnswers(answers);
    if (status == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPoll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: currentPage)));
  }
}
