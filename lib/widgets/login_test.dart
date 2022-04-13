/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/user_service_consts.dart ' as constants;

class Test extends StatefulWidget {
  const Test({ Key? key }) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  String name = 'Name Example';
  String email = 'example.email@example.com';
  String password = 'testpassword';

  
  TestHTTP(String name, String email, String password) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String,String> data = {
      'name': name,
      'email': email,
      'password': password
    };
    
    var uri = Uri.http(constants.BASE_PATH, constants.REGISTER);
    var response = await http.post(
      uri,
      body: data
    );
    
    switch (response.statusCode) {
      case 200 : {
        print('Response status: ${response.statusCode}');
      }
      break;

      case 202 : {
      print('Response status: ${response.statusCode}');
      }
      break;

      case 502 : {
      print('Response status: ${response.statusCode}');
      }
      break;

      case 500 : {
      print('Response status: ${response.statusCode}');
      }
      break;

      default : {
        print('Response status: ${response.statusCode}');
        var token = sharedPreferences.getString('token');

        if(token == null){
          print('empty');
        } else {
          print(token);
        };

      }
      break;
    }
    /*
    if(response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
    
    } 
    else if(response.statusCode == 202) {
      print('Response status: ${response.statusCode}');
      
    }
    else {
      print('Response status: ${response.statusCode}');
    }
    */
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff5ac18e),
                    Colors.white,
                  ]
                )
              ),
              child: TextButton(
                onPressed: () {
                  TestHTTP(name, email, password);
                },
                child: Text(
                  'Test HTTP'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/