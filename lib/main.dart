import 'package:flutter/material.dart';

import 'package:my_pass/ui/pin_pad.dart';
import 'package:my_pass/app.dart';

void main() {
  App app = App(
    child: MyApp(),
  );
  app.db.init().then((v) => runApp(app));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pass',
      theme: ThemeData(
        primaryColor: const Color(0xFF00b33c),
        primarySwatch: Colors.blue,
        splashFactory: InkRipple.splashFactory,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: PinPad(
        isSignUp: true,
      ),
    );
  }
}
