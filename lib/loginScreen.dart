import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapplication/home_screen.dart';
import 'buildFields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff5ac18e),
                    Color(0xff5ac18e),
                    Color(0xff5ac18e),
                    Color(0xff5ac18e),
                    Color(0xff5ac18e),
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
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 50),
                    buildFields(
                      controllerType: emailController,
                      text:'Email', 
                      type: TextInputType.emailAddress, 
                      hintText: 'Email', 
                      iconType: Icons.email,
                      obscure: false,
                    ),
                    const SizedBox(height: 10),
                    buildFields(
                      controllerType: pwController,
                      text:'Password', 
                      type: TextInputType.text, 
                      hintText: 'Password', 
                      iconType: Icons.lock,
                      obscure: true
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
                        onPressed: () => print('email: ${emailController.text}\npassword: ${pwController.text}'),
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
                      onPressed: signUp,    //TO-DO: Create proper forget password page
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
