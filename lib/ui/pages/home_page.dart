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
                indicatorColor: Colors.transparent,
                labelTextStyle: MaterialStatePropertyAll(
                  TextStyle(color: Color.fromARGB(255, 28, 130, 173), fontWeight: FontWeight.bold)),
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected
              ),
              child: NavigationBar(
                selectedIndex: index,
                onDestinationSelected: (index) => {
                  setState(
                    () => this.index = index,
                  )
                },
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.location_on, color: Color.fromARGB(255, 202, 202, 216)),
                      selectedIcon: Icon(Icons.location_on, color: Color.fromARGB(255, 28, 130, 173)),
                      label: "Location"),
                  NavigationDestination(
                      icon: Icon(Icons.forum, color: Color.fromARGB(255, 202, 202, 216)),
                      selectedIcon: Icon(Icons.forum, color: Color.fromARGB(255, 28, 130, 173)),
                      label: "Chat"),
                  NavigationDestination(
                      icon: Icon(Icons.person_add, color: Color.fromARGB(255, 202, 202, 216)), 
                      selectedIcon: Icon(Icons.person_add, color: Color.fromARGB(255, 28, 130, 173)),
                      label: "Add"),
                ],
              ),
            ),
          ),
        ),
      );
}
