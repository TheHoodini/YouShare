import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/authentication_controller.dart';
import 'package:proychat/ui/controllers/user_controller.dart';

class LoginBox extends StatefulWidget {
  final Function(int) changeMainPageIndex;
  const LoginBox({super.key, required this.changeMainPageIndex});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserController controller = Get.find();
    AuthenticationController autController = Get.find();
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400, // Ancho máximo del SimpleDialog
          maxHeight: MediaQuery.of(context).size.height * 0.7, // Altura máxima
        ),
        child: SimpleDialog(
          backgroundColor:
              const Color.fromARGB(255, 0, 51, 124).withOpacity(0.7),
          // Aquí puede ir el logo en vez del Text()
          // title: Image.asset("assets/logo.png", height: 120),
          title: const Text('YouShare',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontFamily: "Montserrat")),
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(13, 0, 10, 0),
              child: Text('Log in',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat")),
            ),
            // EMAIL
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                  style: const TextStyle(fontFamily: "Montserrat"),
                  controller: _controller,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]")),
                    LengthLimitingTextInputFormatter(50)
                  ],
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.mail,
                          color: Color.fromARGB(255, 97, 97, 97)),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 97, 97, 97),
                          fontFamily: "Montserrat"),
                      floatingLabelBehavior: FloatingLabelBehavior.never)),
            ),
            // PASSWORD
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: TextFormField(
                  obscureText: true,
                  controller: _controller2,
                  inputFormatters: [LengthLimitingTextInputFormatter(29)],
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.lock,
                          color: Color.fromARGB(255, 97, 97, 97)),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 97, 97, 97),
                          fontFamily: "Montserrat"),
                      floatingLabelBehavior: FloatingLabelBehavior.never)),
            ),
            // TEXTO DE CREAR CUENTA
            Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 20),
                child: GestureDetector(
                    onTap: () {
                      // cambia el index a 1
                      widget.changeMainPageIndex(1);
                    },
                    child: const Text('No account? Click here to create one!',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontFamily: "Montserrat")))),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 0.0,
                  ),
                  // BOTÓN LOG IN
                  ElevatedButton(
                    onPressed: () => {
                      autController.login(_controller.text, _controller2.text),
                      controller.setEmail(_controller.text),
                      controller.setPassword(_controller2.text)
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(40),
                        backgroundColor: const Color.fromARGB(255, 2, 155, 69),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    child: const Text("Log In!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat")),
                  ),
                  const SizedBox(
                    width: 0.0,
                  ),
                ]),
            const SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
