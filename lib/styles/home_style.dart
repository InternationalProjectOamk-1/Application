import 'package:flutter/material.dart';

final BoxDecoration myOrangeCustom = BoxDecoration(
    color: Colors.orange[100],
    borderRadius: BorderRadius.circular(20.0),
    boxShadow: const [myBoxShadow]);

final BoxDecoration myProfileCustom = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(100.0),
    boxShadow: const [myBoxShadow]);

const BoxShadow myBoxShadow = BoxShadow(
  color: Colors.orange,
  blurRadius: 1,
  offset: Offset(2, 2),
);
