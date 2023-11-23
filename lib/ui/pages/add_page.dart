// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/authentication_controller.dart';
import 'package:proychat/ui/controllers/location_controller.dart';
import 'package:proychat/ui/controllers/user_controller.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Color mainTextColor = Colors.white;
  final _formKey = GlobalKey<FormState>();
  UserController controller = Get.find();
  AuthenticationController aut_controller = Get.find();
  LocationController locController = Get.find();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 11, 44),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 51, 124),
        //centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1), // Altura de la línea
          child: Divider(
            color: Color.fromARGB(80, 255, 255, 255), // Color de la línea
            height: 0.0, // Grosor de la línea
          ),
        ),
        title: const Text(
          'Add Contact',
          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // TEXTO
                    child: Text("Enter the contact's username",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Montserrat")),
                  ),
                ),
                // TEXTFIELDFORM DE USERNAME
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextFormField(
                      style: const TextStyle(fontFamily: "Montserrat"),
                      controller: _controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z_]"))
                      ],
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.alternate_email,
                              color: Color.fromARGB(255, 97, 97, 97)),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 97, 97, 97),
                              fontFamily: "Montserrat"),
                          floatingLabelBehavior: FloatingLabelBehavior.never)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Flexible(
                  // BOTÓN DE GUARDAR CONTACTO/USUARIO
                  child: ElevatedButton(
                    onPressed: () {
                      bool valid = false;
                      String username = _controller.text;
                      for (var i = 0; i < controller.users.length; i++) {
                        if (username == controller.users[i].username) {
                          valid = true;
                          break;
                        }
                      }
                      if (valid) {
                        controller.addFriend(username);
                        aut_controller.editUser(
                            controller.name,
                            controller.username,
                            controller.email,
                            controller.password,
                            controller.key,
                            controller.friends, [
                          locController.userLocation.value.latitude,
                          locController.userLocation.value.longitude,
                          locController.lastActualization.hour,
                          locController.lastActualization.minute
                        ]);
                        Get.back();
                        print("contact added");
                      } else {
                        print("Usuario Inválido");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 155, 69)),
                    child: const Text('Save',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "Montserrat")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
