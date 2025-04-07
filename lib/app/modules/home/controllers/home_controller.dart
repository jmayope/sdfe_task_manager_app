import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/services/auth.service.dart';
import 'package:sdfe_task_manager_app/app/data/services/database.service.dart';
import 'package:sdfe_task_manager_app/app/data/services/task.service.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';
import 'package:sdfe_task_manager_app/models/task.dart';
import 'package:sdfe_task_manager_app/models/user.dart' as UserModel;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final Auth = Get.put(AuthService());
  final taskService = Get.put(TaskService());
  final Database = Get.put(DatabaseService());

  final username = 'usuario'.obs;
  final userId = int.parse('1').obs;
  final allTasks = <Task>[].obs;
  final tasks = <Task>[].obs;
  final tasksInFirebase = <Task>[].obs;
  final userLoged = UserModel.User().obs;
  final stateSelected = false.obs;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    User user = Auth.currentUser!;
    username.value = user.email!;
    DataSnapshot? snapshot = await Database.getBy(path: 'users', field: 'email', value: user.email!);
    print(snapshot!.children.first.value);
    dynamic result = snapshot!.children.first.value;
    userLoged.value = UserModel.User.fromSnapshot(result);
    
    getTasks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getTasks() async {
    DataSnapshot? snapshot = await Database.getBy(path: 'tasks', field: 'userId', value: "${userLoged.value.id!}", dataType: 'number');
    if (snapshot != null) {
      dynamic result = snapshot!.value;
      var data = result as Iterable;
      print(result);
      data = data.where((d) => d != null);
      tasksInFirebase.value = data.map((d) => Task.fromSnapshot(d)).toList();
      allTasks.value = await taskService.getTasks();
      allTasks.value = allTasks.where((t) => t.userId == userLoged.value.id).toList();
    } else {
      allTasks.value = [];
    }
    for (Task t in allTasks) {
      int index = allTasks.indexOf(t);
      Task taskFound = tasksInFirebase.singleWhere((x) => x.id == t.id, orElse: () => Task());
      print(taskFound.toJson().toString());
      if (taskFound.id != null) {
        allTasks[index] = taskFound;
      }
    }
    filterTask();
    print(tasks.length);
  }

  filterTask() {
    tasks.value = allTasks.where((t) => t.completed == stateSelected.value).toList();
  }

  completedTask(Task t) async {
    var result = await Database.create(path: "tasks", data: t.toJson());
  }

  logout() async {
    var result = await Auth.signout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
