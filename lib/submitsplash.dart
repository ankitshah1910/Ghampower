
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:page_transition/page_transition.dart';

import 'Authentication.dart';
import 'Mapping.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  final String submittype;

  @override
  SplashScreen({this.submittype});

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTime() async{
    var _duration=new Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>MappingPage(auth: Auth(),)));
  }

  @override
  void initState(){
    super.initState();
    startTime();
  }

  final background=Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/back.png'),
        fit: BoxFit.cover,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit:StackFit.expand,
        children: <Widget>[
          background,
          SafeArea( child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                'assets/check.png',
                  height: 250,
                  width: 320,
                ),
                widget.submittype=="Online"?Text('Uploaded data Online', style: TextStyle(color: Colors.grey, height: 5.0,fontSize: 30),)
                    :Text('Stored data Offline', style: TextStyle(color: Colors.grey, height: 5.0,fontSize: 30),)
            ],
          ),
          ),
        ],
      ),

    );
  }
}