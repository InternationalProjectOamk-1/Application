import 'package:flutter/material.dart';


class InputError extends StatelessWidget {
  const InputError(
    {
      required this.typeOfError,
    }
  );

  final String typeOfError;

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Incorrect input",
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }
}