import 'package:app/api/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;
  bool isIos = Platform.isIOS ? true :false;


  login(username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var a = prefs.get('token');
    print('---');
    print(a);

    await HttpRequest.request('/login',
            params: {"username": username, "password": password})
        .then((res) async => {
              if (res['code'] == 0)
                {await prefs.setString('token', res['token'])}
              else
                {
                  if(isIos){
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                              title: Text('错误'),
                              content: Text(res['message']),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('确定'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]);
                        })
                  }else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text('错误'),
                              content: Text(res['message']),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('确定'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]);
                        })
                  }
                }
            })
        .catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Container(
            child: Column(
      children: [
        Container(
          height: _width * 0.55 + 65,
          child: Stack(
            children: [
              Container(
                width: _width,
                height: _width * 0.55,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/images/login_bg.png'))),
              ),
              Positioned(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(130),
                  child: Image.network(
                    'https://shijianmin.cn/wp-content/uploads/2020/08/logo.jpeg',
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                top: _width * 0.55 - 65,
                left: _width / 2 - 65,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          width: _width * 0.8,
          child: TextField(
            decoration: InputDecoration(
              labelText: '用户名',
              contentPadding: EdgeInsets.all(20.0),
              focusedBorder: OutlineInputBorder(
                //选中时外边框颜色
                borderRadius: BorderRadius.circular(100.0),
                borderSide: BorderSide(color: Color(0xff9e51ff), width: 3.0),
              ),
              enabledBorder: OutlineInputBorder(
                //未选中时候的颜色
                borderRadius: BorderRadius.circular(100.0),
                borderSide: BorderSide(color: Color(0xff9e51ff), width: 1.0),
              ),
            ),
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          width: _width * 0.8,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '密码',
              contentPadding:
                  EdgeInsets.only(left: 30, top: 20, right: 20, bottom: 20),
              focusedBorder: OutlineInputBorder(
                //选中时外边框颜色
                borderRadius: BorderRadius.circular(100.0),
                borderSide: BorderSide(color: Color(0xff9e51ff), width: 3.0),
              ),
              enabledBorder: OutlineInputBorder(
                //未选中时候的颜色
                borderRadius: BorderRadius.circular(100.0),
                borderSide: BorderSide(color: Color(0xff9e51ff), width: 1.0),
              ),
            ),
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50.0),
          width: _width * 0.8,
          height: 50,
          child: RaisedButton(
            onPressed: username != null && password != null
                ? () {
                    login(username, password);
                  }
                : null,
            color: Colors.red,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Text('登录',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {},

                  // color: Colors.transparent,
                  child: Text('注册',
                      style: TextStyle(
                        fontSize: 15.0,
                      ))),
              TextButton(
                  onPressed: () {},
                  // color: Colors.transparent,
                  child: Text('忘记密码？',
                      style: TextStyle(
                        fontSize: 15.0,
                      ))),
            ],
          ),
        )
      ],
    )));
  }
}
