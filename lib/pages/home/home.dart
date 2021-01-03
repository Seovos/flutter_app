import 'package:app/store/index.dart';
import 'package:app/store/state/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:app/store/actionTypes/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(

            children: [
              SizedBox(height: 100),
              RaisedButton(onPressed: () {
                store.dispatch(myType.Increase);
              }, child: Text('+')),
              StoreConnector<IState,int>(builder: (BuildContext context,int counter){
                return Text('$counter');
              }, converter: (Store<IState> store){

                return store.state.count.count;
              })
            ],
          ),
        ),
      ),
    );
  }
}
