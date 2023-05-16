import 'package:eval_widgets/api.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ApiImpl extends Api {
  @override
  void toast() {
    Get.snackbar("API", "call API from eval widgets but handled in host flutter app!");
  }
}