import 'package:flutter/material.dart';

class BuildFields extends StatelessWidget {

  final String text;
  final TextInputType type;
  final IconData iconType;
  final TextEditingController controllerType;
    
  const BuildFields(
    {
      required this.text, required this.type,
      required this.iconType, required this.controllerType
    }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0,2)
              )
            ]
          ),
          height: 45,
          child:  TextField(
            controller: controllerType,
            keyboardType: type,
            obscureText: text.contains('Password') ? true : false,
            style: const TextStyle(
              color: Colors.black87
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 12),
              prefixIcon: Icon(
                iconType,
                color: const Color(0xff5ac18e)
              ),
              hintText: text,
              hintStyle: const TextStyle(
                color: Colors.black38
              )
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
}
}