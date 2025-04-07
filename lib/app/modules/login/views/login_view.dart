import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/constants.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {

    final form = Obx(() {
      return Form(
        child: Column(
          children: [
            Text(
              'Bienvenido a $APP_NAME'
            ),
            Text(
              controller.title.value,
              style: TextStyle(
                color: PRIMARY_COLOR,
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
            TextFormField(
              controller: controller.email,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0),
                  borderRadius: BorderRadius.circular(30)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SECONDARY_COLOR, width: 2.0),
                  borderRadius: BorderRadius.circular(30)
                ),
                labelStyle: TextStyle(
                  color: PRIMARY_COLOR
                ),
                labelText: 'Correo Electrónico'
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: controller.password,
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0),
                  borderRadius: BorderRadius.circular(30)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SECONDARY_COLOR, width: 2.0),
                  borderRadius: BorderRadius.circular(30)
                ),
                labelStyle: TextStyle(
                  color: PRIMARY_COLOR
                ),
                labelText: 'Contraseña'
              ),
            ),
            SizedBox(
              height: 15,
            ),
            controller.error.value ? 
              Text(
                controller.errorMessage.value,
                style: TextStyle(
                  color: Colors.redAccent
                ),
              ) 
              :
              Container()
            ,
            
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: controller.login, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send, color: Colors.white,),
                    SizedBox(width: 5,),
                    Text(
                      'Ingresar',
                      style: TextStyle(
                      color: Colors.white
                      ),
                    )
                  ],
                )
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Si no tienes una cuenta',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
              onPressed: () => {
                Get.toNamed(Routes.REGISTER)
              },
              child: Text(
                'Registrate',
                style: TextStyle(
                  color: PRIMARY_COLOR
                ),
              )
            )
          ],
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                form
              ],
            ),
          ),
        ),
      ),
    );
  }
}
