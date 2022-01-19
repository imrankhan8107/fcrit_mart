import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(),
        title: Text('FCRIT MART'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                child: Text('home'),
              )),
              Expanded(
                  child: Container(
                child: Text('home2'),
              )),
            ],
          )
        ],
      ),
    );
  }
}
