import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, required this.big}) : super(key: key);
  final bool big;

  @override
  Widget build(BuildContext context) {
    if (big == true) {
      return const Scaffold(
          body: SafeArea(
              child: Center(
                  child: SpinKitCircle(
                      size: 100, color: Color.fromRGBO(239, 108, 0, 1)))));
    } else {
      return SafeArea(
          child: Column(children: const [
        SizedBox(height: 40),
        Center(
            child:
                SpinKitCircle(size: 40, color: Color.fromRGBO(239, 108, 0, 1)))
      ]));
    }
  }
}
