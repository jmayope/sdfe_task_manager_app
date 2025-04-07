import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/constants.dart';
import 'package:sdfe_task_manager_app/app/data/services/auth.service.dart';
import 'package:sdfe_task_manager_app/models/user.dart' as UserModel;

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final Auth = Get.put(AuthService());
  final userLoged = UserModel.User().obs;
  final userInfo = {}.obs;
  final title = 'Perfil de Usuario'.obs;
  final labelPhoto = ''.obs;
  final count = 0.obs;
  final loading = true.obs;
  @override
  void onInit() async {
    super.onInit();
    labelPhoto.value = 'Foto de Perfil';
    User user = Auth.currentUser!;
    userLoged.value = await Auth.getSession(user.email!);
    userInfo.value = {
      "isEmailVerified": user.emailVerified,
      "uid": user.uid,
      "lastSignInTime": stringDateTime(user.metadata.lastSignInTime!),
      "creationTime": stringDate(user.metadata.creationTime!)
    };
    print(userLoged.value.toJson().toString());
    print(user.toString());
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
}
