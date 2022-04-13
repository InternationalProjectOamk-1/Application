import 'package:flutter/material.dart';

final BoxDecoration myOrangeCustom = BoxDecoration(
  color: Colors.orange[100],
  borderRadius: BorderRadius.circular(20.0),
);

final BoxDecoration myProfileCustom = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(100.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.orange,
      blurRadius: 1,
    ),
  ],
);
