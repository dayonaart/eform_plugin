import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class GetCabang {
  final _jsonObject = File("packages/eformplugin/assets/jsonfiles").path;
  Future<List> readJsonProvinsi() async {
    final String response =
        await rootBundle.loadString("$_jsonObject/provinsi_cabang.json");
    final data = await json.decode(response);
    return data["regions"];

    // print("inisiasi:" + _listProvinsi.toString() + "\n");
  }

  // Fetch json kota from the json file
  Future<List> readJsonKota() async {
    final String response =
        await rootBundle.loadString('$_jsonObject/kota_cabang.json');
    final data = await json.decode(response);

    return data["regions"];

    // print("inisiasi:" + _listKota.toString() + "\n");
  }

  // Fetch json kota from the json file
  Future<List> readJsonKantor() async {
    final String response =
        await rootBundle.loadString('$_jsonObject/kantor_cabang.json');

    final data = await jsonDecode(response);

    return data["regions"];

    // print("inisiasi:" + _listkantor.toString() + "\n");
  }

  Future<List> readJsonBi() async {
    final String response = await rootBundle.loadString('$_jsonObject/bi.json');
    final data = await json.decode(response);

    return data["bi"];

    // print("inisiasi:" + _listkodebi.toString() + "\n");
  }
}
