import 'package:flutter/material.dart';

class Collector1 extends StatefulWidget {
  String email;

  Collector1({required this.email});

  @override
  _Collector1State createState() => _Collector1State();
}

class _Collector1State extends State<Collector1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collector"),
      ),
      body: Container(
        child: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}
