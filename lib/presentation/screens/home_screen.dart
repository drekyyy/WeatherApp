import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Flexible(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(Icons.sunny, size: 200, color: Colors.yellow))),
            Flexible(fit: FlexFit.tight, flex: 3, child: Container(height: 10)),
            const Flexible(
                flex: 3,
                child: Text(
                  'Put your city',
                )),
          ],
        ),
      ),
    );
  }
}
