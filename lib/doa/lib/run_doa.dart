//import 'package:eformplugin/doa/lib/src/views/home-page/tes.dart';
import 'dart:convert';
import 'dart:math';

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
import 'package:eformplugin/doa/lib/service/services.dart';
import 'package:eformplugin/doa/lib/src/components/testing.dart';
import 'package:eformplugin/doa/lib/src/components/url-api.dart';
import 'package:eformplugin/doa/lib/src/utility/Routes.dart';
import 'package:eformplugin/doa/lib/src/views/data-file/data-file-list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_active_passive_liveness/flutter_active_passive_liveness.dart';
// import 'package:flutter_active_passive_liveness/gesture_type.dart';
// import 'package:flutter_active_passive_liveness/schema_type.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/DataController.dart';

import 'BusinessLogic/Registrasi/AcknowledgementController.dart';
import 'BusinessLogic/Registrasi/AlamatController.dart';
import 'BusinessLogic/Registrasi/CreateMbankController.dart';

Future<void> runDoa({String? route}) async {
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
  await initializeDateFormatting('id_ID', null);
  runApp(MyApp(
    route: route,
  ));
}

class MyApp extends StatefulWidget {
  final String? route;
  MyApp({Key? key, this.route}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetMaterialApp(
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
          // home: DataFileListPage(),
          initialRoute: widget.route ?? "/splashScreen",
          getPages: Routes().listPage,
        ),
        onWillPop: () {
          return Future.value(true);
        });
  }
}

// {channel: EFORM, idNum: 1234567891234567, idType: 0001, status: FAILED, errorCode: 9025, errorMessage: (SOA) CIF SUDAH MEMILIKI REKENING AKTIF ATAU DORMAN}, expired: null, header: {status: true, message: Success, refNumber: 07062022070716826370, timestamp: },
class TestPage extends StatelessWidget {
  var prefs = Get.find<DataController>();
  Future<Map<String, dynamic>> get _bodySavePhotoSelfie async {
    // var device = await getDeviceProperties();
    return {
      'type': 'liveness',
      'nik': '1234567891234567',
      'originalSize': prefs.prefs.getString('originalSelfiePhotoSize'),
      'convertSize': prefs.prefs.getString('compressedSelfiePhotoSize'),
      // "userAppVersion_code": device?.versionCode,
      // "userAppVersion_name": device?.versionName,
      // "device_type": device?.deviceType,
      // "osVersion": device?.osVersion,
      // "ip_address": device?.ipAddress,
      "refNumber": prefs.prefs.getString("refNumber"),
      "scoreLiveness": prefs.prefs.getString('scoreLiveness'),
      'photo': _photo,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              // print(jsonEncode(await _bodySavePhotoSelfie));
              // print(jsonEncode(await _bodySavePhotoSelfie));
              // print(prefs.headerJson(step: "save photo"));
              // var body = await _bodySavePhotoSelfie;
              // var _resSelfie = await Services().POST(urlSavePhoto, 'Api Save Photo', body: body);
              print(prefs.generateMd5("86264304478370601062022101529"));
              // print(prefs.prefs.getString("refNumber"));
            },
            child: Text("data")),
      ),
    );
  }
}

var _photo =
    "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";
