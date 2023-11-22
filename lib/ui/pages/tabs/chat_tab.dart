// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:proychat/ui/controllers/user_controller.dart';

import '../../controllers/authentication_controller.dart';
import '../../controllers/chatController.dart';
import '../chat_page.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  Color mainTextColor = Colors.white;
  UserController controller = Get.find();

  AuthenticationController authenticationController = Get.find();
  ChatController chatController = Get.find();

  @override
  void dispose() {
    // le decimos al userController que se cierre los streams
    controller.stop();
    super.dispose();
  }

  _logout() async {
    try {
      await authenticationController.logout();
    } catch (e) {
      logError(e);
    }
  }

  Widget _item(String element, uid, name, username, salute) {
    // Widget usado en la lista de los usuarios
    // mostramos el correo y uid
    return Card(
      color: const Color.fromARGB(255, 5, 22, 84),
      elevation: 5,
      margin: const EdgeInsets.all(4.0),
      child: ListTile(
        onTap: () {
          Get.to(() => const ChatPage(), arguments: [uid, element, name]);
        },
        title: Text(
          name,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat"),
        ),
        subtitle: Text(
          "@$username - $salute",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w200,fontFamily: "Montserrat"),
        ),
      ),
    );
  }

  Widget _list() {
    // Un widget con La lista de los usuarios con una validación para cuándo la misma este vacia
    // la lista de usuarios la obtenemos del userController
    if (controller.users.isEmpty) {
      return const Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Press ',
            style: TextStyle(color: Colors.white, fontFamily: "Montserrat")),
        Icon(Icons.person_add, color: Colors.white),
        Text(' to add someone here!',
            style: TextStyle(color: Colors.white, fontFamily: "Montserrat")),
      ]));
    } else {
      return ListView.builder(
        itemCount: controller.users.length,
        itemBuilder: (context, index) {
          var element = controller.users[index].email;
          return _item(element, controller.users[index].uid,
              controller.users[index].name, controller.users[index].username, controller.users[index].salute);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 11, 44),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: _list())),
      );
}
