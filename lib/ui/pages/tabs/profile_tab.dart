// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/authentication_controller.dart';
import 'package:proychat/ui/controllers/location_controller.dart';
import 'package:proychat/ui/controllers/user_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final double coverHeight = 150;
  final double profileHeight = 144;
  final Color uiColor = const Color.fromARGB(255, 2, 11, 44);

  final TextEditingController _controller = TextEditingController();
  AuthenticationController autController = Get.find();
  LocationController locController = Get.find();

  IconData editIcon = Icons.border_color;

  @override
  Widget build(BuildContext context) {
    UserController user_controller = Get.find();
    return Scaffold(
      backgroundColor: uiColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(user_controller),
          //buildLogOutButton()
        ],
      ),
    );
  }

  Widget buildLogOutButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      // BOTÓN LOG OUT
      ElevatedButton(
        onPressed: () => Get.offNamed('/auth_page'),
        style: ElevatedButton.styleFrom(
          //fixedSize: const Size.fromHeight(40),
          backgroundColor: const Color.fromARGB(255, 2, 155, 69),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.logout,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              "Log Out",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget buildTop() {
    final bottom = profileHeight / 2 + 5;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom), child: buildCoverImage()),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset("assets/landscape.jpg",
            width: double.infinity, height: coverHeight, fit: BoxFit.cover),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: uiColor,
        child: Image.asset("assets/user.png", height: 130),
      );

  buildContent(UserController controller) => Column(
        // TEXTOS DEL NOMBRE DE USUARIO
        children: [
          Obx(() => Text(controller.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold))),
          Obx(() => Text('@${controller.username}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w200))),
          Obx(() => Text(controller.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w200))),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.isEditing) {
                  // Muestra un TextField cuando está en modo de edición
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: TextField(
                      controller: _controller,
                      onEditingComplete: () {
                        // Cuando se completa la edición, actualiza el valor en el controlador
                        setState(() {
                          editIcon = Icons.border_color;
                        });
                        controller.setSalute(_controller.text);
                        controller.setIsEditing(false);
                        autController.editUser(
                            controller.name,
                            controller.username,
                            controller.salute,
                            controller.email,
                            controller.password,
                            controller.key,
                            controller.friends, [
                          locController.userLocation.value.latitude,
                          locController.userLocation.value.longitude,
                          locController.lastActualization.hour,
                          locController.lastActualization.minute,
                          locController.markerVisibility
                        ]);
                      },
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 14),
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      decoration: const InputDecoration(
                        filled: false,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 51, 124),
                                width: 2.0)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 2, 155, 69),
                              width: 2.0),
                        ),
                      ),
                    ), //tf
                  );
                } else {
                  // Muestra un Text cuando no está en modo de edición
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(80, 10, 80, 0),
                      child: Text(
                        controller.salute,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                        ),
                      ));
                }
              }),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  if (!controller.isEditing) {
                    setState(() {
                      editIcon = Icons.edit_off;
                    });
                    // Habilita el modo de edición al hacer clic en el ícono
                    controller.setIsEditing(true);
                    // Inicializa el valor del TextField con el valor actual
                    _controller.text = controller.salute;
                  } else {
                    controller.setIsEditing(false);
                    setState(() {
                      editIcon = Icons.border_color;
                    });
                  }
                },
                child: Icon(editIcon,
                    color: const Color.fromARGB(255, 2, 155, 69)),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          // ---------------------------
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
