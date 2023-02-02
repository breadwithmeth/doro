import 'package:video_player/video_player.dart';
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
  List videos = [];
  Map<String, dynamic> news = {};
  List<Widget> sections = [];
  Future<void> getNewsSinglePage() async {
    Map<String, dynamic> tempNews = await getNewsById(widget.news_id);
    List tempSectionObj = tempNews['sections'];
    List<Widget> tempSections = [];
    tempSectionObj.forEach((element) {
      if (element['type'] == "text") {
        tempSections.add(Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Text(
            element['section'],
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ));
      } else if (element['type'] == "img") {
        tempSections.add(Container(
          padding: EdgeInsets.all(10),
          child: Image.network(element['section']),
        ));
      } else if (element['type'] == "video") {
        tempSections.add(Container(
          padding: EdgeInsets.all(10),
          child: VideoPlayerCustom(videoUrl: element['section']),
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Новости"),
        ),
        body: ListView(
          children: [
            checkIfNull(news["cover"])
                ? Image.network(news["cover"])
                : Container(),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                news['title'] ?? "",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              ),
            ),
            Column(
              children: sections,
            )
          ],
        ));
  }
}

class VideoPlayerCustom extends StatefulWidget {
  const VideoPlayerCustom({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  State<VideoPlayerCustom> createState() => _VideoPlayerCustomState();
}

class _VideoPlayerCustomState extends State<VideoPlayerCustom> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isPlayed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
      IconButton(
          onPressed: (() {
            if (isPlayed) {
              _controller.pause();
              setState(() {
                isPlayed = false;
              });
            } else {
              _controller.play();
              setState(() {
                isPlayed = true;
              });
            }
          }),
          icon: Icon(Icons.play_arrow))
    ]);
  }
}
