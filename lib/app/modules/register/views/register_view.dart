import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/constants.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {

    final content = Obx(() {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(controller.title.value),
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
                    onPressed: controller.register, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline_outlined, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          'Crear Usuario',
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
                  'Ya tienes una cuenta',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  onPressed: () => {
                    Get.offAllNamed(Routes.LOGIN)
                  },
                  child: Text(
                    'Inicia Sesión',
                    style: TextStyle(
                      color: PRIMARY_COLOR
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registate en $APP_NAME',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: content,
    );
  }
}
