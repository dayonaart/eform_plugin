import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:eformplugin/doa/lib/BusinessLogic/Registrasi/DataFileController.dart';
import 'package:eformplugin/doa/lib/service/services.dart';
import 'package:eformplugin/doa/lib/src/components/button.dart';
import 'package:eformplugin/doa/lib/src/components/label-text.dart';
import 'package:eformplugin/doa/lib/src/components/list-error.dart';
import 'package:eformplugin/doa/lib/src/components/popup.dart';
import 'package:eformplugin/doa/lib/src/components/theme_const.dart';
import 'package:eformplugin/doa/lib/src/components/url-api.dart';
import 'package:eformplugin/doa/lib/src/utility/custom_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as GET;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:isolate_image_compress/isolate_image_compress.dart';

import 'package:path_provider/path_provider.dart';
import 'package:zolozkit_for_flutter/zolozkit_for_flutter.dart';

import 'alert-dialog-new-wrap.dart';

final DataFileController c = GET.Get.put(DataFileController());

String URL = "http://192.168.1.6:9114/";
// String URL = "http://192.168.65.151:9114/";
String FACE_INIT = "liveness_detection/zoloz/initialize";

String FACE_RESULT = "liveness_detection/zoloz/checkresult";
ZolozMicroServicesResponse zolozMicroServicesResponse =
    ZolozMicroServicesResponse();
Checkfaceresult checkfaceresult = Checkfaceresult();
Future<void> ZOLOZ_SDK_RESULT(dynamic cobafaceinit,
    {@required FaceInitPayload? faceInitPayload,
    bool isOnlyLiveness = false}) async {
  CustomLoading().showLoading('Memuat Data');
  // var _initFace = await initFace(jsonEncode(faceInitPayload?.toJson()));
  await Future.delayed(Duration(seconds: 3));
  print('ini adalah ${jsonEncode(faceInitPayload?.toJson())}');
  var _initFace = await initialisizeFace(cobafaceinit);
  print('ini adalah initface : ${zolozMicroServicesResponse.bizId}');
  //print('ini adalah initface : ${_initface.fromJson()}')
  //body yang _initface diganti dengan zolozMicroServicesResponse
  // await zolozSdk(zolozMicroServicesResponse, zolozMicroServicesResponse.bizId,
  //     zolozMicroServicesResponse.refNum as, isOnlyLiveness);

  await zolozSdk(
      zolozMicroServicesResponse,
      zolozMicroServicesResponse.bizId!,
      faceInitPayload!.nik!,
      zolozMicroServicesResponse.refNum!,
      isOnlyLiveness);
  CustomLoading().dismissLoading();
}

Future<ZolozMicroServicesResponse> initFace(String? payload) async {
  var response = await Dio().post(URL + FACE_INIT, data: payload);
  return ZolozMicroServicesResponse.fromJson(response.data);
}

Future<void> initialisizeFace(dynamic payload) async {
  try {
    // var response = await Dio().post(URL + FACE_INIT, data: payload);
    var response = await Services()
        .POST(urlInitializeZoloz, 'Face Intialize Zoloz', body: payload);
    // response diganti dengan await Service.post
    // Services().POST(endpoint, step, body: body);
    //body nya ikutin aja  samain
    zolozMicroServicesResponse =
        ZolozMicroServicesResponse.fromJson(response?.data?.body);
  } catch (e) {
    ERROR_DIALOG();
  }
}

get _bodyCheckResult async {
  final devicePropertiesPlugin = DeviceInfo();
  var device = await devicePropertiesPlugin.getDeviceInfo();
  return {
    'nik': GET.Get.find<DataFileController>().prefs.getString('nik'),
    'channel': 'EFORM-MOBILE',
    "refNum": zolozMicroServicesResponse.refNum,
    "bizId": zolozMicroServicesResponse.bizId,
    "transactionId": zolozMicroServicesResponse.transactionId,
    "userAppVersion_code": device?.appVersionCode,
    "userAppVersion_name": device?.buildVersionCode,
    "device_type": device?.deviceType,
    "osVersion": device?.osVersion,
    "ip_address": device?.ipAddress,
  };
}

