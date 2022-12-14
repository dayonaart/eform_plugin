import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/AcknowledgementController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/CreatePinController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Coba'),
        onPressed: () {
          Get.find<CreatePinController>().testEmail();
        },
      ),
    );
  }
}
