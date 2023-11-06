import 'package:get/get.dart';

class UserController extends GetxController {
  final _username = '@username'.obs;
  final _name = 'Name'.obs;
  final _email = 'name@mail.com'.obs;
  final _salute = 'Hey! I\'m using YouShare'.obs;

  String get username => _username.value;
  String get name => _name.value;
  String get email => _email.value;
  String get salute => _salute.value;

  setUsername(newValue) => _username.value = newValue;
  setName(newValue) => _name.value = newValue;
  setEmail(newValue) => _email.value = newValue;
  setSalute(newValue) => _salute.value = newValue;
}
