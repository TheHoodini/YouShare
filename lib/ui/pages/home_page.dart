import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/authentication_controller.dart';
import 'package:proychat/ui/controllers/location_controller.dart';
import 'package:proychat/ui/controllers/user_controller.dart';

// Tabs
import 'package:proychat/ui/pages/tabs/map_tab.dart';
import 'package:proychat/ui/pages/tabs/chat_tab.dart';
import 'package:proychat/ui/pages/tabs/profile_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  bool sharingLocation = false;

  final screens = const [
    MapTab(),
    ChatTab(),
    ProfileTab(),
  ];

  IconData currentFloatingButtonIcon = Icons.location_on;
  UserController controller = Get.find();
  LocationController locController = Get.find();
  AuthenticationController aut_controller = Get.find();

  @override
  void initState() {
    // le decimos al userController que se suscriba a los streams
    controller.start();
    super.initState();
  }

  @override
  void dispose() {
    // le decimos al userController que se cierre los streams
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.setUserData(controller.email);
    print(controller.friends);
    double displayWidth = MediaQuery.of(context).size.width;
    Color uiColor = const Color.fromARGB(255, 0, 51, 124);
    Color iconColor = Colors.white;
    Color selIconColor = Colors.white;

    // Actualizar el ícono del Floating Button
    // MAP
    if (currentIndex == 0) {
      if (!sharingLocation) {
        currentFloatingButtonIcon = Icons.location_on;
      } else {
        currentFloatingButtonIcon = Icons.location_off;
      }
      // CHAT
    } else if (currentIndex == 1) {
      currentFloatingButtonIcon = Icons.person_add;
      // PROFILE
    } else if (currentIndex == 2) {
      currentFloatingButtonIcon = Icons.logout;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: uiColor,
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1), // Altura de la línea
          child: Divider(
            color: Color.fromARGB(80, 255, 255, 255), // Color de la línea
            height: 0.0, // Grosor de la línea
          ),
        ),
        title: const Text(
          'YouShare',
          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
        ),
      ),
      // Utiliza PageView en lugar de un solo widget para cambiar las páginas
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // No deslizamiento manual
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: 70,
        decoration: BoxDecoration(
          //color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(120, 0, 0, 0),
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: const Color.fromARGB(0, 13, 42, 158),
              labelTextStyle: MaterialStatePropertyAll(TextStyle(
                color: selIconColor,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              )),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
            ),
            child: NavigationBar(
              backgroundColor: uiColor,
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  currentIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                });
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.map_outlined, color: iconColor),
                  selectedIcon: Icon(Icons.map, color: selIconColor),
                  label: "Map",
                ),
                NavigationDestination(
                  icon: Icon(Icons.forum_outlined, color: iconColor),
                  selectedIcon: Icon(Icons.forum, color: selIconColor),
                  label: "Chat",
                ),
                NavigationDestination(
                  icon: Icon(Icons.account_circle_outlined, color: iconColor),
                  selectedIcon: Icon(Icons.account_circle, color: selIconColor),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10, right: 20),
        child: FloatingActionButton(
          onPressed: () async {
            // ACCIONES MAP
            if (currentIndex == 0) {
              if (!sharingLocation) {
                try {
                  await locController.getLocation();
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
                    locController.lastActualization.minute,
                    locController.setLastAct(TimeOfDay.now()),
                    // ignore: use_build_context_synchronously
                    showSnackbar(context, "Now sharing location",
                        Icons.where_to_vote_rounded),
                    setState(() {
                      sharingLocation = true;
                      currentFloatingButtonIcon = Icons.location_off;
                      locController.makerVisibility(sharingLocation);
                    })
                  ]);
                } catch (e) {
                  Get.snackbar("Error", e.toString(),
                      backgroundColor: const Color.fromARGB(255, 249, 195, 18),
                      colorText: Colors.black,
                      icon: const Icon(
                        Icons.warning_rounded,
                        color: Colors.black,
                      ));
                }
              } else {
                showSnackbar(context, "Location share ended",
                    Icons.wrong_location_rounded);
                setState(() {
                  sharingLocation = false;
                  currentFloatingButtonIcon = Icons.location_on;
                  locController.makerVisibility(sharingLocation);
                });
              }
              // ACCIONES CHAT
            } else if (currentIndex == 1) {
              Get.toNamed('/add_page');
              // ACCIONES PROFILE
            } else if (currentIndex == 2) {
              aut_controller.logout();
              locController.makerVisibility(false);
            }
          },
          backgroundColor: const Color.fromARGB(255, 2, 155, 69),
          child: Icon(currentFloatingButtonIcon),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String texto, IconData icono) =>
      Flushbar(
        icon: Icon(icono, size: 32, color: Colors.white),
        shouldIconPulse: false,
        messageText: Text(texto,
            style: const TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontWeight: FontWeight.w300)),
        duration: const Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.fromLTRB(140, 2, 140, 0),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        //barBlur: 20,
        backgroundColor: const Color.fromARGB(255, 2, 155, 69),
      )..show(context);
}
