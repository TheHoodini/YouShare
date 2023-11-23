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
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontFamily: "Montserrat"),
        ),
      ),
    );
  }

  Widget _list() {
    // Un widget con La lista de los usuarios con una validación para cuándo la misma este vacia
    // la lista de usuarios la obtenemos del userController
    if (controller.users.isEmpty || controller.friends.isEmpty) {
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
        itemCount: controller.friends.length,
        itemBuilder: (context, index) {
          var usernameVar = controller.friends[index];
          bool friend = false;
          var i = 0;
          for (i = 0; i < controller.users.length; i++) {
            if (usernameVar == controller.users[i].username) {
              friend = true;
              print(usernameVar);
              break;
            }
          }
          if (friend) {
            return _item(
                controller.users[i].email,
                controller.users[i].uid,
                controller.users[i].name,
                controller.users[i].username,
                controller.users[i].salute);
          }
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