get _bodySavefoto async {
  final devicePropertiesPlugin = DeviceInfo();
  var device = await devicePropertiesPlugin.getDeviceInfo();
  return {
    'type': 'liveness',
    'nik': GET.Get.find<DataFileController>().prefs.getString('nik'),
    "userAppVersion_code": device?.appVersionCode,
    "userAppVersion_name": device?.buildVersionCode,
    "device_type": device?.deviceType,
    "osVersion": device?.osVersion,
    "ip_address": device?.ipAddress,
    // "refNumber": prefs.getString("refNumber"),
    // "scoreLiveness": prefs.getString('scoreLiveness'),
    'photo': GET.Get.find<DataFileController>().prefs.getString('selfiePhoto'),
  };
}

Future<void> zolozSdk(ZolozMicroServicesResponse _initFaceRes, String bizId,
    String nik, String refNum, bool isOnlyLiveness) async {
  var _chameleonKey = await ZolozkitForFlutter.zolozChameleonConfigPath;
  var _localeKey = await ZolozkitForFlutter.zolozLocale;
  // await Future.delayed(Duration(seconds: 20));

  CustomLoading().dismissLoading();

  await ZolozkitForFlutter.start(_initFaceRes.clientCfg!,
      {_localeKey: "in-ID", _chameleonKey: (await zolozCfg())}, (val) async {
    if (val) {
      print('Ini adalah transaction  id : ${_initFaceRes.transactionId}');
      CustomLoading().showLoading('Memuat Data');

      // var _resutlFacePayload = ResultFacePayload(
      //     nik: nik,
      //     channel: 'EFORM-MOBILE',
      //     refNum: refNum,
      //     bizId: bizId,
      //     transactionId: _initFaceRes.transactionId);

      // print(
      //     'Ini result face payload : ${jsonEncode(_resutlFacePayload.toJson())}');
      // var _res = await checkResult(jsonEncode(_resutlFacePayload.toJson()));
      await checkResultNew(await _bodyCheckResult);

      var unt = base64Decode(checkfaceresult.imageContent!);
      await ImageGallerySaver.saveImage(unt);

      await GET.Get.find<DataFileController>()
          .prefs
          .setString('selfiePhoto', checkfaceresult.imageContent!);
      if (checkfaceresult.errorCode == '') {
        await Future.delayed(Duration(seconds: 3));
        var _resSaveFoto = await Services()
            .POST(urlSavePhoto, 'Api Save Photo', body: await _bodySavefoto);
        print('ini adalah res save foto : ${_resSaveFoto}');
        if (!isOnlyLiveness) {
          CustomLoading().dismissLoading();

          GET.Get.find<DataFileController>().goSelfieKTPCamera();
        } else {
          CustomLoading().dismissLoading();

          GET.Get.find<DataFileController>().checkFileDone();
        }
      } else if (checkfaceresult.errorCode == '9014') {
        await Future.delayed(Duration(seconds: 3));
        var _resSaveFoto = await Services()
            .POST(urlSavePhoto, 'Api Save Photo', body: await _bodySavefoto);
        CustomLoading().dismissLoading();
        GET.Get.dialog(PopUp(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: const BoxDecoration(
                    color: CustomThemeWidget.orangeButton,
                    shape: BoxShape.circle),
                child: Center(
                  child: Image.asset('assets/images/tanda_seru.png',
                      color: Colors.white, package: "eformplugin"),
                ),
              ),
              GET.Get.find<DataFileController>().seperator(0.025),
              Text(
                'Mohon Maaf',
                style: blackRoboto.copyWith(fontSize: 18),
              ),
              GET.Get.find<DataFileController>().seperator(0.025),
              Text(
                'Validasi foto selfie belum berhasil. Mohon ulangi kembali proses foto selfie dan pastikan wajah anda berada pada area yang ditentukan dan pencahayaannya cukup.\n Sisa Percobaan : ${checkfaceresult.availableLiveness}',
                textAlign: TextAlign.center,
              ),
              GET.Get.find<DataFileController>().seperator(0.05),
              ButtonCostum(
                width: GET.Get.size.width - 120,
                ontap: () {
                  GET.Get.back();
                },
                text: 'OK, Saya Mengerti',
              )
            ],
          ),
        ));
      }
      // else if (_res?.errorCode == '9002') {
      //   CustomLoading().dismissLoading();
      //   GET.Get.dialog(PopUp(
      //     content: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Container(
      //           width: 40,
      //           height: 40,
      //           margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      //           decoration: const BoxDecoration(
      //               color: CustomThemeWidget.orangeButton,
      //               shape: BoxShape.circle),
      //           child: Center(
      //             child: Image.asset(
      //               'assets/images/tanda_seru.png',
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //         GET.Get.find<DataFileController>().seperator(0.025),
      //         Text(
      //           'Mohon Maaf',
      //           style: blackRoboto.copyWith(fontSize: 18),
      //         ),
      //         GET.Get.find<DataFileController>().seperator(0.025),
      //         Text(
      //           'PROCESS FAILED, DATABASE PROBLEM',
      //           textAlign: TextAlign.center,
      //         ),
      //         GET.Get.find<DataFileController>().seperator(0.05),
      //         ButtonCostum(
      //           width: GET.Get.size.width - 120,
      //           ontap: () {
      //             GET.Get.back();
      //           },
      //           text: 'OK, Saya Mengerti',
      //         )
      //       ],
      //     ),
      //   ));
      // } else if (_res?.errorCode == '9018') {
      //   CustomLoading().dismissLoading();
      //   GET.Get.dialog(PopUp(
      //     content: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Container(
      //           width: 40,
      //           height: 40,
      //           margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      //           decoration: const BoxDecoration(
      //               color: CustomThemeWidget.orangeButton,
      //               shape: BoxShape.circle),
      //           child: Center(
      //             child: Image.asset(
      //               'assets/images/tanda_seru.png',
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //         GET.Get.find<DataFileController>().seperator(0.025),
      //         Text(
      //           'Mohon Maaf',
      //           style: blackRoboto.copyWith(fontSize: 18),
      //         ),
      //         GET.Get.find<DataFileController>().seperator(0.025),
      //         Text(
      //           'ERROR FROM SERVER OR CONNECTION ERROR TO SERVER',
      //           textAlign: TextAlign.center,
      //         ),
      //         GET.Get.find<DataFileController>().seperator(0.05),
      //         ButtonCostum(
      //           width: GET.Get.size.width - 120,
      //           ontap: () {
      //             GET.Get.back();
      //           },
      //           text: 'OK, Saya Mengerti',
      //         )
      //       ],
      //     ),
      //   ));
      // } else if (_res?.errorCode == '9017') {
      //   CustomLoading().dismissLoading();

      //   GET.Get.dialog(
      //     PopoutWrapContent(
      //         textTitle: '',
      //         button_radius: 4,
      //         content: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Center(
      //               child:
      //                   SvgPicture.asset('assets/images/icons/bell_icon.svg'),
      //             ),
      //             SizedBox(
      //               height: 8,
      //             ),
      //             Text(
      //               'Mohon Maaf',
      //               style: PopUpTitle,
      //             ),
      //             SizedBox(
      //               height: 12,
      //             ),
      //             Builder(builder: (context) {
      //               try {
      //                 return Text(
      //                   'PROCESS FAILED, DATABASE PROBLEM',
      //                   style: infoStyle,
      //                   textAlign: TextAlign.center,
      //                 );
      //               } catch (e) {
      //                 return Text(
      //                   'Maaf Service Sedang Maintenance',
      //                   style: infoStyle,
      //                   textAlign: TextAlign.center,
      //                 );
      //               }
      //             })
      //           ],
      //         ),
      //         buttonText: 'Oke Saya Mengerti',
      //         ontap: () {
      //           GET.Get.back();
      //         }),
      //   );
      // }
      // c.updateModel(_res);
      // c.updateModelState(_res);
    }
  });
}

