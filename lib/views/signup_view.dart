import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapplication/views/login_view.dart';
import 'package:mapplication/widgets/input_error_notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool _signUpPressed = false;
  bool _inputError = false;

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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    var url = Uri.parse(constants.REGISTER_URI);
    var response = await http.post(
      url,
      body: data
    );
    if(response.statusCode == 200) {
      _inputError = false;
      jsonData = jsonDecode(response.body);

      //CORRECT FUNCTION PLACE HERE

      setState(() {
        sharedPreferences.setString('token', jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const SignInScreen()), (route) => false);
      });
    } 
    else if(response.statusCode == 202) {
      _inputError = true;
      print('Response status: ${response.statusCode}');
    }
    else {
      _inputError = true;
      print('Response status: ${response.statusCode}');
      
      //REMOVE LATER FROM HERE, USED FOR TESTING TOKEN STORING AND RETRIEVAL. 
      /*
      setState(() {
        sharedPreferences.setString('token', 'testToken');
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()), (route) => false);
      });
      */
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
                    BuildFields(
                      controllerType: _emailController,
                      text:'Email', 
                      type: TextInputType.emailAddress, 
                      iconType: Icons.email
                    ),
                    const SizedBox(height: 10),
                    BuildFields(
                      controllerType: _usernameController,
                      text:'Username', 
                      type: TextInputType.text, 
                      iconType: Icons.account_circle
                    ),
                    const SizedBox(height: 10),
                    BuildFields(
                      controllerType: _pwController,
                      text:'Password', 
                      type: TextInputType.text,
                      iconType: Icons.lock
                    ),
                    const SizedBox(height: 10), //TO-DO: Add password confirmation function
                    BuildFields(
                      controllerType: _pwConfirmController,
                      text:'Confirm Password', 
                      type: TextInputType.text,  
                      iconType: Icons.lock,
                    ),
                    
                    _inputError
                    ?
                    const InputError(
                      typeOfError: "Test")
                    :
                    const SizedBox(height: 0),

                    const SizedBox(height: 50),
                    
                    _signUpPressed == true && _inputError != true
                    ?
                    const Text(
                      'Redirecting to Login',
                      style: TextStyle(
                        fontFamily: 'Mont',
                        color: Colors.black,
                        fontSize: 23,
                      ),
                    ) 
                    :
                    Container(
                      height: 50,
                      width: 125,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _signUpPressed = true;
                          });
                          signUp(_emailController.text, _usernameController.text, _pwController.text);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Mont',
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()), (route) => false);
                        });
                      },
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
