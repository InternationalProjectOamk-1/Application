import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'buildFields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Widget buildEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  <Widget>[
      const Text(
        'Email',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
      ),
      const SizedBox(
        height: 10
      ),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: const TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xff5ac18e)
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          ),
        ),
      )
    ],
  );
}

class _LoginScreenState extends State<LoginScreen> {
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