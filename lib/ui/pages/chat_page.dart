import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/model/message.dart';
import '../controllers/authentication_controller.dart';
import '../controllers/chatController.dart';


// Widget con la interfaz del chat
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // controlador para el text input
  late TextEditingController _controller;
  // controlador para el sistema de scroll de la lista
  late ScrollController _scrollController;
  late String remoteUserUid;
  late String remoteEmail;
  late String remoteName;

  // obtenemos los parámetros del sistema de navegación
  dynamic argumentData = Get.arguments;

  // obtenemos las instancias de los controladores
  ChatController chatController = Get.find();
  AuthenticationController authenticationController = Get.find();

  @override
  void initState() {
    super.initState();
    // obtenemos los datos del usuario con el cual se va a iniciar el chat de los argumentos
    remoteUserUid = argumentData[0];
    remoteEmail = argumentData[1];
    remoteName = argumentData[2];

    // instanciamos los controladores
    _controller = TextEditingController();
    _scrollController = ScrollController();

    // Le pedimos al chatController que se suscriba los chats entre los dos usuarios
    chatController.subscribeToUpdated(remoteUserUid);
  }

  @override
  void dispose() {
    // proceso de limpieza
    _controller.dispose();
    _scrollController.dispose();
    chatController.unsubscribe();
    super.dispose();
  }

  Widget _item(Message element, int posicion, String uid) {
    return Row(
      mainAxisAlignment: uid == element.senderUid
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Card(
            // Forma del texto dependiendo del usuario
            shape: uid == element.senderUid
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  )
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
            // Márgenes
            margin: uid == element.senderUid
                ? const EdgeInsets.fromLTRB(120, 4, 3, 0)
                : const EdgeInsets.fromLTRB(3, 4, 120, 0),
            color: uid == element.senderUid
                ? const Color.fromARGB(255, 13, 147, 71)
                : const Color.fromARGB(255, 0, 39, 93),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                element.msg,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                ),
                textAlign:
                    uid == element.senderUid ? TextAlign.right : TextAlign.left,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _list() {
    String uid = authenticationController.getUid();
    logInfo('Current user $uid');
    // Escuchamos la lista de mensajes entre los dos usuarios usando el ChatController
    return GetX<ChatController>(builder: (controller) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
      return ListView.builder(
        itemCount: chatController.messages.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var element = chatController.messages[index];
          return _item(element, index, uid);
        },
      );
    });
  }

  Future<void> _sendMsg(String text) async {
    // enviamos un nuevo mensaje usando el ChatController
    logInfo("Calling _sendMsg with $text");
    await chatController.sendChat(remoteUserUid, text);
  }

  Widget _textInput() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, top: 5.0, right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: TextField(
                style: const TextStyle(fontFamily: "Montserrat"),
                key: const Key('MsgTextField'),
                decoration: const InputDecoration(
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 97, 97, 97),
                        fontFamily: "Montserrat"),
                    border: OutlineInputBorder(),
                    labelText: 'Your message',
                    floatingLabelBehavior: FloatingLabelBehavior.never),
                onSubmitted: (value) {
                  _sendMsg(_controller.text);
                  _controller.clear();
                },
                controller: _controller,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            key: const Key('sendButton'),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _sendMsg(_controller.text);
                _controller.clear();
              }
            },
            backgroundColor: const Color.fromARGB(255, 2, 155, 69),
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    );
  }

  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 11, 44),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text("Chat with $remoteName",
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'Montserrat')),
          backgroundColor: const Color.fromARGB(255, 0, 51, 124),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.1), // Altura de la línea
            child: Divider(
              color: Color.fromARGB(80, 255, 255, 255), // Color de la línea
              height: 0.0, // Grosor de la línea
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 25.0),
          child: Column(
            children: [
              Expanded(flex: 4, child: _list()),
              const SizedBox(height: 10),
              _textInput()
            ],
          ),
        ));
  }
}
