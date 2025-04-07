import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/services/auth.service.dart';
import 'package:sdfe_task_manager_app/app/data/services/database.service.dart';

import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';
import 'package:sdfe_task_manager_app/models/user.dart' as UserModel;

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final error = false.obs;
  final loged = false.obs;
  final loging = false.obs;
  final Auth = Get.put(AuthService());
  final Database = Get.put(DatabaseService());
  final email = TextEditingController();
  final password = TextEditingController();
  final userLoged = UserModel.User().obs;
  final errorMessage = ''.obs;
  final title = 'Iniciar sesión'.obs;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    initSecurity();
  }

  initSecurity() async {
    
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  login() async {
    try {
    var result = await Auth.signIn(email: email.text, password: password.text);
    DataSnapshot? snapshot = await Database.getBy(path: 'users', field: 'email', value: email.text);
    dynamic userFound = snapshot!.value;
    UserModel.User user = UserModel.User.fromSnapshot(userFound);
    await Auth.setSession(user);
    Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      error.value = true;
      errorMessage.value = e.message ?? '';
    }
  }

  void increment() => count.value++;
}
