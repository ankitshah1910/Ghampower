import 'package:flutter/material.dart';
import 'Mapping.dart';
import 'dart:async';
import 'Authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: "MyApp",
      theme: new ThemeData(
        
        primaryColor: Color.fromRGBO(240, 151, 38, 1),
        primaryColorLight: Color.fromRGBO(111, 196, 242, 1),

      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: <String, WidgetBuilder>{
        'loginandreg.dart':(BuildContext context)=>MappingPage(),
      },
        home: MappingPage(auth: Auth(),),
    );
  }
}
