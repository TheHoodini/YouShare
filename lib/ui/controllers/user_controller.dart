import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/model/user.dart';
import 'authentication_controller.dart';

class UserController extends GetxController {
  AuthenticationController authenticationController = Get.find();

  final _username = 'username'.obs;
  final _name = 'Name'.obs;
  final _email = 'name@mail.com'.obs;
  final _salute = 'Hey! I\'m using YouShare'.obs;

  final _isEditing = false.obs;

  String get username => _username.value;
  String get name => _name.value;
  String get email => _email.value;
  String get salute => _salute.value;
  bool get isEditing => _isEditing.value;

  setUsername(newValue) => _username.value = newValue;
  setName(newValue) => _name.value = newValue;
  setEmail(newValue) => _email.value = newValue;
  setSalute(newValue) => _salute.value = newValue;
  setIsEditing(newValue) => _isEditing.value = newValue;

  //Methods
  bool createAccount() => true;

  // controller chat part
  // lista en la que se almacenan los uaurios, la misma es observada por la UI
  var _users = <AppUser>[].obs;

  final databaseRef = FirebaseDatabase.instance.ref();

  late StreamSubscription<DatabaseEvent> newEntryStreamSubscription;

  late StreamSubscription<DatabaseEvent> updateEntryStreamSubscription;

  // devolvemos a la UI todos los usuarios excepto el que está logeado en el sistema
  // esa lista será usada para la pantalla en la que listan los usuarios con los que se
  // puede comenzar una conversación
  get users {
    return _users
        .where((entry) => entry.uid != authenticationController.getUid())
        .toList();
  }

  get allUsers => _users;

  // método para comenzar a escuchar cambios en la "tabla" userList de la base de
  // datos
  void start() {
    _users.clear();

    newEntryStreamSubscription =
        databaseRef.child("userList").onChildAdded.listen(_onEntryAdded);

    updateEntryStreamSubscription =
        databaseRef.child("userList").onChildChanged.listen(_onEntryChanged);
  }

  // método para dejar de escuchar cambios
  void stop() {
    newEntryStreamSubscription.cancel();
    updateEntryStreamSubscription.cancel();
  }

  // cuando obtenemos un evento con un nuevo usuario lo agregamos a _users
  _onEntryAdded(DatabaseEvent event) {
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _users.add(AppUser.fromJson(event.snapshot, json));
  }

  // cuando obtenemos un evento con un usuario modificado lo reemplazamos en _users
  // usando el key como llave
  _onEntryChanged(DatabaseEvent event) {
    var oldEntry = _users.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    final json = event.snapshot.value as Map<dynamic, dynamic>;
    _users[_users.indexOf(oldEntry)] = AppUser.fromJson(event.snapshot, json);
  }

  // método para crear un nuevo usuario
  Future<void> createUser(name, username, email, uid) async {
    logInfo("Creating user in realTime for $email and $uid");
    try {
      await databaseRef.child('userList').push().set({
        'name': name,
        'username': username,
        'email': email,
        'salute': 'Using YouShare',
        'uid': uid
      });
    } catch (error) {
      logError(error);
      return Future.error(error);
    }
  }

  void login(String user, String password) async {
    // método usado para login
    await authenticationController.login(user, password);
  }

  void setUserData(mail) {
    for (var i = 0; i < allUsers.length; i++) {
      if (allUsers[i].email == mail) {
        AppUser user = allUsers[i];
        setName(user.name);
        setUsername(user.username);
        setEmail(mail);
        setSalute(user.salute);
      }
    }
  }
}
