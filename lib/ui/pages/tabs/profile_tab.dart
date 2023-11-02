// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final double coverHeight = 170;
  final double profileHeight = 144;
  final Color uiColor = const Color.fromARGB(255, 2, 11, 44);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileHeight / 2 + 5;
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom), child: buildCoverImage()),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset("../../../../assets/landscape.jpg",
            width: double.infinity, height: coverHeight, fit: BoxFit.cover),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: uiColor,
        child: Image.asset("../../../../assets/user.png", height: 130),
      );

  buildContent() => Column(
        // TEXTOS DEL NOMBRE DE USUARIO
        children: [
          const Text('Test User',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold)),
          const Text('@UserMan08',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, 
                  fontFamily: "Montserrat")),
          const SizedBox(
            height: 30,
          ),
          // ---------------------------
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 0.0,
                ),
                // BOTÓN LOG OUT
                ElevatedButton(
                  onPressed: () => Get.offNamed('/login_page'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40),
                    backgroundColor: const Color.fromARGB(255, 2, 155, 69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                ),
                //
                const SizedBox(
                  width: 0.0,
                ),
              ]),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
