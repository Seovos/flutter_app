import 'package:app/store/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(store: store, child:

      MaterialApp(
        // set your initial route
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        navigatorKey: Modular.navigatorKey,
        // add Modular to manage the routing system
        onGenerateRoute: Modular.generateRoute,
      )
    );


  }
}