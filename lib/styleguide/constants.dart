import 'package:flutter/material.dart';

//const Color primaryColor =  Color(0xFF6ab04c);
//const Color secondaryColor = Color(0xFFd2a01f);
final kHintTextStyle = TextStyle(
  color: Color(0xFF6ab04c),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),

    ),
  ],

);
final kBoxDecorationStyleSecond = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  /*boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),

    ),
  ],*/

);