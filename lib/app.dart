import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:my_pass/app_database.dart';

class App extends InheritedWidget {
  App({
    @required Widget child,
  })  : db = AppDatabase(),
        super(child: child);

  final AppDatabase db;

  static App of(BuildContext context) {
    App appConfig = context.inheritFromWidgetOfExactType(App);
    assert(appConfig != null);
    return appConfig;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
