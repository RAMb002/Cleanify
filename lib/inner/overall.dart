import 'package:flutter/material.dart';
import 'package:sortapp/drawer/menu.dart';
import 'package:sortapp/over/pie1.dart';
import 'package:sortapp/over/pie.dart';

class Overall extends StatefulWidget {
  String email;
  Overall({required this.email});
  @override
  _OverallState createState() => _OverallState();
}

class _OverallState extends State<Overall> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MenuBar(email: widget.email, c1: Colors.blueAccent),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              'ANALYTICS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Container(
                height: 30,
                child: Tab(
                  child: Text(
                    "OVERALL",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                child: Tab(
                  child: Text(
                    "DAILY",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Pie(email: widget.email),
          Pie1(email: widget.email),
        ]),
      ),
    );
  }
}
