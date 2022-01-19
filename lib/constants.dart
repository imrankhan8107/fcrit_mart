import 'package:flutter/material.dart';

const kScaffoldbackgroundcolor = Color(0xFF101010);

const kAppBarTheme = AppBarTheme(
  toolbarHeight: 75,
  titleTextStyle: kAppbartitle,
  color: Color(0xFF101010),
);

const kTextstyle = TextStyle(
  fontSize: 15,
  color: Color(0xFFA4A4A4),
);
const kAppbartitle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
);

const kBottomButtonStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kGradientcolor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  colors: [Color(0xFFB515DF), Color(0xFFD127A4)],
);
