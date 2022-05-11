import 'package:flutter/material.dart';
import 'package:mapplication/models/user_details.dart';
import 'package:mapplication/views/chat_page.dart';
import 'package:mapplication/views/home_screen.dart';
import 'package:mapplication/views/login_view.dart';
import 'package:mapplication/views/map_view.dart';
import 'package:mapplication/widgets/bottom_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userToken = "";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, dynamic> data = await getTokenAndLogIn();
<<<<<<< HEAD
  UserData userData = await getUserDetails();
  print(userData.id);
  runApp(data['status'] == true ? const MyApp1() : const MyApp2());
=======

  //var status = prefs.getBool('isLoggedIn') ?? false;
  userToken = data['token'];
  runApp(data['status'] == true ? MyApp1() : MyApp2());
>>>>>>> master
}

Future<Map<String, dynamic>> getTokenAndLogIn() async {
  Map<String, dynamic> userData = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userData["status"] = prefs.getBool('isLoggedIn');
  userData["token"] = prefs.getString('token');
  return userData;
}

class MyApp1 extends StatelessWidget {
<<<<<<< HEAD
   const MyApp1({Key? key}) : super(key: key);
=======
  MyApp1({Key? key}) : super(key: key);
>>>>>>> master

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
<<<<<<< HEAD
    const MyApp2({Key? key}) : super(key: key);
=======
  MyApp2({Key? key}) : super(key: key);
>>>>>>> master

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
