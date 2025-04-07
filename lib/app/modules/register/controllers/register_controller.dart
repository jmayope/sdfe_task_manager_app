import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/services/auth.service.dart';
import 'package:sdfe_task_manager_app/app/data/services/database.service.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final registering = false;
  final error = false.obs;
  final errorMessage = ''.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  
  final Auth = Get.put(AuthService());
  final Database = Get.put(DatabaseService());
  final title = 'Crea una cuenta'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  register() async {
    error.value = false;
    errorMessage.value = '';
    try {
      var result = await Auth.createAccount(email: email.text, password: password.text);
      int quantityOfUsers = await Database.getQuantity(path: 'users');
      var newUser = await Database.create(path: 'users', data: {"email": email.text, "password": password.text, "id": quantityOfUsers + 1});
      Get.defaultDialog(
        title: 'Aviso',
        middleText: 'Se creó la cuenta correctamente'
      );
      Future.delayed(Duration(seconds: 3), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    } on FirebaseAuthException catch (e) {
      error.value = true;
      errorMessage.value = e.message ?? '';
    }
  }
  
}
