import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiver/core.dart';
import 'package:sdfe_task_manager_app/app/data/constants.dart';
import 'package:sdfe_task_manager_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {

    final content = Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: SECONDARY_LIGHT_COLOR,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.offAllNamed(Routes.PROFILE);
                          },
                          child: Container(
                            foregroundDecoration: BoxDecoration(
                              color: Colors.grey,
                              backgroundBlendMode: BlendMode.saturation,
                            ),
                            child: Image.asset(
                              'assets/images/user_default.png',
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.offAllNamed(Routes.PROFILE);
                              },
                              child: Text(
                                "@${controller.username.value}",
                                  style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                            ),
                            Text(
                              'ID: ${controller.userLoged.value.id ?? ''}',
                              style: TextStyle(
                                color: SECONDARY_COLOR,
                                fontSize: 13
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: controller.logout, 
                      icon: Icon(Icons.exit_to_app_rounded),
                      color: Colors.redAccent.shade100,
                    )
                  ],
                )
              )
              ,
              controller.tasks.length == 0 ? 
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close),
                        Text(
                          'No se tienen tareas'
                        )
                      ],
                    ),
                  ),
                )
              :
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.stateSelected.value = false;
                                controller.getTasks();
                              },
                              child: Chip(
                                padding: EdgeInsets.all(1),
                                visualDensity: VisualDensity.compact,
                                color: WidgetStateColor.resolveWith((c) => controller.stateSelected.value == false ? PRIMARY_COLOR : SECONDARY_LIGHT_COLOR),
                                label: Row(
                                  children: [
                                    Text(
                                      'Pendientes',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: controller.stateSelected.value == false ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    controller.stateSelected.value == false ? Icon(Icons.circle, size: 13, color: Colors.white) : Container()
                                  ],
                                ),
                              )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                controller.stateSelected.value = true;
                                controller.getTasks();
                              },
                              child: Chip(
                                padding: EdgeInsets.all(1),
                                color: WidgetStateColor.resolveWith((c) => controller.stateSelected.value == true ? PRIMARY_COLOR : SECONDARY_LIGHT_COLOR),
                                visualDensity: VisualDensity.compact,
                                label: Row(
                                  children: [
                                    Text(
                                      'Completados',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: controller.stateSelected.value == true ? Colors.white : Colors.black
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    controller.stateSelected.value == true ? Icon(Icons.circle, size: 15, color: Colors.white) : Container()
                                  ],
                                ),
                                
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                    ...controller.tasks.map((t) {
                      return Card(
                        elevation: 0.5,
                        color: t.completed! ? SECONDARY_LIGHT_COLOR : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: !t.completed! ? () async  {
                                      int index = controller.tasks.indexOf(t);
                                      controller.tasks[index] = t.copyWith(completed: Optional.of(!t.completed!), exists: Optional.of(true));
                                      await controller.completedTask(controller.tasks[index]);
                                      Future.delayed(Duration(seconds: 3), () {
                                        controller.tasks.value = controller.tasks.where((x) => x.id != t.id).toList();
                                      });
                                    } : null,
                                    child: Icon(!t.completed! ? Icons.circle_outlined : Icons.circle, color: SECONDARY_COLOR, size: 20,)
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t.title ?? '',
                                          style: TextStyle(
                                            color: t.completed! ? SECONDARY_COLOR : Colors.black,
                                            decoration: t.completed! ? TextDecoration.lineThrough : null,
                                            decorationColor: SECONDARY_COLOR
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              !t.completed! ? 
                                  IconButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.TASK_DETAIL, arguments: [t]);
                                    }, 
                                    icon: Icon(Icons.edit, size: 20, color: PRIMARY_COLOR,)
                                  )
                                :
                                  Container()
                            ],
                          ),
                        )
                        // ListTile(
                        //   dense: true,
                        //   contentPadding: EdgeInsets.only(left: 5, right: 5),
                        //   trailing: !t.completed! ? 
                        //     IconButton(
                        //       onPressed: () {
                        //         Get.toNamed(Routes.TASK_DETAIL, arguments: [t]);
                        //       }, 
                        //       icon: Icon(Icons.edit, size: 18,)
                        //     )
                        //   :
                        //     null
                        //   ,
                        //   title: Text(
                        //     t.title ?? '',
                        //     style: TextStyle(
                        //       decoration: t.completed! ? TextDecoration.lineThrough : null
                        //     ),
                        //   ),
                        //   leading: IconButton(
                        //     onPressed: !t.completed! ? () async  {
                        //       int index = controller.tasks.indexOf(t);
                        //       controller.tasks[index] = t.copyWith(completed: Optional.of(!t.completed!), exists: Optional.of(true));
                        //       await controller.completedTask(controller.tasks[index]);
                        //       Future.delayed(Duration(seconds: 3), () {
                        //         controller.tasks.value = controller.tasks.where((x) => x.id != t.id).toList();
                        //       });
                        //     } : null, 
                        //     icon: Icon(t.completed! ? Icons.check_box_sharp : Icons.square_outlined)
                        //   ),
                        // ),
                      );
                    })
                  ],
                )
            ],
          ),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.offAndToNamed(Routes.TASK_DETAIL);
        },
        backgroundColor: PRIMARY_COLOR,
        label: Row(
          children: [
            Icon(Icons.add, color: Colors.white,),
            SizedBox(
              width: 5,
            ),
            Text(
              'Nueva',
              style: TextStyle(
                color: Colors.white
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              color: PRIMARY_COLOR,
            ),
            SizedBox(width: 5,),
            Text(
              'Task Manager App',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: content,
    );
  }
}
