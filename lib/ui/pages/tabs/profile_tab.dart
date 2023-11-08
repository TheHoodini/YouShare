// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/user_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final double coverHeight = 170;
  final double profileHeight = 144;
  final Color uiColor = const Color.fromARGB(255, 2, 11, 44);

  final TextEditingController _controller = TextEditingController();

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
        ],
      ),
    );
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
        child: Image.asset("../../../../assets/landscape.jpg",
            width: double.infinity, height: coverHeight, fit: BoxFit.cover),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: uiColor,
        child: Image.asset("../../../../assets/user.png", height: 130),
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
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: TextField(
                        controller: _controller,
                        onEditingComplete: () {
                          // Cuando se completa la edición, actualiza el valor en el controlador
                          controller.setSalute(_controller.text);
                          controller.setIsEditing(false);
                        },
                        style: const TextStyle(fontFamily: "Montserrat"),
                        inputFormatters: [LengthLimitingTextInputFormatter(100)],
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 51, 124),
                                    width: 2.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 2, 155, 69),
                                    width: 2.0)),
                            labelText: 'Salute',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 97, 97, 97),
                                fontStyle: FontStyle.normal,
                                fontFamily: "Montserrat"),
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                      ));
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
                    print("a");
                    // Habilita el modo de edición al hacer clic en el ícono
                    controller.setIsEditing(true);
                    // Inicializa el valor del TextField con el valor actual
                    _controller.text = controller.salute;
                  } else {
                    controller.setIsEditing(false);
                  }
                },
                child: Icon(Icons.border_color, color: Color.fromARGB(255, 2, 155, 69)),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          // ---------------------------
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 0.0,
                ),
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
                //
                const SizedBox(
                  width: 0.0,
                ),
              ]),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
