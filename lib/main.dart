import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:mapplication/views/login_view.dart';
=======
import 'package:mapplication/loginScreen.dart';
import 'package:mapplication/home_screen.dart';
>>>>>>> master

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen()
    );
=======
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
>>>>>>> master
  }
}