Future<Checkfaceresult?> checkResult(String payload) async {
  try {
    return Checkfaceresult.fromJson(
        (await Dio().post('$URL$FACE_RESULT', data: payload)).data);
  } catch (e) {
    return null;
  }
}

Future<void> checkResultNew(dynamic payload) async {
  try {
    var response = await Services()
        .POST(urlCheckResultZoloz, 'Api Zoloz Check Result', body: payload);
    checkfaceresult = Checkfaceresult.fromJson(response?.data?.body);
    print('ini check result : ${response?.data?.body}');
    // semua yang perlu checkfaceresult sebagai parameternya di ganti sama variabel yang udah dibuat
  } catch (e) {
    ERROR_DIALOG();
  }
}

Widget imageFromBase64String(String? base64String) {
  try {
    return Image.memory(base64Decode(base64String!));
  } catch (e) {
    return const Text("not found");
  }
}

Future<String?> zolozCfg() async {
  try {
    var content = await rootBundle.load("assets/UIConfig.zip");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/UIConfig.zip");
    file.writeAsBytesSync(content.buffer.asUint8List());
    return file.path;
  } catch (e) {
    return null;
  }
}

class ZolozMicroServicesResponse {
  ZolozMicroServicesResponse(
      {
      // this.result,
      this.clientCfg,
      this.transactionId,
      this.resultStatus,
      this.resultCode,
      this.resultMessage,
      this.bizId,
      this.refNum});
  // Result? result;
  String? clientCfg;
  String? transactionId;
  String? resultStatus;
  String? resultCode;
  String? resultMessage;
  String? bizId;
  String? refNum;

