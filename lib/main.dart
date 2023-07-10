import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CreateWeatherApp.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch:Colors.indigo),
      home: const CreateWeatherApp(),
    );
  }

}