import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sdfe_task_manager_app/app/data/constants.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';

import '../controllers/task_detail_controller.dart';

class TaskDetailView extends GetView<TaskDetailController> {
  const TaskDetailView({super.key});
  @override
  Widget build(BuildContext context) {

    final content = Obx(() {
      return Stack(
        children: [
          Padding(
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
                  SizedBox(height: 30,),
                  controller.isNew.value ?
                    Row(
                      children: [
                        Chip(
                          visualDensity: VisualDensity.compact,
                          label: Row(
                            children: [
                              Icon(Icons.close, size: 15,),
                              Text( 
                                controller.isNew.value ? 'No Sync con Firebase' : ''
                              ),
                            ],
                          )
                        )
                      ],
                    )
                  :
                    Container()
                  ,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade50,
                    ),
                    child: TextFormField(
                      controller: controller.taskTitle,
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 15, bottom: 15),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.font_download_outlined, color: Colors.blueGrey.shade100,),
                        labelText: 'Nombre de la tarea',
                        labelStyle: TextStyle(
                          color: PRIMARY_COLOR
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (controller.newTask.value.exists.isBlank! || controller.newTask.value.exists!) {
                            await controller.put();
                          } else {
                            await controller.save();
                          }
                        }, 
                        child: Text(
                          'Guardar Cambios',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          Get.offAllNamed(Routes.HOME);
                        }, 
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: PRIMARY_COLOR
                          ),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          controller.loading.value ? 
            Container()
          :
            !controller.isNew.value ?
              Padding(
                padding: const EdgeInsets.only(top:25, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.delete_forever_outlined, color: Colors.white,),
                    onPressed: () async {
                      await controller.deleteTask();
                    }
                  ),
                ),
              )
            :
              Container()
        ],
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: content
    );
  }
}
