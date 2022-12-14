import 'package:flutter/material.dart';
import 'package:eformplugin/eformplugin.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _doaPlugin = Eformplugin();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async => await _doaPlugin.openDoa(context),
            child: const Text("Open Doa")),
      ),
    ));
  }
}
