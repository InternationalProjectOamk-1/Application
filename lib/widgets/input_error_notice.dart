import 'package:flutter/material.dart';


class InputError extends StatelessWidget {

  final String typeOfError;
  final int errorType;
  
  const InputError(
    {
      required this.typeOfError, required this.errorType
    }
  );

  @override
  Widget build(BuildContext context) {
    return  Text(
      typeOfError.replaceAll("\"", ""),
      style: const TextStyle(
        color: Colors.red,
      ),
    );
  }
}