  ZolozMicroServicesResponse.fromJson(Map<String, dynamic> json) {
    // result = Result.fromJson(json['result']);
    clientCfg = json['clientCfg'];
    transactionId = json['transactionId'];
    resultStatus = json['resultStatus'];
    resultCode = json['resultCode'];
    resultMessage = json['resultMessage'];
    bizId = json['bizId'];
    refNum = json['refNum'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['result'] = result?.toJson();
    _data['clientCfg'] = clientCfg;
    _data['transactionId'] = transactionId;
    _data['resultStatus'] = resultStatus;
    _data['resultCode'] = resultCode;
    _data['resultMessage'] = resultMessage;
    _data['bizId'] = bizId;
    _data['refnum'] = refNum;
    return _data;
  }
}

class Result {
  Result({
    this.resultStatus,
    this.resultCode,
    this.resultMessage,
  });
  String? resultStatus;
  String? resultCode;
  String? resultMessage;

  Result.fromJson(Map<String, dynamic> json) {
    resultStatus = json['resultStatus'];
    resultCode = json['resultCode'];
    resultMessage = json['resultMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['resultStatus'] = resultStatus;
    _data['resultCode'] = resultCode;
    _data['resultMessage'] = resultMessage;
    return _data;
  }
}

class Checkfaceresult {
  String? nik;
  String? refNum;
  String? channel;
  String? retryCount;
  String? faceAttack;
  String? quality;
  String? resultCode;
  String? resultMessage;
  String? resultStatus;
  String? availableLiveness;
  String? errorCode;
  String? errorMessage;
  String? imageContent;

  Checkfaceresult({
    this.nik,
    this.refNum,
    this.channel,
    this.retryCount,
    this.faceAttack,
    this.quality,
    this.resultCode,
    this.resultMessage,
    this.resultStatus,
    this.availableLiveness,
    this.errorCode,
    this.errorMessage,
    this.imageContent,
  });

