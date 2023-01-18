import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.news_id});
  final String news_id;
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Map<String, dynamic> news = {};
  List<Widget> sections = [];
  Future<void> getNewsSinglePage() async {
    Map<String, dynamic> tempNews = await getNewsById(widget.news_id);
    List tempSectionObj = tempNews['sections'];
    List<Widget> tempSections = [];
    tempSectionObj.forEach((element) {
      if (element['type']=="text") {
        
      tempSections.add(Container(
        width: double.infinity,
                 padding: EdgeInsets.all(10),
        child: Text(element['section'], textAlign: TextAlign.left, style: TextStyle(fontSize: 18),),
      ));
      }else if(element['type']=="img"){
         tempSections.add(Container(
                 padding: EdgeInsets.all(10),

        child: Image.network(element['section']),
      ));
      }
    });
    setState(() {
      news = tempNews;
      sections = tempSections;
      print(sections);
    });
  }

  bool checkIfNull(String? smt) {
    if (smt == null || smt.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsSinglePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: Colors.black, title: Text("Новости"),),
        body: ListView(
      children: [
        checkIfNull(news["cover"]) ? Image.network(news["cover"]) : Container(),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            news['title'] ?? "",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
          ),
        ),
        Column(children: sections,)
      ],
    ));
  }
}
