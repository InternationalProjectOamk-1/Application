import 'package:flutter/material.dart';
import 'package:mapplication/views/chat_page.dart';
import 'package:mapplication/views/home_screen.dart';
import 'package:mapplication/views/login_view.dart';
import 'package:mapplication/views/map_view.dart';
import 'package:mapplication/widgets/bottom_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  runApp(status == true ? MyApp1() : MyApp2());
}

class MyApp1 extends StatelessWidget {
   MyApp1({Key? key}) : super(key: key);

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
        bottomNavigationBar: 
        BottomBar(
          controller: controller,
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text(
              'Tap again to exit',
              ),
          ),
          child: PageView(
            onPageChanged: (controller) => print(controller),
            controller: controller,
            scrollDirection: Axis.horizontal,
            children: const <Widget>[
              ChatPage(),
              HomeScreen(),
              MapScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
   MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text(
              'Tap again to exit',
            ),
          ),
          child: LoginScreen(),
        ),
      ),
    );
  }
}

