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

  void forgor() {
  print("hello");
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
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 50),
                    buildFields(
                      text:'Email', 
                      type: TextInputType.emailAddress, 
                      hintText: 'Email', 
                      iconType: Icons.email,
                      obscure: false,
                    ),
                    const SizedBox(height: 10),
                    buildFields(
                      text:'Password', 
                      type: TextInputType.text, 
                      hintText: 'Password', 
                      iconType: Icons.lock,
                      obscure: true
                    ),
                    TextButton(
                      onPressed: forgor,    //TO-DO: Create proper forget password page
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15
                        )
                      )
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextButton(
                        onPressed: () => print('Login pressed'), //TO-DO: Create authentication and route user to next page
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    )
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