  factory Checkfaceresult.fromJson(Map<String, dynamic> json) {
    return Checkfaceresult(
      nik: json['nik'] as String?,
      refNum: json['refNum'] as String?,
      channel: json['channel'] as String?,
      retryCount: json['retryCount'] as String?,
      faceAttack: json['faceAttack'] as String?,
      quality: json['quality'] as String?,
      resultCode: json['resultCode'] as String?,
      resultMessage: json['resultMessage'] as String?,
      resultStatus: json['resultStatus'] as String?,
      availableLiveness: json['availableLiveness'] as String?,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
      imageContent: json['imageContent'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'nik': nik,
        'refNum': refNum,
        'channel': channel,
        'retryCount': retryCount,
        'faceAttack': faceAttack,
        'quality': quality,
        'resultCode': resultCode,
        'resultMessage': resultMessage,
        'resultStatus': resultStatus,
        'availableLiveness': availableLiveness,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
        'imageContent': imageContent,
      };
}

// class CheckFaceResult {
//   CheckFaceResult({
//     this.result,
//     this.extInfo,
//   });
//   Result? result;
//   ExtInfo? extInfo;

//   CheckFaceResult.fromJson(Map<String, dynamic> json) {
//     result = Result.fromJson(json['result']);
//     extInfo = ExtInfo.fromJson(json['extInfo']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['result'] = result?.toJson();
//     _data['extInfo'] = extInfo?.toJson();
//     return _data;
//   }
// }

class ExtInfo {
  ExtInfo({
    this.imageContent,
    this.rect,
    this.retryCount,
    this.faceAttack,
    this.quality,
  });
  String? imageContent;
  Rect? rect;
  int? retryCount;
  bool? faceAttack;
  String? quality;

  ExtInfo.fromJson(Map<String, dynamic> json) {
    imageContent = json['imageContent'];
    rect = Rect.fromJson(json['rect']);
    retryCount = json['retryCount'];
    faceAttack = json['faceAttack'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageContent'] = imageContent;
    _data['rect'] = rect?.toJson();
    _data['retryCount'] = retryCount;
    _data['faceAttack'] = faceAttack;
    _data['quality'] = quality;
    return _data;
  }
}

class Rect {
  Rect({
    this.top,
    this.left,
    this.bottom,
    this.right,
  });
  int? top;
  int? left;
  int? bottom;
  int? right;

  Rect.fromJson(Map<String, dynamic> json) {
    top = json['top'];
    left = json['left'];
    bottom = json['bottom'];
    right = json['right'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['top'] = top;
    _data['left'] = left;
    _data['bottom'] = bottom;
    _data['right'] = right;
    return _data;
  }
}

class FaceInitPayload {
  FaceInitPayload(
      {this.metaInfo,
      this.userId,
      this.docType,
      this.bizId,
      this.nik,
      this.channel,
      this.refNum});
  String? metaInfo;
  String? userId;
  String? docType;
  String? bizId;
  String? nik;
  String? refNum;
  String? channel;

  FaceInitPayload.fromJson(Map<String, dynamic> json) {
    metaInfo = json['metaInfo'];
    userId = json['userId'];
    docType = json['docType'];
    bizId = json['bizId'];
    nik = json['nik'];
    refNum = json['refNum'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['metaInfo'] = metaInfo;
    _data['userId'] = userId;
    _data['docType'] = docType;
    _data['bizId'] = bizId;
    _data['nik'] = nik;
    _data['refNum'] = refNum;
    _data['channel'] = channel;
    return _data;
  }
}

class ResultFacePayload {
  ResultFacePayload(
      {this.transactionId,
      // this.isReturnImage,
      this.bizId,
      this.channel,
      this.nik,
      this.refNum});
  String? transactionId;
  // String? isReturnImage;
  String? bizId;
  String? nik;
  String? refNum;
  String? channel;

  ResultFacePayload.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    // isReturnImage = json['isReturnImage'];
    bizId = json['bizId'];
    nik = json['nik'];
    refNum = json['refNum'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transactionId'] = transactionId;
    // _data['isReturnImage'] = isReturnImage;
    _data['bizId'] = bizId;
    _data['nik'] = nik;
    _data['refNum'] = refNum;
    _data['channel'] = channel;
    return _data;
  }
}
