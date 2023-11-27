import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

// este controlador esconde los detalles de la implementación de firebase
class AuthenticationController extends GetxController {
  // método usado para logearse en la aplicación
  Future<void> login(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Future.value();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error("User not found");
      } else if (e.code == 'wrong-password') {
        return Future.error("Wrong password");
      }
    }
  }

  // método usado para crear un usuario
  Future<void> signup(name, username, email, password) async {
    try {
      // primero creamos el usuario en el sistema de autenticación de firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      UserController userController = Get.find();

      // después creamos el usuario en la base de datos de tiempo real usando el
      // userController
      await userController.createUser(
          name, username, email, userCredential.user!.uid);
      return Future.value();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error("The password is too weak");
      } else if (e.code == 'email-already-in-use') {
        return Future.error("The email is taken");
      }
    }
  }

  Future<void> editUser(
      name, username, salute, email, password, key, friendList, location) async {
    try {
      UserController userController = Get.find();

      var uid = "";

      try {
        uid = getUid();
      } catch (e) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        uid = userCredential.user!.uid;
      }

      await userController.updateUser(
          name, username, salute, email, uid, key, friendList, location);
      return Future.value();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error("The password is too weak");
      } else if (e.code == 'email-already-in-use') {
        return Future.error("The email is taken");
      }
    }
  }

  // método usado para hacer el signOut
  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Future.error("Logout error");
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }

  String getUid() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
  }
}
