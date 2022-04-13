import 'package:flutter/material.dart';
import 'package:mapplication/views/home_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Eeventify',
      home: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text('Tap again to Exit')
          ),
          child: HomeScreen()
        ),
      )
    );
  }
}
