import 'package:doro/pages/newsPage.dart';
import 'package:doro/utils/api.dart';
import 'package:doro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<dynamic> news = [];
  Future<void> downloadNews() async {
    List<dynamic> res = await getNews();
    setState(() {
      news = res;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadNews();
  }

  bool checkIfNull(String? smt) {
    if (smt == null || smt.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 100),
      itemCount: news.length,
      itemBuilder: ((context, index) {
        return ListTile(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsPage(
                  news_id: news[index]["news_id"],
                ),
              ),
            );
          }),
          contentPadding: EdgeInsets.all(0),
          title: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primary_background,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                checkIfNull(news[index]["cover"])
                    ? Image.network(
                        news[index]["cover"],
                        width: MediaQuery.of(context).size.width * 0.4,
                      )
                    : Container(),
                    Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news[index]["title"]!.length > 20?
                      news[index]["title"].substring(0, 20) ?? "":
                      news[index]["title"] ?? "",
                      style: TextStyle(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: 
                    
                      Text(
                        news[index]["description"] ?? "",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                  )
                    ,
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
