import 'package:eformplugin/doa/lib/run_doa.dart';
import 'package:flutter/material.dart';

class Eformplugin {
  Future<void> openDoa(
    BuildContext? context, {
    String? route,
  }) async {
    assert(context != null);
    await showDialog(
        context: context!,
        builder: (context) {
          return DoaApp(route: route);
        });
  }
}
