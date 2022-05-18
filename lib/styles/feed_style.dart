import 'package:flutter/material.dart';
import 'package:mapplication/consts/styling_consts.dart';

final BoxDecoration myOrangeCustom = BoxDecoration(
  color: appDefaultColor,
  borderRadius: BorderRadius.circular(20.0),
  boxShadow: const [myBoxShadow],
);

final BoxDecoration myProfileCustom = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(100.0),
  boxShadow: const [myBoxShadow],
);

final BoxDecoration myCreateEventCustom = BoxDecoration(
  color: Colors.orange[50],
  borderRadius: BorderRadius.circular(100),
  boxShadow: const [myBoxShadow],
);

const BoxShadow myBoxShadow = BoxShadow(
  color: appDefaultPrimaryVariant,
  blurRadius: 2,
  offset: Offset(2, 2),
);
