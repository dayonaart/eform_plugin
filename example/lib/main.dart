import 'package:flutter/material.dart';
import 'package:eformplugin/eformplugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _doaPlugin = Eformplugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                await _doaPlugin.openDoa();
              },
              child: const Text("Open Doa")),
        ),
      )),
    );
  }
}
