import 'package:flutter/material.dart';
import 'package:mapplication/widgets/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(),
          )
        ],
      ),
    );
  }
}
