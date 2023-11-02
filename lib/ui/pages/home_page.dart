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
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  final screens = [
    MapTab(),
    ChatTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
            title: const Text(
              'YouShare',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Montserrat'),
            ),
            backgroundColor: Color.fromARGB(255, 2, 2, 48),
            centerTitle: true),
      // Utiliza PageView en lugar de un solo widget para cambiar las páginas
      body: PageView(
        controller: _pageController,
        //physics: NeverScrollableScrollPhysics(), // No deslizamiento manual
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: 70,
        decoration: BoxDecoration(
          //color: Colors.white,
          boxShadow: [
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
            data: const NavigationBarThemeData(
              indicatorColor: Color.fromARGB(0, 13, 42, 158),
              labelTextStyle: MaterialStatePropertyAll(TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              )),
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            ),
            child: NavigationBar(
              backgroundColor: Color.fromARGB(255, 1, 1, 28),
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  currentIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.travel_explore, color: Colors.grey),
                  selectedIcon: Icon(Icons.travel_explore, color: Colors.blue),
                  label: "Map",
                ),
                NavigationDestination(
                  icon: Icon(Icons.forum, color: Colors.grey),
                  selectedIcon: Icon(Icons.forum, color: Colors.blue),
                  label: "Chat",
                ),
                NavigationDestination(
                  icon: Icon(Icons.account_circle, color: Colors.grey),
                  selectedIcon: Icon(Icons.account_circle, color: Colors.blue),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
