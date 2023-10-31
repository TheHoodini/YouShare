import 'package:flutter/material.dart';

//tabs
import 'package:proychat/ui/pages/tabs/location_tab.dart';
import 'package:proychat/ui/pages/tabs/chat_tab.dart';
import 'package:proychat/ui/pages/tabs/add_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    LocationTab(),
    ChatTab(),
    AddTab(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(126, 0, 0, 0),
                  spreadRadius: 0,
                  blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: NavigationBarTheme(
              data: const NavigationBarThemeData(
                  indicatorColor: Color.fromARGB(0, 12, 12, 12),
                  labelTextStyle: MaterialStatePropertyAll(TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat")),
                  labelBehavior:
                      NavigationDestinationLabelBehavior.onlyShowSelected),
              child: NavigationBar(
                backgroundColor: Color.fromARGB(255, 16, 12, 12),
                selectedIndex: index,
                onDestinationSelected: (index) => {
                  setState(
                    () => this.index = index,
                  )
                },
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.travel_explore,
                      color: Color.fromARGB(255, 93, 93, 93)),
                      selectedIcon: Icon(Icons.travel_explore, color: Colors.blue),
                      label: "Map"),
                  NavigationDestination(
                      icon: Icon(Icons.forum,
                      color: Color.fromARGB(255, 93, 93, 93)),
                      selectedIcon: Icon(Icons.forum, color: Colors.blue),
                      label: "Chat"),
                  NavigationDestination(
                      icon: Icon(Icons.person_add,
                      color: Color.fromARGB(255, 93, 93, 93)),
                      selectedIcon: Icon(Icons.person_add, color: Colors.blue),
                      label: "Add"),
                ],
              ),
            ),
          ),
        ),
      );
}
