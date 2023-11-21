
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/auth_page.dart';
import 'pages/home_page.dart';

class CentralHub extends StatelessWidget {
  const CentralHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const AuthPage();
          }
        });
  }
}