import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/input_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwController1 = TextEditingController();
  TextEditingController pwController2 = TextEditingController();

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
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Mont',
                        color: Colors.white,
                        fontSize: 40,
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
                      controllerType: emailController,
                      text:'Username', 
                      type: TextInputType.text, 
                      hintText: 'Username', 
                      iconType: Icons.account_circle,
                      obscure: false,
                    ),
                    const SizedBox(height: 10),
                    buildFields(
                      controllerType: pwController1,
                      text:'Password', 
                      type: TextInputType.text, 
                      hintText: 'Password', 
                      iconType: Icons.lock,
                      obscure: true
                    ),
                    const SizedBox(height: 10), //TO-DO: Add password confirmation function
                    buildFields(
                      controllerType: pwController2,
                      text:'Confirm Password', 
                      type: TextInputType.text, 
                      hintText: 'Password', 
                      iconType: Icons.lock,
                      obscure: true
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
                        onPressed: () => print('email: ${emailController.text}\npassword: ${pwController1.text}'),
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
