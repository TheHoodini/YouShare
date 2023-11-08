import 'package:get/get.dart';

class UserController extends GetxController {
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
  bool checkAccountValid() => true;
  bool createAccount() => true;
}
