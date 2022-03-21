import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class buildFields extends StatelessWidget {
  buildFields(
    {
    required this.text, required this.type,
    required this.hintText, required this.iconType,
    required this.obscure, required this.controllerType
    }
  );
final String text;
final TextInputType type;
final String hintText;
final IconData iconType;
final bool obscure;
final TextEditingController controllerType;

@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  <Widget>[
      Text(
        text,
        style: const TextStyle(
          fontFamily: 'Mont',
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
        child:  TextField(
          controller: controllerType,
          keyboardType: type,
          obscureText: obscure,
          style: const TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              iconType,
              color: Color(0xff5ac18e)
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.black38
            )
          ),
        ),
      )
    ],
  );
}
}