import 'package:flutter/material.dart';

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

  final screens = const [
    MapTab(),
    ChatTab(),
    ProfileTab(),
  ];

  IconData currentFloatingButtonIcon = Icons.location_on;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    Color uiColor = const Color.fromARGB(255, 0, 51, 124);
    Color iconColor = Colors.white;
    Color selIconColor = Colors.white;

    // Actualizar el ícono del Floating Button
    if (currentIndex == 0) {
      currentFloatingButtonIcon = Icons.location_on;
    } else if (currentIndex == 1) {
      currentFloatingButtonIcon = Icons.person_add;
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          title: const Text(
            'YouShare',
            style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
          ),
          backgroundColor: uiColor,
          centerTitle: true),
      // Utiliza PageView en lugar de un solo widget para cambiar las páginas
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // No deslizamiento manual
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
      floatingActionButton: currentIndex != 2
          ? Padding(
              padding: const EdgeInsets.only(top: 10, right: 20),
              child: FloatingActionButton(
                onPressed: () {
                  if (currentIndex == 0) {
                    print("map");
                  } else if (currentIndex == 1) {
                    print("chat");
                  }
                },
                backgroundColor: const Color.fromARGB(255, 2, 155, 69),
                child: Icon(currentFloatingButtonIcon),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
