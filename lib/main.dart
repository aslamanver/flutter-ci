import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter CI"),
      ),
      body: Center(
        child: Text("CI Test for Android Flutter"),
      ),
    );
  }
}
