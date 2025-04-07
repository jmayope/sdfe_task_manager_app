import 'package:get/get.dart';

import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:sdfe_task_manager_app/app/data/constants.dart';
import 'package:sdfe_task_manager_app/models/task.dart';

class TaskService extends GetxController with StateMixin<dynamic> {
  TaskService() {
    change('', status: RxStatus.empty());
  }

  String uri = URI_JPH;

  Future<dynamic> getTasks() async {
    try {
      change(null, status: RxStatus.loading());
      var url = Uri.parse('$uri/todos');
      print(url);
      var response = await http.get(url);
      print(response);
      Iterable data = convert.jsonDecode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } catch (err) {
      print(err);
      return {"message": err.toString(), "error": true};
    }
  }
  
}