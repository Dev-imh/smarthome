import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CuisineScreen extends StatefulWidget {
  @override
  _CuisineScreenState createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Cuisine'),
    );
  }
}