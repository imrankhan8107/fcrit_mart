import 'package:flutter/material.dart';
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children:[
         padding:(
        padding: const EdgeInsect.all(25.0)
        Center(
        child:CircleAvatar(
          backgroundImage:AssetImage(),
          radius:50.0
        )
        )
    )
          padding:(
          padding: const EdgeInsect.all(25.0)
    child:Center(
    floatingActionButton:FloatingActionButton(
    onPressed: () {},
    child:Text('LOGIN'),
    colors: [Color(0xFFB515DF), Color(0xFFD127A4)]),
    )
    )
    padding:(
    padding: const EdgeInsect.all(12.0)
    child:Center(
    floatingActionButton:FloatingActionButton(
    onPressed: () {},
    child:Text('SIGN UP'),
    colors: [Color(0xFFB515DF), Color(0xFFD127A4)]),
    )
    )
    )
    )
    ]
      )

    );
  }
}
