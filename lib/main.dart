import 'package:flutter/material.dart';
import 'package:my_pass/pin_pad.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Pass',
      theme: new ThemeData(
        primaryColor: const Color(0xFF00b33c),
        primarySwatch: Colors.blue,
        splashFactory: InkRipple.splashFactory,
      ),
      home: PinPad(),
    );
  }
}
