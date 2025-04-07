import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:quiver/core.dart';
import 'package:sdfe_task_manager_app/app/data/services/auth.service.dart';
import 'package:sdfe_task_manager_app/app/data/services/database.service.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';
import 'package:sdfe_task_manager_app/models/task.dart';
import 'package:sdfe_task_manager_app/models/user.dart' as UserModel;

class TaskDetailController extends GetxController {
  //TODO: Implement TaskDetailController

  final title = 'Nueva Tarea'.obs;
  final Auth = Get.put(AuthService());
  final Database = Get.put(DatabaseService());

  final count = 0.obs;
  final newTask = Task().obs;
  var data = Get.arguments;
  final userLoged = UserModel.User().obs;
  final taskTitle = TextEditingController();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final loading = true.obs;
  final isNew = false.obs;
  @override
  void onInit() async {
    super.onInit();
    User user = Auth.currentUser!;
    DataSnapshot? snapshot = await Database.getBy(path: 'users', field: 'email', value: user.email!);
    print(snapshot!.children.first.value);
    dynamic result = snapshot!.children.first.value;
    userLoged.value = UserModel.User.fromSnapshot(result);
    if (data != null) {
      newTask.value = data[0];
      title.value = 'Editando Tarea';
      if (newTask.value.exists.isBlank!) {
        newTask.value = newTask.value.copyWith(exists: Optional.of(true));
      }
      if (!newTask.value.exists!) {
        isNew.value = true;
      }
      taskTitle.value = TextEditingValue(text: newTask.value.title!);
    }
    loading.value = false;
  }

  @override
  void onReady() {
    super.onReady();


  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  save() async {
    Task taskAltered = newTask.value.copyWith(title: Optional.of(taskTitle.text), userId: Optional.of(userLoged.value.id!), exists: Optional.of(true));
    var result = await Database.create(path: 'tasks', data: taskAltered.toJson());
    Get.offAllNamed(Routes.HOME);
  }

  put() async  {
    Task taskAltered = newTask.value.copyWith(title: Optional.of(taskTitle.text));
    var result = await Database.update(path: 'tasks', data: taskAltered.toJson());
    Get.offAllNamed(Routes.HOME);
  }

  deleteTask() async {
    var result = await Database.delete(path: 'tasks', id: "${newTask.value.id!}");
    Get.offAllNamed(Routes.HOME);
  }
}
