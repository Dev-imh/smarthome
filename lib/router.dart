import 'package:flutter/cupertino.dart';
import 'package:smarthome/screens/authen.dart';
import 'package:smarthome/screens/home.dart';


final Map<String, WidgetBuilder> map = {

  '/authen' : (BuildContext context) => Authen(),
  '/homepage' : (BuildContext context) => MyHomePage(),
  
};