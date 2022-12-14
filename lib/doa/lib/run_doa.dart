//import 'package:eformplugin/doa/lib/src/views/home-page/tes.dart';

import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/PekerjaanController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/CabangController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/CreatePinController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/DataController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/DataFileController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/DataDiri2Controller.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/OtpController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/PemilikDanaController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/PhoneVerifyController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/RegistrasiNomorController.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/WorkDetailController.dart';
import 'package:eformplugin/doa/lib/src/utility/Routes.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_active_passive_liveness/flutter_active_passive_liveness.dart';
// import 'package:flutter_active_passive_liveness/gesture_type.dart';
// import 'package:flutter_active_passive_liveness/schema_type.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'BusinessLogic/Registrasi/AcknowledgementController.dart';
import 'BusinessLogic/Registrasi/AlamatController.dart';
import 'BusinessLogic/Registrasi/CreateMbankController.dart';

class DoaApp extends StatefulWidget {
  final String? route;
  DoaApp({Key? key, this.route}) : super(key: key);

  @override
  State<DoaApp> createState() => _DoaAppState();
}

class _DoaAppState extends State<DoaApp> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(DataController());
    Get.put(CabangController());
    Get.put(OtpController());
    Get.put(AcknowledgementController());
    Get.put(CreatePinController());
    Get.put(PhoneVerifyController());
    Get.put(CreateMbankController());
    Get.put(RegistrasiNomorController());
    Get.put(DataFileController());
    Get.put(PerkerjaanController());
    Get.put(PemilikDanaController());
    Get.put(WorkDetailController());
    Get.put(DataDiri2Controller());
    Get.put(AlamatController());
    initializeDateFormatting('id_ID', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          child = EasyLoading.init()(context, child);
          return MediaQuery(
            child: child,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        defaultTransition: Transition.leftToRight,
        title: 'Digital Opening Account',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: widget.route ?? "/splashScreen",
        getPages: Routes().listPage,
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Apakah Anda Yakin Akan Keluar dari Eform?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Ya'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Do you want to exit an App?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              //return true when click on "Yes"
              child: const Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}
