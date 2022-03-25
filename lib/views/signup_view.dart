import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../widgets/input_field_widget.dart';
import '../consts/user_service_consts.dart ' as constants;


class SignInScreen extends StatefulWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _pwConfirmController = TextEditingController();

  bool _isLoading = false;

  void forgor() {
  print("Forgot password pressed");
  }

   //FIGURE OUT WHY THE SIGN IN METHOD IS GET?

  signUp(String email, String username, String password) async {
    Map data = {
      'email': email,
      'username': username,
      'password': password
    };
    var jsonData = null;
    var url = Uri.parse(constants.REGISTER_URI);
    var response = await http.post(
      url,
      body: data
    );
    if(response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  <Widget>[
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Mont',
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 50),
                    buildFields(
                      controllerType: _emailController,
                      text:'Email', 
                      type: TextInputType.emailAddress, 
                      iconType: Icons.email
                    ),
                    const SizedBox(height: 10),
                    buildFields(
                      controllerType: _usernameController,
                      text:'Username', 
                      type: TextInputType.text, 
                      iconType: Icons.account_circle
                    ),
                    const SizedBox(height: 10),
                    buildFields(
                      controllerType: _pwController,
                      text:'Password', 
                      type: TextInputType.text,
                      iconType: Icons.lock
                    ),
                    const SizedBox(height: 10), //TO-DO: Add password confirmation function
                    buildFields(
                      controllerType: _pwConfirmController,
                      text:'Confirm Password', 
                      type: TextInputType.text,  
                      iconType: Icons.lock,
                    ),
                    const SizedBox(height: 50),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          signUp(_emailController.text, _usernameController.text, _pwController.text);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Mont',
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),  
            )
          ],
        ),
      ),
    );
  }
}
