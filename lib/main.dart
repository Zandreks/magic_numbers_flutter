import 'package:MagicNumbers/other/ColorHexSet.dart';
import 'package:MagicNumbers/page/HomePage.dart';
import 'package:MagicNumbers/page/Result.dart';
import 'package:MagicNumbers/page/ResultHistory.dart';
import 'package:MagicNumbers/page/ResultVisaAdd.dart';
import 'package:MagicNumbers/page/VizaAddHistory.dart';
import 'package:MagicNumbers/page/VizaRezultNoAdd.dart';
import 'package:MagicNumbers/page/VizaRezultNoAddHistory.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ColorHexSet colorSet = ColorHexSet();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner:false,
      title: 'Magic numbers',
      theme: ThemeData(
        primaryColor: colorSet.colorFromHex("#FAFAFA"),
        fontFamily: 'SF Pro Display',
      ),
      initialRoute: '/',
      routes: {
        './': (context) => MyHomePage(),
        './result': (context) => ResultPage(),
        './resultVizaNoAdd': (context) => VisaRezultNoAdd(),
        './resultVisaAdd': (context) => ResultVisaAdd(),
        './resultHistory': (context) => ResultHistory(),
        './resultVizaNoAddHistory': (context) => VisaRezultNoAddHistory(),
        './resultVizaAddHistory': (context) => VizaAddHistory(),
      },
      home: MyHomePage(),
    );
  }
}
