import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, required this.big, required this.size})
      : super(key: key);
  final bool big;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (big == true) {
      return Scaffold(
          body: SafeArea(
              child: Center(
                  child: SpinKitCircle(
                      size: size,
                      color: const Color.fromRGBO(239, 108, 0, 1)))));
    } else {
      if (size > 50) {
        return SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(height: 200),
              SpinKitCircle(
                  size: size, color: const Color.fromRGBO(239, 108, 0, 1)),
            ]));
      } else {
        return SafeArea(
            child: Column(children: [
          const SizedBox(height: 40),
          Center(
              child: SpinKitCircle(
                  size: size, color: const Color.fromRGBO(239, 108, 0, 1)))
        ]));
      }
    }
  }
}
