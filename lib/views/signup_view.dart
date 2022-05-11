import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapplication/views/login_view.dart';
import 'package:mapplication/widgets/input_error_notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/input_field_widget.dart';
import '../consts/service_consts.dart ' as constants;


/*
TO-DO: 
- Implement errors for different HTTP codes.
- Widgets for showing errors below fields
- Remove print functions when done.
*/

class SignInScreen extends StatefulWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _pwConfirmController = TextEditingController();

  bool _signUpPressed = false;
  bool _inputError = false;
  int _statusCode = 2;
  var jsonData = null;

  void forgor() {
    print("Forgot password pressed");
  }

  void register(String username, String email, String password, String profileImg) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, String> data = {
      'username': username,
      'email': email,
      'password': password,
      'profileImg': 'https://i.redd.it/86rcqld6lxn81.jpg'
    };

    try{
      
    http.Response response = await http.post(
        
      Uri.http(constants.BASE_PATH, constants.REGISTER),
      
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(data)
      
    );

      if(response.statusCode == 200){
        print('SignUp successfully');
        
        sharedPreferences.setString('jwt', response.body);
        sharedPreferences.setString('username', username);
      
      }else {
        print(jsonEncode(data).replaceAll(",", ",\n"));
        print('Returned with HTTP status: ${response.statusCode}');
        String responseApi = response.body.toString().replaceAll("\n","");
        if(responseApi.isNotEmpty){
          print(responseApi);
        } else {
          print('body returned empty');
        }
        
      }
    }catch(e){
      print(e.toString());
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
                  ],
                ),
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
                      controllerType: _usernameController,
                      text:'Username', 
                      type: TextInputType.text, 
                      iconType: Icons.account_circle
                    ),
                    const SizedBox(height: 10),
                    BuildFields(
                      controllerType: _emailController,
                      text:'Email', 
                      type: TextInputType.emailAddress, 
                      iconType: Icons.email
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
                    const SizedBox(height: 8),

                    _inputError
                    ?
                    InputError(
                      typeOfError: jsonData,
                      errorType: _statusCode,
                    )
                    :
                    const SizedBox(height: 0),

                    const SizedBox(height: 50),
                      
                    _signUpPressed == true && _inputError != false
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
                          register(_usernameController.text, _emailController.text, _pwController.text, 'https://i.redd.it/86rcqld6lxn81.jpg');
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
                          Navigator.of(context).pop(MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
                        });
                      },
                    ),
                  ],
                ),
              ),  
            ),
          ],
        ),
      ),
    );
  }
}
