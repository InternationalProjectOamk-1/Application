import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapplication/widgets/input_error_notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mapplication/views/signup_view.dart';
import '../widgets/input_field_widget.dart';
import '../consts/user_service_consts.dart ' as constants;

/*
TO-DO: 
- Implement errors for different HTTP codes.
- Widgets for showing errors below fields
- Remove print functions when done.
*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  
  bool _inputError = false;
  int _statusCode = 0;
  var jsonData = null;

  //FIGURE OUT WHY THE LOGIN METHOD IS GET?
  void login(email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, String> data = {'email': email, 'password': password};

    try {
      http.Response response = await http.get(
          Uri.http(constants.BASE_PATH, constants.LOGIN, data),
          headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        print('Returned with HTTP status: ${response.statusCode}');
        String responseApi = response.body.toString().replaceAll("\n", "");
        jsonData = responseApi;

        setState(() {
          sharedPreferences.setString('token', jsonData);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const SignInScreen()),
              (route) => false);
        });
      } else {
        print('Returned with HTTP status: ${response.statusCode}');
        _inputError = true;
        _statusCode = response.statusCode;
        String responseApi = response.body.toString().replaceAll("\n", "");

        if (responseApi.isNotEmpty) {
          jsonData = responseApi;
        } else {
          print('No content to show');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void forgor() {
    print("Forgot password pressed");
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
                  ])),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Log In',
                      style: TextStyle(
                        fontFamily: 'Mont',
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 50),
                    BuildFields(
                        controllerType: _emailController,
                        text: 'Email',
                        type: TextInputType.emailAddress,
                        iconType: Icons.email),
                    const SizedBox(height: 8),
                    BuildFields(
                        controllerType: _pwController,
                        text: 'Password',
                        type: TextInputType.text,
                        iconType: Icons.lock),
                    const SizedBox(height: 8),
                    _inputError
                        ? InputError(
                            typeOfError: jsonData.toString(),
                            errorType: _statusCode,
                          )
                        : const SizedBox(height: 0),
                    TextButton(
                        onPressed: forgor,
                        //TO-DO: Create proper forget password page
                        child: const Text('Forgot Password ?',
                            style: TextStyle(
                                fontFamily: 'Mont',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16))),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                          });
                          login(_emailController.text, _pwController.text);
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
                    const Text('Don\'t have an account?',
                        style: TextStyle(
                            fontFamily: 'Mont',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
                        }, //TO-DO: Create proper forget password page
                        child: const Text('Sign Up Here',
                            style: TextStyle(
                                fontFamily: 'Mont',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 16))),
                    /*TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Test()),
                        );
                      },
                      child: const Text(
                        'TEST HTTP',
                      ),
                    ),
                    */
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
