import 'package:eformplugin/doa/lib/run_doa.dart';
import 'eformplugin_platform_interface.dart';

class Eformplugin {
  Future<String?> openDoa({String? route}) async {
    var route = await EformpluginPlatform.instance.openDoa();
    runDoa(route: route);
    return "opening doa $route";
  }
}
