import 'package:flutter/material.dart';

import 'package:my_pass/ui/pin_pad.dart';
import 'package:my_pass/app.dart';
import 'package:my_pass/ui/home.dart';
import 'package:my_pass/ui/add_pass.dart';

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
        primaryColor: Color(0xFF006622),
        accentColor: Color(0xFF00cc44),
        primarySwatch: Colors.blue,
        splashFactory: InkRipple.splashFactory,
      ),
      home: HomePage(),
      routes: {
        '/pin_pad': (context) => PinPad(),
        '/sign_up_pin': (context) => PinPad(true),
        '/add_pass': (context) => AddPass()
      },
    );
  }
}
