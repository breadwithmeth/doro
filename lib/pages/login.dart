import 'package:doro/pages/bottomMenu.dart';
import 'package:doro/utils/api.dart';
import 'package:doro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final login = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_background,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(40),
              color: Colors.white),
          // width: MediaQuery.of(context).size.width * 0.8,
          // height: MediaQuery.of(context).size.height * 0.8,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Вход",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Войдите чтобы тыгыгыгыгыгы",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: login,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Логин",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Пароль",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Future<bool> isLoggedIn =
                          loginClient(login.text, password.text);
                      if (await isLoggedIn) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => BottomMenu())));
                      }
                      print(login.text);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              "Войти",
                              style: TextStyle(
                                  color: Color(0xFFffffff), fontSize: 20),
                            )
                          ],
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        )),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
