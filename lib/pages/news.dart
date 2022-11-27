import 'package:doro/utils/api.dart';
import 'package:doro/utils/colors.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: news.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              padding: EdgeInsets.all(5),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          news[index]["title"],
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      news[index]["description"],
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(news[index]["last_name"]),
                          Text(news[index]["first_name"])
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(news[index]["photo"]),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    
  );
  }
}
