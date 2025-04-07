import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {

    final content = Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.HOME);
                    }, 
                    icon: Icon(Icons.home)
                  ),
                  Text(
                    controller.title.value,
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              controller.loading.value ? 
                CircularProgressIndicator()
              :
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            controller.labelPhoto.value,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/user_default.png',
                              width: 150,
                              height: 150,
                            )
                          ],
                        ),
                        ItemList(label: 'UID', value: controller.userInfo["uid"],),
                        ItemList(label: 'Correo Electrónico', value: controller.userLoged.value.email!,),
                        ItemList(label: 'Última sesión', value: controller.userInfo["lastSignInTime"],),
                        ItemList(label: 'Fecha de Registro', value: controller.userInfo["creationTime"],),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    });

    return Scaffold(
      body: content
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    this.label = '',
    this.value = ''
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal
                  )
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
