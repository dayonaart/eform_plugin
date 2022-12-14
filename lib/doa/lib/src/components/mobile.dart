import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File(appDocPath + '/' + '$fileName.pdf');

  print('Save as file ${file.path} ...');
  await file.writeAsBytes(bytes, mode: FileMode.append);
  await OpenFile.open(file.path);
}

Future<void> downloadDirectory(List<int> bytes, String filename) async {
  // Directory downloadsDirectory;
  // downloadsDirectory = (await DownloadsPathProvider.downloadsDirectory)!;
  // final appDocPath = downloadsDirectory.path;
  // final file = File(appDocPath + '/' + datetime + '-$filename.pdf');
  final file = File('/storage/emulated/0/Download/$filename.pdf');
  print('Save as file ${file.path} ...');
  await file.writeAsBytes(bytes, mode: FileMode.append);
  await OpenFile.open(file.path);
}
