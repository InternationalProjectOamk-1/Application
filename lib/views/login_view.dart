import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:mapplication/views/signup_view.dart';
import '../widgets/input_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  bool _isLoading = false;


  //FIGURE OUT WHY THE LOGIN METHOD IS GET?

  signIn(String email, String password) async {
    Map data = {
      'email': email,
      'password': password
    };
    var jsonData = null;
    var url = Uri.parse('https://eeventify.github.io/Login');
    var response = await http.post(
      url,
      body: data
    );
    if(response.statusCode == 200) {
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  void forgor() {
  print("Forgot password pressed");
  }

  void signUp() {
  print("Sign Up pressed");
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
                      'Log In',
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
                      controllerType: _pwController,
                      text:'Password', 
                      type: TextInputType.text, 
                      iconType: Icons.lock
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: forgor,    //TO-DO: Create proper forget password page
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontFamily: 'Mont',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: 18
                        )
                      )
                    ),
                    const SizedBox(height: 10),
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
                          signIn(_emailController.text, _pwController.text);
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontFamily: 'Mont',
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontFamily: 'Mont',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18
                        )
                      ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInScreen()),
                        );
                      },   //TO-DO: Create proper forget password page
                      child: const Text(
                        'Sign Up Now',
                        style: TextStyle(
                          fontFamily: 'Mont',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 22
                        )
                      )
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
