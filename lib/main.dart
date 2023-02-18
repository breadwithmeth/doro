import 'package:doro/pages/bottomMenu.dart';
import 'package:doro/pages/login.dart';
import 'package:doro/pages/poll.dart';
import 'package:doro/utils/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'utils/colors.dart';

void main() async {
  Intl.defaultLocale = 'ru_RU';
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  Widget redir = 
  Scaffold(
  body: 
  Center(child: CircularProgressIndicator(color: Colors.yellow),)
  );

  Future<void> checkIfUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? false;
    print(token);
    if (token != false) {
      Map<String, dynamic> poll = await checkPolls();
      if (poll['questions'].length != 0) {
        setState(() {
          redir = Poll(
            poll: poll,
          );
        });
      } else {
        print("no polls");
        setState(() {
          redir = BottomMenu();
        });
      }
    } else {
      setState(() {
        redir = Login();
      });
    }
  }

  Future<Map<String, dynamic>> checkPolls() async {
    Map<String, dynamic> poll = await getPoll();

    return poll;
  }

  @override
  void initState() {
    super.initState();
    checkIfUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.grey[50],
          primaryColor: Color(0xFFfbb80f),
          primaryIconTheme: IconThemeData(color: Color(0xFFfbb80f)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
          )),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.amber[50],
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFd4af37), width: 5)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Color(0xFFd4af37), width: 5)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: Color(0xFFd4af37),
                    width: 20,
                    style: BorderStyle.solid)),
          ),
        ),
        home: redir);
  }
}
