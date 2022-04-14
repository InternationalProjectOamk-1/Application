import 'package:flutter/material.dart';
import 'package:mapplication/views/home_screen.dart';
import 'package:mapplication/views/login_view.dart';
import 'package:mapplication/views/map_view.dart';
import 'package:mapplication/widgets/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 1);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomBar(
          controller: controller,
        ),
        body: PageView(
          onPageChanged: (controller) => print(controller),
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: const <Widget>[
            LoginScreen(),
            HomeScreen(),
            MapScreen(),
          ],
        ),
      ),
    );
  }
}
