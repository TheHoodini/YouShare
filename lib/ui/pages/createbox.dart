import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateBox extends StatefulWidget {
  final Function(int) changeMainPageIndex;
  const CreateBox({super.key, required this.changeMainPageIndex});
  @override
  State<CreateBox> createState() => _CreateBoxState();
}

class _CreateBoxState extends State<CreateBox> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: const Color.fromARGB(255, 0, 51, 124).withOpacity(0.7),
      // Aquí puede ir el logo en vez del Text()
      // title: Image.asset("assets/logo.png", height: 120),
      title: const Text('YouShare',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontFamily: "Montserrat")),
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(13, 0, 10, 0),
          child: Text('Create account',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat")),
        ),
        const SizedBox(
          height: 10.0,
        ),
        // NAME
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextFormField(
              style: const TextStyle(fontFamily: "Montserrat"),
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.person,
                      color: Color.fromARGB(255, 97, 97, 97)),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 97, 97),
                      fontStyle: FontStyle.normal,
                      fontFamily: "Montserrat"),
                  floatingLabelBehavior: FloatingLabelBehavior.never)),
        ),
        // USERNAME
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextFormField(
              style: const TextStyle(fontFamily: "Montserrat"),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                LengthLimitingTextInputFormatter(20)
              ],
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.alternate_email,
                      color: Color.fromARGB(255, 97, 97, 97)),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 97, 97),
                      fontStyle: FontStyle.normal,
                      fontFamily: "Montserrat"),
                  floatingLabelBehavior: FloatingLabelBehavior.never)),
        ),
        // PASSWORD
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextFormField(
              obscureText: true,
              inputFormatters: [LengthLimitingTextInputFormatter(30)],
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon:
                      Icon(Icons.lock, color: Color.fromARGB(255, 97, 97, 97)),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 97, 97, 97),
                      fontStyle: FontStyle.normal,
                      fontFamily: "Montserrat"),
                  floatingLabelBehavior: FloatingLabelBehavior.never)),
        ),
        // TEXTO DE CREAR CUENTA
        Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 0, 20),
            child: GestureDetector(
                onTap: () {
                  widget.changeMainPageIndex(0);
                },
                child:
                    const Text('Already have an account? click here to Log in!',
                        style: TextStyle(
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontFamily: "Montserrat")))),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 0.0,
              ),
              // BOTÓN SIGN UP
              ElevatedButton(
                onPressed: () {
                  Get.offNamed('/home_page');
                  widget.changeMainPageIndex(0);
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40),
                    backgroundColor: const Color.fromARGB(255, 2, 155, 69),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text("Create!",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
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
    );
  }
}