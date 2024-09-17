import 'package:flutter/material.dart';
import 'package:imtxon/views/screen/daromad_screen.dart';
import 'package:imtxon/views/screen/harajatlar_screen.dart';
import 'package:imtxon/views/screen/home_screen.dart';

class ManegScreen extends StatefulWidget {
  const ManegScreen({super.key});

  @override
  State<ManegScreen> createState() => _ManegScreenState();
}

class _ManegScreenState extends State<ManegScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    HarajatlarScreen(),
    DaromadScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Harajatlar",
            icon: Icon(
              Icons.outbox_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "Daromadlar",
            icon: Icon(
              Icons.move_to_inbox_outlined,
            ),
          )
        ],
      ),
    );
  }
}
